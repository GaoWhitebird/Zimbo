class ChargeIapGoogleReq {
  String purchaseToken;
  String subscriptionId;
  String packageName;
  String planId;

  ChargeIapGoogleReq({
    required this.purchaseToken,
    required this.subscriptionId,
    required this.packageName,
    required this.planId,
  });

  Map<String, dynamic> toJson() => {
    'purchase_token': purchaseToken,
    'subscription_id': subscriptionId,
    'package_name': packageName,
    'plan_id': planId,
  };

  factory ChargeIapGoogleReq.fromJson(Map<String, dynamic> json) => ChargeIapGoogleReq(
    purchaseToken: json['purchase_token'],
    subscriptionId: json['subscription_id'],
    packageName: json['package_name'],
    planId: json['plan_id'],
  );
}