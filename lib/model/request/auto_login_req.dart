class AutoLoginReq {
  String token;
  String deviceKey;

  AutoLoginReq({
    required this.token,
    required this.deviceKey
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'device_key': deviceKey,
  };

  factory AutoLoginReq.fromJson(Map<String, dynamic> json) => AutoLoginReq(
    token: json['token'], 
    deviceKey: json['device_key'],
  );
}