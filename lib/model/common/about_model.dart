class AboutModel {
  int id;
  String title;
  String description;

  AboutModel({
    required this.id,
    required this.title,
    required this.description
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
  };

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
  );
}