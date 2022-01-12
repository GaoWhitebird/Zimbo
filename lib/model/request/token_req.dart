class TokenReq {
  String token;

  TokenReq({
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
  };

  factory TokenReq.fromJson(Map<String, dynamic> json) => TokenReq(
    token: json['token'],
  );
}