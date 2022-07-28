class AddScoreReq {
  List<dynamic> recyclableIds;
  bool merchant;
  String merchantId;

  AddScoreReq({
    required this.recyclableIds,
    required this.merchant,
    required this.merchantId,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_ids': recyclableIds,
    'merchant': merchant,
    'merchant_id': merchantId,
  };

  factory AddScoreReq.fromJson(Map<String, dynamic> json) => AddScoreReq(
    recyclableIds: json['recyclable_ids'],
    merchant: json['merchant'],
    merchantId: json['merchant_id'],
  );
}