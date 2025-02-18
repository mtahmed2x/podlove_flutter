class FaqModel {
  final String question;
  final String answer;

  FaqModel({
    required this.question,
    required this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    question: json["question"] ?? "",
    answer: json["answer"] ?? "",
  );

  static List<FaqModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FaqModel.fromJson(json)).toList();
  }
}