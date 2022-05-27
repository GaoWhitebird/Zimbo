class GetHomeDetailReq {
  String type;

  GetHomeDetailReq({
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
  };

  factory GetHomeDetailReq.fromJson(Map<String, dynamic> json) => GetHomeDetailReq(
    type: json['type'],
  );
}