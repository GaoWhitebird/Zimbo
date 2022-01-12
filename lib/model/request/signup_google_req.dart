class SignUpGoogleReq {
  String name;
  String googleId;
  String email;
  String image;
  String deviceKey;

  SignUpGoogleReq({
    required this.name,
    required this.googleId,
    required this.email,
    required this.image,
    required this.deviceKey,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'google_id': googleId,
    'email': email,
    'image': image,
    'device_key': deviceKey,
  };

  factory SignUpGoogleReq.fromJson(Map<String, dynamic> json) => SignUpGoogleReq(
    name: json['name'],
    googleId: json['google_id'],
    email: json['email'],
    image: json['image'],
    deviceKey: json['device_key'],
  );
}