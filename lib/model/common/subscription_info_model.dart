class SubscriptionInfoModel {
  String? stripeSubscriptionId;
  String? period;
  String? paymentType;
  String? canceledAt;
  String? startTime;
  String? endTime;
  String? price;
  String? environment;
  String? status;
  String? planName;

  SubscriptionInfoModel({
    this.stripeSubscriptionId,
    this.period,
    this.paymentType,
    this.canceledAt,
    this.startTime,
    this.endTime,
    this.price,
    this.environment,
    this.status,
    this.planName,
  });

  Map<String, dynamic> toJson() => {
    'stripe_subscription_id': stripeSubscriptionId,
    'payment_type': paymentType,
    'period': period,
    'canceled_at': canceledAt,
    'start_time': startTime,
    'end_time': endTime,
    'price': price,
    'environment': environment,
    'status': status,
    'plan_name': planName,
  };

  factory SubscriptionInfoModel.fromJson(Map<String, dynamic> json) => SubscriptionInfoModel(
    stripeSubscriptionId: json['stripe_subscription_id'], 
    paymentType: json['payment_type'], 
    period: json['period'], 
    canceledAt: json['canceled_at'], 
    startTime: json['start_time'],
    endTime: json['end_time'],
    price: json['price'],
    environment: json['environment'],
    status: json['status'],
    planName: json['plan_name'],
  );
}