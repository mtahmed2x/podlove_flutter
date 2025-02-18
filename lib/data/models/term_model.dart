class TermModel {
  String text;

  TermModel({
    required this.text,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
    text: json["text"],
  );
}