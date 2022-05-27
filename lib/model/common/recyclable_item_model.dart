class RecyclableItemModel {
  String id;
  String image;
  String name;
  String description;
  String count;
  String usedCount;
  String isChecked;
  String isMultiple;
  String userRecyclableImage;

  RecyclableItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.count,
    required this.usedCount,
    required this.isChecked,
    required this.isMultiple,
    required this.userRecyclableImage
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'description': description,
    'count': count,
    'used_count': usedCount,
    'is_checked': isChecked,
    'is_multiple': isMultiple,
    'user_recyclable_image': userRecyclableImage,
  };

  factory RecyclableItemModel.fromJson(Map<String, dynamic> json) => RecyclableItemModel(
    id: json['id'],
    image: json['image'],
    name: json['name'],
    description: json['description'],
    count: json['count'],
    usedCount: json['used_count'],
    isChecked: json['is_checked'],
    isMultiple: json['is_multiple'],
    userRecyclableImage: json['user_recyclable_image'],
  );
}