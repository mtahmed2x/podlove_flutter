class Podcast {
  final Schedule? schedule;
  final String? id;
  final String? primaryUser;
  final List<Participant>? participants;
  final dynamic selectedUser;
  final String? status;
  final String? recordingUrl;
  final int? v;

  Podcast({
    this.schedule,
    this.id,
    this.primaryUser,
    this.participants,
    this.selectedUser,
    this.status,
    this.recordingUrl,
    this.v,
  });

  Podcast copyWith({
    Schedule? schedule,
    String? id,
    String? primaryUser,
    List<Participant>? participants,
    dynamic selectedUser,
    String? status,
    String? recordingUrl,
    int? v,
  }) =>
      Podcast(
        schedule: schedule ?? this.schedule,
        id: id ?? this.id,
        primaryUser: primaryUser ?? this.primaryUser,
        participants: participants ?? this.participants,
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
        participants: json["participants"] == null
            ? []
            : List<Participant>.from(
                json["participants"].map((x) => Participant.fromJson(x))),
        selectedUser: json["selectedUser"],
        status: json["status"],
        recordingUrl: json["recordingUrl"],
        v: json["__v"],
      );
}

class Schedule {
  final String? date;
  final String? day;
  final String? time;

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
  final List<String>? interests;

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
    List<String>? interests,
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
            : List<String>.from(json["interests"].map((x) => x.toString())),
      );
}
