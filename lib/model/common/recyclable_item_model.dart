class RecyclableItemModel {
  String id;
  String image;
  String name;
  String count;
  String usedCount;
  String isChecked;

  RecyclableItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
    required this.usedCount,
    required this.isChecked
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'count': count,
    'used_count': usedCount,
    'is_checked': isChecked,
  };

  factory RecyclableItemModel.fromJson(Map<String, dynamic> json) => RecyclableItemModel(
    id: json['id'],
    image: json['image'],
    name: json['name'],
    count: json['count'],
    usedCount: json['used_count'],
    isChecked: json['is_checked'],
  );
}