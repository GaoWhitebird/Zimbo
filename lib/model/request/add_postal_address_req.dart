class AddPostalAddressReq {
  String address1;
  String? address2;
  String suburb;
  String state;
  String postcode;

  AddPostalAddressReq({
    required this.address1,
    this.address2,
    required this.suburb,
    required this.state,
    required this.postcode,
  });

  Map<String, dynamic> toJson() => {
    'address1': address1,
    'address2': address2,
    'suburb': suburb,
    'state': state,
    'postcode': postcode,
  };

  factory AddPostalAddressReq.fromJson(Map<String, dynamic> json) => AddPostalAddressReq(
    address1: json['address1'],
    address2: json['address2'],
    suburb: json['suburb'],
    state: json['state'],
    postcode: json['postcode'],
  );
}