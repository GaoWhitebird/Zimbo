class ResetPasswordReq {
  String password;

  ResetPasswordReq({
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'password': password,
  };

  factory ResetPasswordReq.fromJson(Map<String, dynamic> json) => ResetPasswordReq(
    password: json['password']
  );
}