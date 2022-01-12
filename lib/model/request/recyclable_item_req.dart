class RecyclableItemReq {
  String id;
  String count;

  RecyclableItemReq({
    required this.id,
    required this.count,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'count': count,
  };

  factory RecyclableItemReq.fromJson(Map<String, dynamic> json) => RecyclableItemReq(
    id: json['id'], 
    count: json['count'],
  );
}