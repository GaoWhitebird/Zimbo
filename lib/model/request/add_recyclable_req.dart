

class AddRecyclableReq {
  List<dynamic> list;

  AddRecyclableReq({
    required this.list,
  });

  Map<String, dynamic> toJson() => {
    'recyclable_items': list,
  };

  factory AddRecyclableReq.fromJson(Map<String, dynamic> json) => AddRecyclableReq(
    list: json['recyclable_items'],
  );
}