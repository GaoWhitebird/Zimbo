class RecyclableItemModel {
  int id;
  String image;
  String name;
  int count;
  bool isChecked;

  RecyclableItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
    required this.isChecked
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'count': count,
    'is_checked': isChecked,
  };

  factory RecyclableItemModel.fromJson(Map<String, dynamic> json) => RecyclableItemModel(
    id: json['id'],
    image: json['image'],
    name: json['name'],
    count: json['count'],
    isChecked: json['is_checked'],
  );
}