class AddScoreReq {
  List<dynamic> recyclableIds;

  AddScoreReq({
    required this.recyclableIds,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_ids': recyclableIds,
  };

  factory AddScoreReq.fromJson(Map<String, dynamic> json) => AddScoreReq(
    recyclableIds: json['recyclable_ids'],
  );
}