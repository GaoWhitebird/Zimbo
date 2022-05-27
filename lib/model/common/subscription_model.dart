class SubscriptionModel {
  String isSubscription;
  String isHistory;
  String nextDay;
  String cost;

  SubscriptionModel({
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

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    isSubscription: json['subscription'], 
    isHistory: json['history'],
    nextDay: json['next_day'],
    cost: json['cost'],
  );
}