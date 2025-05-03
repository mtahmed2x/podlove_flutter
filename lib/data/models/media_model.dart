class MediaModel {
  String text;

  MediaModel({
    required this.text,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
    text: json["text"],
  );
}