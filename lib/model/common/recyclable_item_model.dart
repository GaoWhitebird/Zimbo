class RecyclableItemModel {
  String id;
  String image;
  String name;
  String description;
  String count;
  String usedCount;
  String isChecked;
  String isMultiple;
  String? userRecyclableImage;
  String rootId;
  String hasSub;
  List<dynamic> subList;
  int? selectedIndex;

  RecyclableItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.count,
    required this.usedCount,
    required this.isChecked,
    required this.isMultiple,
    this.userRecyclableImage,
    required this.rootId,
    required this.hasSub,
    required this.subList,
    this.selectedIndex,
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
    'root_id': rootId,
    'has_sub': hasSub,
    'sub_list': subList,
    'selected_index': selectedIndex,
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
    rootId: json['root_id'],
    hasSub: json['has_sub'],
    subList: json['sub_list'],
    selectedIndex: json['selected_index'],
  );
}