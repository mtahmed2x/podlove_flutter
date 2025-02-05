import 'package:podlove_flutter/data/models/subscription_model.dart';
import 'package:podlove_flutter/data/models/user_model.dart';

class HomeModel {
  final Podcast? podcast;
  final List<SubscriptionModel>? subscriptionPlans;
  final UserModel? user;

  HomeModel({
    this.podcast,
    this.subscriptionPlans,
    this.user,
  });

  HomeModel copyWith({
    Podcast? podcast,
    List<SubscriptionModel>? subscriptionPlans,
    UserModel? user,
  }) =>
      HomeModel(
        podcast: podcast ?? this.podcast,
        subscriptionPlans: subscriptionPlans ?? this.subscriptionPlans,
        user: user ?? this.user,
      );

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        podcast:
            json["podcast"] == null ? null : Podcast.fromJson(json["podcast"]),
        subscriptionPlans: json["subscriptionPlans"] == null
            ? []
            : SubscriptionModel.fromJsonList(json["subscriptionPlans"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
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
