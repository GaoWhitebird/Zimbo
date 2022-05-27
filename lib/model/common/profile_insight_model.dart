class ProfileInsightModel {
  String carbonOffset;
  String savings;
  String reuse;
  String tree;

  ProfileInsightModel({
    required this.carbonOffset,
    required this.savings,
    required this.reuse,
    required this.tree,
  });

  Map<String, dynamic> toJson () => {
    'carbon_offset': carbonOffset,
    'savings': savings,
    'reuse': reuse,
    'tree': tree,
  };

  factory ProfileInsightModel.fromJson(Map<String, dynamic> json) => ProfileInsightModel(
    carbonOffset: json['carbon_offset'] ,
    savings: json['savings'],
    reuse: json['reuse'],
    tree: json['tree'],
  );
}