class ChargeAppleReq {
  String txnId;
  String planId;

  ChargeAppleReq({
    required this.txnId,
    required this.planId,
  });

  Map<String, dynamic> toJson() => {
    'txn_id': txnId,
    'plan_id': planId,
  };

  factory ChargeAppleReq.fromJson(Map<String, dynamic> json) => ChargeAppleReq(
    txnId: json['txn_id'],
    planId: json['plan_id'],
  );
}