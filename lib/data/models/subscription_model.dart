class SubscriptionModel {
  final String? id;
  final String? name;
  final List<Description>? description;
  final String? unitAmount;
  final String? interval;
  final String? productId;
  final String? priceId;
  final int? v;

  SubscriptionModel({
    this.id,
    this.name,
    this.description,
    this.unitAmount,
    this.interval,
    this.productId,
    this.priceId,
    this.v,
  });

  SubscriptionModel copyWith({
    String? id,
    String? name,
    List<Description>? description,
    String? unitAmount,
    String? interval,
    String? productId,
    String? priceId,
    int? v,
  }) =>
      SubscriptionModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        unitAmount: unitAmount ?? this.unitAmount,
        interval: interval ?? this.interval,
        productId: productId ?? this.productId,
        priceId: priceId ?? this.priceId,
        v: v ?? this.v,
      );

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"] == null
            ? []
            : List<Description>.from(
            json["description"]!.map((x) => Description.fromJson(x))),
        unitAmount: json["unitAmount"],
        interval: json["interval"],
        productId: json["productId"],
        priceId: json["priceId"],
        v: json["__v"],
      );
}

class Description {
  final String? key;
  final String? details;
  final String? id;

  Description({
    this.key,
    this.details,
    this.id,
  });

  Description copyWith({
    String? key,
    String? details,
    String? id,
  }) =>
      Description(
        key: key ?? this.key,
        details: details ?? this.details,
        id: id ?? this.id,
      );

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    key: json["key"],
    details: json["details"],
    id: json["_id"],
  );
}
