class UserModel {
  final String id;
  final String auth;
  final String name;
  final String phoneNumber;
  final dynamic address;
  final List<dynamic> interests;
  final String avatar;
  final List<dynamic> compatibility;
  final List<dynamic> survey;

  UserModel({
    required this.id,
    required this.auth,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.interests,
    required this.avatar,
    required this.compatibility,
    required this.survey,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        auth: json["auth"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        interests: List<dynamic>.from(json["interests"].map((x) => x)),
        avatar: json["avatar"],
        compatibility: List<dynamic>.from(json["compatibility"].map((x) => x)),
        survey: List<dynamic>.from(json["survey"].map((x) => x)),
      );
}
