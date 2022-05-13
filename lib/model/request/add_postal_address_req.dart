class AddPostalAddressReq {
  String postalAddress;

  AddPostalAddressReq({
    required this.postalAddress,
  });

  Map<String, dynamic> toJson() => {
    'postal_code': postalAddress,
  };

  factory AddPostalAddressReq.fromJson(Map<String, dynamic> json) => AddPostalAddressReq(
    postalAddress: json['postal_code'],
  );
}