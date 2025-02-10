import 'package:podlove_flutter/data/models/podcast_model.dart';
import 'package:podlove_flutter/data/models/subscription_model.dart';
import 'package:podlove_flutter/data/models/user_model.dart';

class HomeModel {
  final UserModel? user;
  final Podcast? podcast;
  final List<SubscriptionModel>? subscriptionPlans;

  HomeModel({
    this.user,
    this.podcast,
    this.subscriptionPlans,
  });

  HomeModel copyWith({
    UserModel? user,
    Podcast? podcast,
    List<SubscriptionModel>? subscriptionPlans,
  }) =>
      HomeModel(
        user: user ?? this.user,
        podcast: podcast ?? this.podcast,
        subscriptionPlans: subscriptionPlans ?? this.subscriptionPlans,
      );

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        podcast:
            json["podcast"] == null ? null : Podcast.fromJson(json["podcast"]),
        subscriptionPlans: json["subscriptionPlans"] == null
            ? []
            : List<SubscriptionModel>.from(
                json["subscriptionPlans"].map(
                  (x) => SubscriptionModel.fromJson(x),
                ),
              ),
      );
}
