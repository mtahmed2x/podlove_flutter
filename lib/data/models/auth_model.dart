class AuthModel {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final bool isBlocked;

  AuthModel({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    required this.isBlocked,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["_id"],
        email: json["email"],
        role: json["role"],
        isVerified: json["isVerified"],
        isBlocked: json["isBlocked"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "role": role,
        "isVerified": isVerified,
        "isBlocked": isBlocked,
      };
}
