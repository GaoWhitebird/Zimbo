class ProfileLevelModel {
  String id;
  String labelName;
  String scoreMin;
  String scoreMax;
  String current;
  String range;

  ProfileLevelModel({
    required this.id,
    required this.labelName,
    required this.scoreMin,
    required this.scoreMax,
    required this.current,
    required this.range,
  });

  Map<String, dynamic> toJson () => {
    'id': id,
    'label_name': labelName,
    'score_min': scoreMin,
    'score_max': scoreMax,
    'current': current,
    'range': range,
  };

  factory ProfileLevelModel.fromJson(Map<String, dynamic> json) => ProfileLevelModel(
    id: json['id'] ,
    labelName: json['label_name'],
    scoreMin: json['score_min'],
    scoreMax: json['score_max'],
    current: json['current'],
    range: json['range'],
  );
}