import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:podlove_flutter/data/models/auth_model.dart';
import 'package:podlove_flutter/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:podlove_flutter/data/services/api_services.dart';
import 'package:podlove_flutter/providers/global_providers.dart';
import 'package:podlove_flutter/utils/logger.dart';

class UserState {
  final UserModel user;
  final bool isLoading;
  final bool? isSuccess;
  final String? error;

  UserState({
    required this.user,
    this.isLoading = false,
    this.isSuccess,
    this.error,
  });

  UserState copyWith({
    String? accessToken,
    AuthModel? auth,
    UserModel? user,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class UserNotifier extends StateNotifier<UserState?> {
  final ApiServices apiService;

  UserNotifier(this.apiService) : super(null);

  void initialize(Map<String, dynamic> json) {
    state = UserState(
      user: UserModel.fromJson(json),
    );
  }

  void _updateUser(UserModel newUser) {
    if (state != null) {
      state = state!.copyWith(user: newUser);
    }
  }

  Future<void> updateLocation(double lat, double lng, String placeName) async {
    if (state == null) return;

    final newLocation = Location(
      place: placeName,
      latitude: lat,
      longitude: lng,
    );

    final updatedUser = state!.user.copyWith(location: newLocation);
    _updateUser(updatedUser);
  }

  void updateName(String newName) {
    if (state == null) return;
    final updatedUser = state!.user.copyWith(name: newName);
    _updateUser(updatedUser);
  }

  void updatePhoneNumber(String newPhoneNumber) {
    if (state == null) return;
    final updatedUser = state!.user.copyWith(phoneNumber: newPhoneNumber);
    _updateUser(updatedUser);
  }

  void updateDistancePreference(int newDistance) {
    if (state == null) return;

    final newPreferences = state!.user.preferences.copyWith(
      distance: newDistance,
    );

    final updatedUser = state!.user.copyWith(preferences: newPreferences);
    _updateUser(updatedUser);
  }

  void updateAge(int newAge) {
    final updatedUser = state!.user.copyWith(age: newAge);
    _updateUser(updatedUser);
  }

  void updatePreferencesAgeRange(int min, int max) {
    final newPreferences = state!.user.preferences.copyWith(
      age: state!.user.preferences.age.copyWith(min: min, max: max),
    );
    final updatedUser = state!.user.copyWith(preferences: newPreferences);
    _updateUser(updatedUser);
  }

  void updateGender(String newGender) {
    if (state == null) return;

    final updatedUser = state!.user.copyWith(gender: newGender);
    _updateUser(updatedUser);
  }

  void updatePreferredGender(String newPreferredGender) {
    final newPreferences =
        state!.user.preferences.copyWith(gender: newPreferredGender);
    final updatedUser = state!.user.copyWith(preferences: newPreferences);
    _updateUser(updatedUser);
  }

  void updateBodyType(String newBodyType) {
    if (state == null) return;

    final updatedUser = state!.user.copyWith(bodyType: newBodyType);
    _updateUser(updatedUser);
  }

  void updatePreferredBodyType(String newPreferredBodyType) {
    if (state == null) return;

    final newPreferences =
        state!.user.preferences.copyWith(bodyType: newPreferredBodyType);
    final updatedUser = state!.user.copyWith(preferences: newPreferences);

    _updateUser(updatedUser);
  }

  void updateEthnicity(String newEthnicity) {
    if (state == null) return;
    final updatedUser = state!.user.copyWith(ethnicity: newEthnicity);
    _updateUser(updatedUser);
  }

  void updatePreferredEthnicity(String newPreferredEthnicity) {
    if (state == null) return;

    final newPreferences =
        state!.user.preferences.copyWith(ethnicity: newPreferredEthnicity);
    final updatedUser = state!.user.copyWith(preferences: newPreferences);

    _updateUser(updatedUser);
  }

  void updateBio(String newBio) {
    final updatedUser = state!.user.copyWith(bio: newBio);
    _updateUser(updatedUser);
  }

  void updateInterests(List<String> newInterests) {
    if (state == null) return;

    final updatedUser = state!.user.copyWith(interests: newInterests);
    _updateUser(updatedUser);
  }

  void updatePersonalityTrait(String trait, int value) {
    if (state == null) return;

    final updatedPersonality = state!.user.personality.copyWith(
      spectrum: trait == "spectrum" ? value : state!.user.personality.spectrum,
      balance: trait == "balance" ? value : state!.user.personality.balance,
      focus: trait == "focus" ? value : state!.user.personality.focus,
    );

    final updatedUser = state!.user.copyWith(personality: updatedPersonality);
    _updateUser(updatedUser);
  }

  Future<bool> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ));

      final placeName =
          await _getPlaceName(position.latitude, position.longitude);

      updateLocation(
        position.latitude,
        position.longitude,
        placeName,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  void updateCompatibilityAnswers(Map<int, String> answers) {
    if (state == null) return;

    final updatedCompatibility = List<String>.from(state!.user.compatibility);
    answers.forEach((index, value) {
      if (index < updatedCompatibility.length) {
        updatedCompatibility[index] = value;
      } else {
        updatedCompatibility.add(value);
      }
    });

    final updatedUser =
        state!.user.copyWith(compatibility: updatedCompatibility);
    state = state!.copyWith(user: updatedUser);
  }

  Future<String> _getPlaceName(double lat, double lng) async {
    final apiKey = 'AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4';
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?'
          'latlng=$lat,$lng&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'][0]['formatted_address'] ?? 'Unknown location';
    }
    return 'Unknown location';
  }

  Future<void> uploadAvatar(File imageFile) async {
    if (state == null) return;

    final String cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/dvjbfwhxe/image/upload';
    final String uploadPreset = 'podlove_upload';

    state = state!.copyWith(isLoading: true, error: null);

    try {
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        logger.i('Upload successful: ${res.body}');
        final responseData = json.decode(res.body);

        final imageUrl = responseData['secure_url'];
        logger.i('Upload successful: $imageUrl');

        final updatedUser = state!.user.copyWith(avatar: imageUrl);

        state = state!.copyWith(
          user: updatedUser,
          isLoading: false,
          error: null,
        );
      } else {
        final res = await http.Response.fromStream(response);
        final errorData = json.decode(res.body);
        logger.e(
            'Upload failed: ${response.statusCode} - ${errorData['error']['message']}');
        state = state!.copyWith(
          isLoading: false,
          error: errorData['error']['message'],
        );
        return;
      }
    } catch (e) {
      state = state!.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> update() async {
    if (state == null) return;

    try {
      state = state!.copyWith(isLoading: true, error: null);
      final userUpdateData = state!.user.toJson();

      logger.i(userUpdateData);

      final response = await apiService.patch(
        "/user/update/${state!.user.id}",
        data: userUpdateData,
      );

      logger.i(response);
      logger.i(response.data["data"]);

      final userResponse = UserModel.fromJson(response.data["data"]);
      logger.i(userResponse.name);

      state = state!.copyWith(
        isLoading: false,
        isSuccess: true,
        error: null,
      );
    } catch (e) {
      state = state!.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState?>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return UserNotifier(apiService);
});
