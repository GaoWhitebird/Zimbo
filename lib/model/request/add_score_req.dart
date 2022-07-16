class AddScoreReq {
  List<dynamic> recyclableIds;
  bool merchant;

  AddScoreReq({
    required this.recyclableIds,
    required this.merchant,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_ids': recyclableIds,
    'merchant': merchant,
  };

  factory AddScoreReq.fromJson(Map<String, dynamic> json) => AddScoreReq(
    recyclableIds: json['recyclable_ids'],
    merchant: json['merchant'],
  );
}