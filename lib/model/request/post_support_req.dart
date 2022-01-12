import 'package:dio/dio.dart';

class PostSupportReq {
  String content;
  MultipartFile? attachment;

  PostSupportReq({
    required this.content,
    this.attachment,
  });

  Map<String, dynamic> toJson() => {
    'content': content,
    'attachment': attachment,
  };

  factory PostSupportReq.fromJson(Map<String, dynamic> json) => PostSupportReq(
    content: json['content'],
    attachment: json['attachment'] ,
  );
}