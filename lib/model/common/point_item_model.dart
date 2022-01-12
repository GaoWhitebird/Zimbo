class PointItemModel {
  String id;
  String name;
  String count;
  String usedCount;
  String image;
  String isChecked;
  String timestamp;

  PointItemModel({
    required this.id,
    required this.name,
    required this.count,
    required this.usedCount,
    required this.image,
    required this.isChecked,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'count': count,
    'used_count': usedCount,
    'image': image,
    'is_checked': isChecked,
    'timestamp': timestamp,
  };

  factory PointItemModel.fromJson(Map<String, dynamic> json) => PointItemModel(
    id: json['id'], 
    name: json['name'], 
    count: json['count'], 
    usedCount: json['used_count'], 
    image: json['image'], 
    isChecked: json['is_checked'], 
    timestamp: json['timestamp'],
  );
}