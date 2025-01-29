class HomeResponse {
  final List<dynamic> podcast;
  final List<dynamic> subscriptionPlans;

  HomeResponse({
    required this.podcast,
    required this.subscriptionPlans,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      podcast: json['podcast'] as List<dynamic>,
      subscriptionPlans: json['subscriptionPlans'] as List<dynamic>,
    );
  }
}
