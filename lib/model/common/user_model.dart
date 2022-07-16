import 'package:zimbo/model/common/subscription_info_model.dart';

class UserModel {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? userImage;
  String? userPhone;
  String? userScore;
  String? address;
  String? lat;
  String? lon;
  String? isEmailVerified;
  String? isPhoneVerified;
  String? socialId;
  String? signupType;
  String? status;
  String? loginStatus;
  SubscriptionInfoModel? subscriptionInfo;

  String? street;
  String? apt;
  String? city;
  String? state;
  String? zipCode;
  String? country;

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
    this.lat,
    this.lon,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.socialId,
    this.signupType,
    this.status,
    this.loginStatus,
    this.subscriptionInfo,

    this.street,
    this.apt,
    this.city,
    this.state,
    this.zipCode
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
        'lat': lat,
        'lon': lon,
        'email_verified': isEmailVerified,
        'phone_verified': isPhoneVerified,
        'social_id': socialId,
        'signup_type': signupType,
        'status': status,
        'login_status': loginStatus,
        'subscription_info':
            subscriptionInfo == null ? null : subscriptionInfo!.toJson(),

        'street': street,
        'apt': apt,
        'city': city,
        'state': state,
        'postal_code': zipCode,
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
        lat: json['lat'],
        lon: json['lon'],
        isEmailVerified: json['email_verified'],
        isPhoneVerified: json['phone_verified'],
        socialId: json['social_id'],
        signupType: json['signup_type'],
        status: json['status'],
        loginStatus: json['login_status'],
        subscriptionInfo: json['subscription_info'] == null
            ? null
            : SubscriptionInfoModel.fromJson(json['subscription_info']),

        
        street: json['street'],
        apt: json['apt'],
        city: json['city'],
        state: json['state'],
        zipCode: json['postal_code'],
      );
}
