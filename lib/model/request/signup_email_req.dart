class SignUpEmailReq{
  String userName;
  String email;
  String password;
  String deviceKey;

  SignUpEmailReq({
    required this.userName,
    required this.email,
    required this.password,
    required this.deviceKey,
  });

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'email': email,
    'password': password,
    'device_key': deviceKey,
  };

  factory SignUpEmailReq.fromJson(Map<String, dynamic> json) => SignUpEmailReq(
    userName: json['user_name'],
    email: json['email'],
    password: json['password'],
    deviceKey: json['device_key'],
  );
}