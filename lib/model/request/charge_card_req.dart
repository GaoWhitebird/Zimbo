class ChargeCardReq {
  String sourceId;
  String planId;

  ChargeCardReq({
    required this.sourceId,
    required this.planId,
  });

  Map<String, dynamic> toJson() => {
    'source_id': sourceId,
    'plan_id': planId,
  };

  factory ChargeCardReq.fromJson(Map<String, dynamic> json) => ChargeCardReq(
    sourceId: json['source_id'],
    planId: json['plan_id'],
  );
}