class LoginReq{
  String email;
  String password;
  String deviceKey;
  String firebaseToken;
  String deviceType;

  LoginReq({
    required this.email,
    required this.password,
    required this.deviceKey,
    required this.firebaseToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'device_key': deviceKey,
    'fcm_token': firebaseToken,
    'device_type': deviceType,
  };

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
    email: json['id'],
    password: json['title'],
    deviceKey: json['device_key'],
    firebaseToken: json['fcm_token'],
    deviceType: json['device_type']
  );
}