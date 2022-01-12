class EcoHubModel {
  int id;
  String title;
  String description;
  String image;

  EcoHubModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': image,
  };

  factory EcoHubModel.fromJson(Map<String, dynamic> json) => EcoHubModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    image: json['image'],
  );

}