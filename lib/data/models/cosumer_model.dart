class ConsumerModel {
  String text;

  ConsumerModel({
    required this.text,
  });

  factory ConsumerModel.fromJson(Map<String, dynamic> json) => ConsumerModel(
    text: json["text"],
  );
}