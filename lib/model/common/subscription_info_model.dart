class SubscriptionInfoModel {
  String isSubscription;
  String isHistory;
  String nextDay;
  String cost;

  SubscriptionInfoModel({
    required this.isSubscription,
    required this.isHistory,
    required this.nextDay,
    required this.cost,
  });

  Map<String, dynamic> toJson() => {
    'subscription': isSubscription,
    'history': isHistory,
    'next_day': nextDay,
    'cost': cost,
  };

  factory SubscriptionInfoModel.fromJson(Map<String, dynamic> json) => SubscriptionInfoModel(
    isSubscription: json['subscription'], 
    isHistory: json['history'],
    nextDay: json['next_day'],
    cost: json['cost'],
  );
}