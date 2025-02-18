class PrivacyModel {
  final String text;

  PrivacyModel({
    required this.text,
  });

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    text: json["text"],
  );
}