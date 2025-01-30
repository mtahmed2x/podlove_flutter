class AuthModel {
  final String id;
  final String email;

  AuthModel({
    required this.id,
    required this.email,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["_id"],
        email: json["email"],
      );
}
