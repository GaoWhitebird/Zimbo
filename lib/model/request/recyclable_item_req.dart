class RecyclableItemReq {
  String id;
  String image;

  RecyclableItemReq({
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
  };

  factory RecyclableItemReq.fromJson(Map<String, dynamic> json) => RecyclableItemReq(
    id: json['id'], 
    image: json['image'],
  );
}