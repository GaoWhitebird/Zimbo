class SignUpFacebookReq {
  String name;
  String facebookId;
  String email;
  String image;
  String deviceKey;
  String firebaseToken;
  String deviceType;
  String? referralCode;

  SignUpFacebookReq({
    required this.name,
    required this.facebookId,
    required this.email,
    required this.image,
    required this.deviceKey,
    required this.firebaseToken,
    required this.deviceType,
    this.referralCode,
  });

  Map<String, dynamic> toJson() => {
    'user_name': name,
    'facebook_id': facebookId,
    'email': email,
    'image': image,
    'device_key': deviceKey,
    'fcm_token': firebaseToken,
    'device_type': deviceType,
    'referral_code': referralCode,
  };

  factory SignUpFacebookReq.fromJson(Map<String, dynamic> json) => SignUpFacebookReq(
    name: json['user_name'], 
    facebookId: json['facebook_id'], 
    email: json['email'], 
    image: json['image'], 
    deviceKey: json['device_key'],
    firebaseToken: json['fcm_token'],
    deviceType: json['device_type'],
    referralCode: json['referral_code']
  );
}