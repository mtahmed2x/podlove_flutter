import 'package:podlove_flutter/data/models/auth_model.dart';

class UserModel {
  final Auth auth;
  final Personality personality;
  final Location location;
  final Preferences preferences;
  final Subscription subscription;
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final int age;
  final String gender;
  final String bodyType;
  final String ethnicity;
  final String bio;
  final String avatar;
  final List<String> interests;
  final List<String> compatibility;
  final List<String> survey;

  UserModel({
    required this.auth,
    required this.personality,
    required this.location,
    required this.preferences,
    required this.subscription,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.age,
    required this.gender,
    required this.bodyType,
    required this.ethnicity,
    required this.bio,
    required this.interests,
    required this.avatar,
    required this.compatibility,
    required this.survey,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        auth: Auth.fromJson(json["auth"]),
        personality: Personality.fromJson(json["personality"]),
        location: Location.fromJson(json["location"]),
        preferences: Preferences.fromJson(json["preferences"]),
        subscription: Subscription.fromJson(json["subscription"]),
        id: json["_id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        age: json["age"],
        gender: json["gender"],
        bodyType: json["bodyType"],
        ethnicity: json["ethnicity"],
        bio: json["bio"],
        avatar: json["avatar"],
        interests: List<String>.from(json["interests"].map((x) => x)),
        compatibility: List<String>.from(json["compatibility"].map((x) => x)),
        survey: List<String>.from(json["survey"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "personality": personality.toJson(),
        "location": location.toJson(),
        "preferences": preferences.toJson(),
        "subscription": subscription.toJson(),
        "address": address,
        "age": age,
        "gender": gender,
        "bodyType": bodyType,
        "ethnicity": ethnicity,
        "bio": bio,
        "avatar": avatar,
        "interests": List<String>.from(interests.map((x) => x)),
        "compatibility": List<String>.from(compatibility.map((x) => x)),
        "survey": List<String>.from(survey.map((x) => x)),
      };

  UserModel copyWith({
    Auth? auth,
    Personality? personality,
    Location? location,
    Preferences? preferences,
    Subscription? subscription,
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    int? age,
    String? gender,
    String? bodyType,
    String? ethnicity,
    String? bio,
    String? avatar,
    List<String>? interests,
    List<String>? compatibility,
    List<String>? survey,
  }) {
    return UserModel(
      auth: auth ?? this.auth,
      personality: personality ?? this.personality,
      location: location ?? this.location,
      preferences: preferences ?? this.preferences,
      subscription: subscription ?? this.subscription,
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      bodyType: bodyType ?? this.bodyType,
      ethnicity: ethnicity ?? this.ethnicity,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      interests: interests ?? this.interests,
      compatibility: compatibility ?? this.compatibility,
      survey: survey ?? this.survey,
    );
  }
}

class Auth {
  final String id;
  final String email;

  Auth({
    required this.id,
    required this.email,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    id: json["_id"],
    email: json["email"],
  );
}


class Location {
  final String place;
  final double longitude;
  final double latitude;

  Location({
    required this.place,
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        place: json["place"] ?? '',
        longitude: (json["longitude"] as num).toDouble(),
        latitude: (json["latitude"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "longitude": longitude,
        "latitude": latitude,
      };

  Location copyWith({
    String? place,
    double? longitude,
    double? latitude,
  }) {
    return Location(
      place: place ?? this.place,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}

class Personality {
  final int spectrum;
  final int balance;
  final int focus;

  Personality({
    required this.spectrum,
    required this.balance,
    required this.focus,
  });

  factory Personality.fromJson(Map<String, dynamic> json) => Personality(
        spectrum: json["spectrum"],
        balance: json["balance"],
        focus: json["focus"],
      );

  Map<String, dynamic> toJson() => {
        "spectrum": spectrum,
        "balance": balance,
        "focus": focus,
      };

  Personality copyWith({
    int? spectrum,
    int? balance,
    int? focus,
  }) {
    return Personality(
      spectrum: spectrum ?? this.spectrum,
      balance: balance ?? this.balance,
      focus: focus ?? this.focus,
    );
  }
}

class Preferences {
  final Age age;
  final String gender;
  final String bodyType;
  final String ethnicity;
  final int distance;

  Preferences({
    required this.age,
    required this.gender,
    required this.bodyType,
    required this.ethnicity,
    required this.distance,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
        age: Age.fromJson(json["age"]),
        gender: json["gender"],
        bodyType: json["bodyType"],
        ethnicity: json["ethnicity"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "age": age.toJson(),
        "gender": gender,
        "bodyType": bodyType,
        "ethnicity": ethnicity,
        "distance": distance,
      };

  Preferences copyWith({
    Age? age,
    String? gender,
    String? bodyType,
    String? ethnicity,
    int? distance,
  }) {
    return Preferences(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      bodyType: bodyType ?? this.bodyType,
      ethnicity: ethnicity ?? this.ethnicity,
      distance: distance ?? this.distance,
    );
  }
}

class Age {
  final int min;
  final int max;

  Age({
    required this.min,
    required this.max,
  });

  factory Age.fromJson(Map<String, dynamic> json) => Age(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };

  Age copyWith({
    int? min,
    int? max,
  }) {
    return Age(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }
}

class Subscription {
  final String plan;
  final String fee;
  final String status;
  final DateTime startedAt;

  Subscription({
    required this.plan,
    required this.fee,
    required this.status,
    required this.startedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        plan: json["plan"],
        fee: json["fee"],
        status: json["status"],
        startedAt: DateTime.parse(json["startedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "plan": plan,
        "fee": fee,
        "status": status,
        "startedAt": startedAt.toIso8601String(),
      };

  Subscription copyWith({
    String? plan,
    String? fee,
    String? status,
    DateTime? startedAt,
  }) {
    return Subscription(
      plan: plan ?? this.plan,
      fee: fee ?? this.fee,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
    );
  }
}
