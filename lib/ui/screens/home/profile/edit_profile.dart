import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podlove_flutter/constants/app_colors.dart';
import 'package:podlove_flutter/constants/app_strings.dart';
import 'package:podlove_flutter/providers/bio_check_providers.dart';
import 'package:podlove_flutter/providers/user_provider.dart';
import 'package:podlove_flutter/routes/route_path.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';
import 'package:podlove_flutter/ui/widgets/custom_drop_down.dart';
import 'package:podlove_flutter/ui/widgets/custom_round_button.dart';
import 'package:podlove_flutter/ui/widgets/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/utils/logger.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  String getLastTwoParts(String input) {
    List<String> parts = input.split(',').map((e) => e.trim()).toList();
    return parts.length >= 2 ? '${parts[parts.length - 2]}, ${parts.last}' : input;
  }

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _genderPreferenceController = TextEditingController();
  final _locationController = TextEditingController();
  final _nameFocus = FocusNode();

  String? _nameError;
  String? _bioError;
  double? _latitude;
  double? _longitude;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider)?.user;

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        setState(() => _nameError = _validateName(_nameController.text));
      }
    });

    if (user != null) {
      _nameController.text = user.name ?? '';
      _bioController.text = user.bio ?? '';
      _locationController.text = widget.getLastTwoParts(user.location?.place ?? '');
      _genderPreferenceController.text = user.gender ?? '';
      _latitude = user.location?.latitude;
      _longitude = user.location?.longitude;
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '* Name is required';
    } else if (value.trim().length < 3) {
      return '* Name must be at least 3 characters';
    }
    return null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      logger.i(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    final bioCheckState = ref.watch(bioCheckProvider);
    final bioCheckNotifier = ref.read(bioCheckProvider.notifier);

    ref.listen(bioCheckProvider, (prev, current) async {
      if (current.isLoading == false && current.isSuccess == false && current.error != null) {
        setState(() => _bioError = current.error);
      } else if (current.isLoading == false && current.isSuccess == true) {
        setState(() => _bioError = null);

        final currentUser = userState!.user!;
        if (_selectedImage != null) userNotifier.uploadAvatar(_selectedImage!);
        if (_nameController.text != currentUser.name) userNotifier.updateName(_nameController.text);
        if (_bioController.text != currentUser.bio) userNotifier.updateBio(_bioController.text);
        if (_genderPreferenceController.text != currentUser.gender) userNotifier.updateGender(_genderPreferenceController.text);
        if (_latitude != null && _longitude != null &&
            (_locationController.text != widget.getLastTwoParts(currentUser.location?.place ?? '') ||
                _latitude != currentUser.location?.latitude ||
                _longitude != currentUser.location?.longitude)) {
          userNotifier.updateLocation(
            _latitude!,
            _longitude!,
            _locationController.text,
          );
        }

        try {
          await userNotifier.update();
          context.pop();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update profile: $e")),
          );
        }
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
        isLeading: true,
        onPressed: () => context.push(RouterPath.home, extra: 3),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : NetworkImage(userState?.user?.avatar ?? '') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 161, 117),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                              ],
                            ),
                            child: Image.asset('assets/images/camera.png', width: 18, height: 18, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Full Name",
                  controller: _nameController,
                  focusNode: _nameFocus,
                  errorText: _nameError,
                  onChanged: (_) {
                    if (_nameError != null) setState(() => _nameError = null);
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  label: "Bio",
                  controller: _bioController,
                  maxLines: 5,
                  errorText: _bioError,
                ),
                SizedBox(height: 10.h),
                CustomDropdown<String>(
                  label: "Gender",
                  options: [
                    AppStrings.female,
                    AppStrings.male,
                    AppStrings.nonBinary,
                    AppStrings.transgender,
                    AppStrings.genderFluid,
                  ],
                  initialValue: userState?.user?.gender ?? AppStrings.male,
                  onChanged: (selectedValue) {
                    _genderPreferenceController.text = selectedValue;
                  },
                ),
                SizedBox(height: 20.h),
                GooglePlaceAutoCompleteTextField(
                  textEditingController: _locationController,
                  googleAPIKey: "AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4",
                  debounceTime: 50,
                  countries: ["us"],
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    _latitude = double.parse(prediction.lat!);
                    _longitude = double.parse(prediction.lng!);
                  },
                  textInputAction: TextInputAction.done,
                  itemClick: (Prediction prediction) {
                    _locationController.text = prediction.description!;
                    _locationController.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length));
                    FocusScope.of(context).unfocus();
                  },
                  itemBuilder: (context, index, Prediction prediction) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 7),
                          Expanded(child: Text(prediction.description ?? ""))
                        ],
                      ),
                    );
                  },
                  seperatedBuilder: Divider(),
                  isCrossBtnShown: true,
                  containerHorizontalPadding: 10,
                  placeType: PlaceType.geocode,
                ),
                SizedBox(height: 30.h),
                CustomRoundButton(
                  text: bioCheckState.isLoading ? "Saving..." : "Save",
                  onPressed: bioCheckState.isLoading
                      ? null
                      : () async {
                    final text = _bioController.text.trim();
                    final wordCount = text.split(RegExp(r'\s+')).length;
                    if (text.isEmpty) {
                      setState(() => _bioError = "Please write down your bio!");
                    } else if (wordCount < 5) {
                      setState(() => _bioError = "Your bio must be at least 5 words.");
                    } else if (wordCount > 200) {
                      setState(() => _bioError = "Your bio must not exceed 200 words.");
                    } else {
                      setState(() => _bioError = null);
                      await bioCheckNotifier.bioCheck(text);
                    }
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _genderPreferenceController.dispose();
    _locationController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }
}
