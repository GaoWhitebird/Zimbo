class ChargeIapGoogleReq {
  String purchaseToken;
  String subscriptionId;
  String productId;
  String packageName;
  String planId;

  ChargeIapGoogleReq({
    required this.purchaseToken,
    required this.subscriptionId,
    required this.productId,
    required this.packageName,
    required this.planId,
  });

  Map<String, dynamic> toJson() => {
    'purchase_token': purchaseToken,
    'subscription_id': subscriptionId,
    'product_id': productId,
    'package_name': packageName,
    'plan_id': planId,
  };

  factory ChargeIapGoogleReq.fromJson(Map<String, dynamic> json) => ChargeIapGoogleReq(
    purchaseToken: json['purchase_token'],
    subscriptionId: json['subscription_id'],
    productId: json['product_id'],
    packageName: json['package_name'],
    planId: json['plan_id'],
  );
}