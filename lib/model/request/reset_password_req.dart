class ResetPasswordReq {
  String token;
  String password;

  ResetPasswordReq({
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'password': password,
  };

  factory ResetPasswordReq.fromJson(Map<String, dynamic> json) => ResetPasswordReq(
    token: json['token'],
    password: json['password']
  );
}