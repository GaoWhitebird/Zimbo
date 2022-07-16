class AddPostalAddressReq {
  String firstName;
  String lastName;
  String street;
  String? apt;
  String city;
  String state;
  String zipcode;
  String country;

  AddPostalAddressReq({
    required this.firstName,
    required this.lastName,
    required this.street,
    this.apt,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.country,
  });

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'street': street,
    'apt': apt,
    'city': city,
    'state': state,
    'postcode': zipcode,
    'country': country,
  };

  factory AddPostalAddressReq.fromJson(Map<String, dynamic> json) => AddPostalAddressReq(
    firstName: json['first_name'],
    lastName: json['last_name'],
    street: json['street'],
    apt: json['apt'],
    city: json['city'],
    state: json['state'],
    zipcode: json['postcode'],
    country: json['country'],
  );
}