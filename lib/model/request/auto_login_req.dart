class AutoLoginReq {
  String token;
  String deviceKey;
  String firebaseToken;
  String deviceType;

  AutoLoginReq({
    required this.token,
    required this.deviceKey,
    required this.firebaseToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'device_key': deviceKey,
    'fcm_token': firebaseToken,
    'device_type': deviceType,
  };

  factory AutoLoginReq.fromJson(Map<String, dynamic> json) => AutoLoginReq(
    token: json['token'], 
    deviceKey: json['device_key'],
    firebaseToken: json['fcm_token'],
    deviceType: json['device_type']
  );
}