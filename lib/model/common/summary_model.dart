class SummaryModel {
  String? name;
  String? source;
  String? image;
  String? value;

  SummaryModel({
    this.name,
    this.source,
    this.image,
    this.value,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'source': source,
    'image': image,
    'value': value,
  };

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    name: json['name'],
    source: json['source'],
    image: json['image'],
    value: json['value'],
  );
}