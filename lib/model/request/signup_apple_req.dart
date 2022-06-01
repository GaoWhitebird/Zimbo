class SignUpAppleReq {
  String? userName;
  String appleId;
  String? email;
  String? image;
  String deviceKey;
  String firebaseToken;
  String? deviceType;
  String? referralCode;

  SignUpAppleReq({
    this.userName,
    required this.appleId,
    this.email,
    this.image,
    required this.deviceKey,
    required this.firebaseToken,
    this.deviceType,
    this.referralCode,
  });

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'apple_id': appleId,
    'email': email,
    'image': image,
    'device_key': deviceKey,
    'fcm_token': firebaseToken,
    'device_type': deviceType,
    'referral_code': referralCode,
  };

  factory SignUpAppleReq.fromJson(Map<String, dynamic> json) => SignUpAppleReq(
    userName: json['user_name'],
    appleId: json['apple_id'],
    email: json['email'],
    image: json['image'],
    deviceKey: json['device_key'],
    firebaseToken: json['fcm_token'],
    deviceType: json['device_type'],
    referralCode: json['referral_code']
  );
}