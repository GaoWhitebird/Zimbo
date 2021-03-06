class SignUpEmailReq{
  String userName;
  String email;
  String password;
  String deviceKey;
  String firebaseToken;
  String deviceType;
  String? referralCode;

  SignUpEmailReq({
    required this.userName,
    required this.email,
    required this.password,
    required this.deviceKey,
    required this.firebaseToken,
    required this.deviceType,
    this.referralCode,
  });

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'email': email,
    'password': password,
    'device_key': deviceKey,
    'fcm_token': firebaseToken,
    'device_type': deviceType,
    'referral_code': referralCode,
  };

  factory SignUpEmailReq.fromJson(Map<String, dynamic> json) => SignUpEmailReq(
    userName: json['user_name'],
    email: json['email'],
    password: json['password'],
    deviceKey: json['device_key'],
    firebaseToken: json['fcm_token'],
    deviceType: json['device_type'],
    referralCode: json['referral_code']
  );
}