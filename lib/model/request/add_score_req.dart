class AddScoreReq {
  String recyclableId;

  AddScoreReq({
    required this.recyclableId,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_id': recyclableId,
  };

  factory AddScoreReq.fromJson(Map<String, dynamic> json) => AddScoreReq(
    recyclableId: json['recyclable_id'],
  );
}