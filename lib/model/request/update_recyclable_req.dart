class UpdateRecyclableReq {
  String recyclableId;
  String count;

  UpdateRecyclableReq({
    required this.recyclableId,
    required this.count,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_id': recyclableId,
    'count': count,
  };

  factory UpdateRecyclableReq.fromJson(Map <String, dynamic> json) => UpdateRecyclableReq(
    recyclableId: 'recyclable_id', 
    count: 'count',
  );
}