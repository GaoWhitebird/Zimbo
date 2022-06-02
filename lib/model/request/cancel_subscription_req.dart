class CancelSubscriptionReq {
  String stripeSubscriptionId;

  CancelSubscriptionReq({
    required this.stripeSubscriptionId,
  });

  Map<String, dynamic> toJson() => {
    'stripe_subscription_id': stripeSubscriptionId,
  };

  factory CancelSubscriptionReq.fromJson(Map<String, dynamic> json) => CancelSubscriptionReq(
    stripeSubscriptionId: json['stripe_subscription_id'],
  );
}