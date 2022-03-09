import 'package:dio/dio.dart';

class RecyclableItemReq {
  String id;
  MultipartFile? image;

  RecyclableItemReq({
    required this.id,
    this.image,
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