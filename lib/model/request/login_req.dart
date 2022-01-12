class LoginReq{
  String email;
  String password;
  String deviceKey;

  LoginReq({
    required this.email,
    required this.password,
    required this.deviceKey,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'device_key': deviceKey,
  };

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
    email: json['id'],
    password: json['title'],
    deviceKey: json['device_key'],
  );
}