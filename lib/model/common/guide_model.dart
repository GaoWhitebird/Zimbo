import 'package:flutter/cupertino.dart';

class GuideModel {
  String? id;
  String? title;
  String? description;
  Color? backgroundColor;
  String? imageStr;

  GuideModel({
    this.id,
    this.title,
    this.description,
    this.backgroundColor,
    this.imageStr
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'background_color': backgroundColor,
    'image_str': imageStr
  };

  factory GuideModel.fromJson(Map<String, dynamic> json) => GuideModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    backgroundColor: json['background_color'],
    imageStr: json['image_str'],
  );
}