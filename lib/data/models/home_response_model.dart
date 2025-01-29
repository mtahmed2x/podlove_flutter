import 'dart:convert';

HomeResponseModel homeResponseModelFromJson(String str) =>
    HomeResponseModel.fromJson(json.decode(str));

class HomeResponseModel {
  final bool? success;
  final String? message;
  final HomeData? data;

  HomeResponseModel({
    this.success,
    this.message,
    this.data,
  });

  HomeResponseModel copyWith({
    bool? success,
    String? message,
    HomeData? data,
  }) =>
      HomeResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
      );
}

class HomeData {
  final Podcast? podcast;
  final List<SubscriptionPlan>? subscriptionPlans;

  HomeData({
    this.podcast,
    this.subscriptionPlans,
  });

  HomeData copyWith({
    Podcast? podcast,
    List<SubscriptionPlan>? subscriptionPlans,
  }) =>
      HomeData(
        podcast: podcast ?? this.podcast,
        subscriptionPlans: subscriptionPlans ?? this.subscriptionPlans,
      );

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        podcast:
            json["podcast"] == null ? null : Podcast.fromJson(json["podcast"]),
        subscriptionPlans: json["subscriptionPlans"] == null
            ? []
            : List<SubscriptionPlan>.from(json["subscriptionPlans"]!
                .map((x) => SubscriptionPlan.fromJson(x))),
      );
}

class Podcast {
  final Schedule? schedule;
  final String? id;
  final String? primaryUser;
  final Participant? participant1;
  final Participant? participant2;
  final Participant? participant3;
  final dynamic selectedUser;
  final String? status;
  final String? recordingUrl;
  final int? v;

  Podcast({
    this.schedule,
    this.id,
    this.primaryUser,
    this.participant1,
    this.participant2,
    this.participant3,
    this.selectedUser,
    this.status,
    this.recordingUrl,
    this.v,
  });

  Podcast copyWith({
    Schedule? schedule,
    String? id,
    String? primaryUser,
    Participant? participant1,
    Participant? participant2,
    Participant? participant3,
    dynamic selectedUser,
    String? status,
    String? recordingUrl,
    int? v,
  }) =>
      Podcast(
        schedule: schedule ?? this.schedule,
        id: id ?? this.id,
        primaryUser: primaryUser ?? this.primaryUser,
        participant1: participant1 ?? this.participant1,
        participant2: participant2 ?? this.participant2,
        participant3: participant3 ?? this.participant3,
        selectedUser: selectedUser ?? this.selectedUser,
        status: status ?? this.status,
        recordingUrl: recordingUrl ?? this.recordingUrl,
        v: v ?? this.v,
      );

  factory Podcast.fromJson(Map<String, dynamic> json) => Podcast(
        schedule: json["schedule"] == null
            ? null
            : Schedule.fromJson(json["schedule"]),
        id: json["_id"],
        primaryUser: json["primaryUser"],
        participant1: json["participant1"] == null
            ? null
            : Participant.fromJson(json["participant1"]),
        participant2: json["participant2"] == null
            ? null
            : Participant.fromJson(json["participant2"]),
        participant3: json["participant3"] == null
            ? null
            : Participant.fromJson(json["participant3"]),
        selectedUser: json["selectedUser"],
        status: json["status"],
        recordingUrl: json["recordingUrl"],
        v: json["__v"],
      );
}

class Schedule {
  String? date;
  String? day;
  String? time;

  Schedule({
    this.date,
    this.day,
    this.time,
  });

  Schedule copyWith({
    String? date,
    String? day,
    String? time,
  }) =>
      Schedule(
        date: date ?? this.date,
        day: day ?? this.day,
        time: time ?? this.time,
      );

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        date: json["date"],
        day: json["day"],
        time: json["time"],
      );
}

class Participant {
  final String? id;
  final String? name;
  final String? bio;
  final List<dynamic>? interests;

  Participant({
    this.id,
    this.name,
    this.bio,
    this.interests,
  });

  Participant copyWith({
    String? id,
    String? name,
    String? bio,
    List<dynamic>? interests,
  }) =>
      Participant(
        id: id ?? this.id,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        interests: interests ?? this.interests,
      );

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["_id"],
        name: json["name"],
        bio: json["bio"],
        interests: json["interests"] == null
            ? []
            : List<dynamic>.from(json["interests"]!.map((x) => x)),
      );
}

class SubscriptionPlan {
  final String? id;
  final String? name;
  final List<Description>? description;
  final String? unitAmount;
  final String? interval;
  final String? productId;
  final String? priceId;
  final int? v;

  SubscriptionPlan({
    this.id,
    this.name,
    this.description,
    this.unitAmount,
    this.interval,
    this.productId,
    this.priceId,
    this.v,
  });

  SubscriptionPlan copyWith({
    String? id,
    String? name,
    List<Description>? description,
    String? unitAmount,
    String? interval,
    String? productId,
    String? priceId,
    int? v,
  }) =>
      SubscriptionPlan(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        unitAmount: unitAmount ?? this.unitAmount,
        interval: interval ?? this.interval,
        productId: productId ?? this.productId,
        priceId: priceId ?? this.priceId,
        v: v ?? this.v,
      );

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
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
