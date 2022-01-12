class UpdateProfileReq {
  String userName;
  String userEmail;
  String userImage;
  String userPhone;
  String userPhonePrefix;
  String country;
  String address;

  UpdateProfileReq({
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.userPhone,
    required this.userPhonePrefix,
    required this.country,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'user_email': userEmail,
    'user_image': userImage,
    'user_phone': userPhone,
    'user_phone_prefix': userPhonePrefix,
    'country': country,
    'address': address,
  };

  factory UpdateProfileReq.fromJson(Map<String, dynamic> json) => UpdateProfileReq(
    userName: json['user_name'], 
    userEmail: json['user_email'], 
    userImage: json['user_image'], 
    userPhone: json['user_phone'], 
    userPhonePrefix: json['user_phone_prefix'], 
    country: json['country'], 
    address: json['address'],
  );
}