class UserModel {
  final Personality personality;
  final Location location;
  final Preferences preferences;
  final Subscription subscription;
  final String id;
  final String auth;
  final String name;
  final String phoneNumber;
  final String address;
  final int age;
  final String gender;
  final String bodyType;
  final String ethnicity;
  final String bio;
  final List<dynamic> interests;
  final String avatar;
  final List<dynamic> compatibility;
  final List<dynamic> survey;

  UserModel({
    required this.personality,
    required this.location,
    required this.preferences,
    required this.subscription,
    required this.id,
    required this.auth,
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
        personality: Personality.fromJson(json["personality"]),
        location: Location.fromJson(json["location"]),
        preferences: Preferences.fromJson(json["preferences"]),
        subscription: Subscription.fromJson(json["subscription"]),
        id: json["_id"],
        auth: json["auth"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        age: json["age"],
        gender: json["gender"],
        bodyType: json["bodyType"],
        ethnicity: json["ethnicity"],
        bio: json["bio"],
        interests: List<dynamic>.from(json["interests"].map((x) => x)),
        avatar: json["avatar"],
        compatibility: List<dynamic>.from(json["compatibility"].map((x) => x)),
        survey: List<dynamic>.from(json["survey"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "personality": personality.toJson(),
        "location": location.toJson(),
        "preferences": preferences.toJson(),
        "subscription": subscription.toJson(),
        "_id": id,
        "auth": auth,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "age": age,
        "gender": gender,
        "bodyType": bodyType,
        "ethnicity": ethnicity,
        "bio": bio,
        "interests": List<dynamic>.from(interests.map((x) => x)),
        "avatar": avatar,
        "compatibility": List<dynamic>.from(compatibility.map((x) => x)),
        "survey": List<dynamic>.from(survey.map((x) => x)),
      };

  UserModel copyWith({
    Personality? personality,
    Location? location,
    Preferences? preferences,
    Subscription? subscription,
    String? id,
    String? auth,
    String? name,
    String? phoneNumber,
    String? address,
    int? age,
    String? gender,
    String? bodyType,
    String? ethnicity,
    String? bio,
    List<dynamic>? interests,
    String? avatar,
    List<dynamic>? compatibility,
    List<dynamic>? survey,
  }) {
    return UserModel(
      personality: personality ?? this.personality,
      location: location ?? this.location,
      preferences: preferences ?? this.preferences,
      subscription: subscription ?? this.subscription,
      id: id ?? this.id,
      auth: auth ?? this.auth,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      bodyType: bodyType ?? this.bodyType,
      ethnicity: ethnicity ?? this.ethnicity,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      avatar: avatar ?? this.avatar,
      compatibility: compatibility ?? this.compatibility,
      survey: survey ?? this.survey,
    );
  }
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
  final int fee;
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
    int? fee,
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
