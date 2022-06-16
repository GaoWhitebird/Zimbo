class ChargeIapReq {
  String receiptData;
  String planId;

  ChargeIapReq({
    required this.receiptData,
    required this.planId,
  });

  Map<String, dynamic> toJson() => {
    'receipt_data': receiptData,
    'plan_id': planId,
  };

  factory ChargeIapReq.fromJson(Map<String, dynamic> json) => ChargeIapReq(
    receiptData: json['receipt_data'],
    planId: json['plan_id'],
  );
}