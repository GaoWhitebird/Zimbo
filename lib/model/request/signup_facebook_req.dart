class SignUpFacebookReq {
  String name;
  String facebookId;
  String email;
  String image;
  String deviceKey;

  SignUpFacebookReq({
    required this.name,
    required this.facebookId,
    required this.email,
    required this.image,
    required this.deviceKey,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'facebook_id': facebookId,
    'email': email,
    'image': image,
    'device_key': deviceKey,
  };

  factory SignUpFacebookReq.fromJson(Map<String, dynamic> json) => SignUpFacebookReq(
    name: json['name'], 
    facebookId: json['facebook_id'], 
    email: json['email'], 
    image: json['image'], 
    deviceKey: json['device_key']
  );
}