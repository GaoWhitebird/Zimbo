class DeleteRecyclableReq {
  String recyclableId;

  DeleteRecyclableReq({
    required this.recyclableId,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_id': recyclableId,
  };

  factory DeleteRecyclableReq.fromJson(Map <String, dynamic> json) => DeleteRecyclableReq(
    recyclableId: json['recyclable_id'],
  );
}