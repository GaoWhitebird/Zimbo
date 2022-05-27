class ChargeGoogleReq {
  String txnId;
  String planId;

  ChargeGoogleReq({
    required this.txnId,
    required this.planId,
  });

  Map<String, dynamic> toJson() => {
    'txn_id': txnId,
    'plan_id': planId,
  };

  factory ChargeGoogleReq.fromJson(Map<String, dynamic> json) => ChargeGoogleReq(
    txnId: json['txn_id'],
    planId: json['plan_id'],
  );
}