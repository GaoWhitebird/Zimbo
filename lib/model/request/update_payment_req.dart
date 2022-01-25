class UpdatePaymentReq {
  String sourceId;

  UpdatePaymentReq({
    required this.sourceId,
  });

  Map<String, dynamic> toJson() => {
    'source_id': sourceId,
  };

  factory UpdatePaymentReq.fromJson(Map<String, dynamic> json) => UpdatePaymentReq(
    sourceId: json['source_id'],
  );
}