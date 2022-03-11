class ScoreModel {
  String id;
  String count;

  ScoreModel({
    required this.id,
    required this.count,
  });

  Map<String, dynamic> toJson () => {
    'id': id,
    'count': count,
  };

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
    id: json['id'] ,
    count: json['count'],
  );
}