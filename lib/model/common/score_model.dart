class ScoreModel {
  String id;
  String count;
  String hasSub;


  ScoreModel({
    required this.id,
    required this.count,
    required this.hasSub,
  });

  Map<String, dynamic> toJson () => {
    'id': id,
    'count': count,
    'has_sub': hasSub,
  };

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
    id: json['id'] ,
    count: json['count'],
    hasSub: json['has_sub'],
  );
}