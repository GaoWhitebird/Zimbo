class UserModel {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? userImage;
  String? userPhone;
  String? userScore;
  String? country;
  String? address;
  String? postalCode;
  String? lat;
  String? lon;
  String? isEmailVerified;
  String? isPhoneVerified;
  String? socialId;
  String? signupType;
  String? status;
  String? loginStatus;

  UserModel({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.userEmail,
    this.userImage,
    this.userPhone,
    this.userScore,
    this.country,
    this.address,
    this.postalCode,
    this.lat,
    this.lon,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.socialId,
    this.signupType,
    this.status,
    this.loginStatus,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_name': userName,
    'user_first_name': firstName,
    'user_last_name': lastName,
    'user_email': userEmail,
    'user_image': userImage,
    'user_phone': userPhone,
    'user_score': userScore,
    'country': country,
    'address': address,
    'postal_code': postalCode,
    'lat': lat,
    'lon': lon,
    'email_verified': isEmailVerified,
    'phone_verified': isPhoneVerified,
    'social_id': socialId,
    'signup_type': signupType,
    'status': status,
    'login_status': loginStatus,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    userName: json['user_name'],
    firstName: json['user_first_name'],
    lastName: json['user_last_name'],
    userEmail: json['user_email'],
    userImage: json['user_image'],
    userPhone: json['user_phone'],
    userScore: json['user_score'],
    country: json['country'],
    address: json['address'],
    postalCode: json['postal_code'],
    lat: json['lat'],
    lon: json['lon'],
    isEmailVerified: json['email_verified'],
    isPhoneVerified: json['phone_verified'],
    socialId: json['social_id'],
    signupType: json['signup_type'],
    status: json['status'],
    loginStatus: json['login_status'],
  );
}