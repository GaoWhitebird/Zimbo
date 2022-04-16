class SignUpGoogleReq {
  String userName;
  String googleId;
  String email;
  String image;
  String deviceKey;
  String firebaseToken;
  String deviceType;

  SignUpGoogleReq({
    required this.userName,
    required this.googleId,
    required this.email,
    required this.image,
    required this.deviceKey,
    required this.firebaseToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'google_id': googleId,
    'email': email,
    'image': image,
    'device_key': deviceKey,
    'fcm_token': firebaseToken,
    'device_type': deviceType,
  };

  factory SignUpGoogleReq.fromJson(Map<String, dynamic> json) => SignUpGoogleReq(
    userName: json['user_name'],
    googleId: json['google_id'],
    email: json['email'],
    image: json['image'],
    deviceKey: json['device_key'],
    firebaseToken: json['fcm_token'],
    deviceType: json['device_type']
  );
}