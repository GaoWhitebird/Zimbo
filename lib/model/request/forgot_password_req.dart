class ForgotPasswordReq {
  String email;

  ForgotPasswordReq({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
  };

  factory ForgotPasswordReq.fromJson(Map<String, dynamic> json) => ForgotPasswordReq(
    email: json['email']
  );
}