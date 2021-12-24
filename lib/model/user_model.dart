class UserModel {
  String? userToken;
  int? userId;
  String? userName;
  String? userEmail;
  String? userPass;
  String? userImage;
  String? userAddress;
  String? userCity;
  int? userScore;
  bool? isFaceboook;
  bool? isGoogle;

  UserModel({
    this.userToken,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPass,
    this.userImage,
    this.userAddress,
    this.userCity,
    this.userScore,
    this.isFaceboook,
    this.isGoogle,
  });

  Map<String, dynamic> toJson() => {
    'user_token': userToken,
    'user_id': userId,
    'user_name': userName,
    'user_email': userEmail,
    'user_pass': userPass,
    'user_image': userImage,
    'user_address': userAddress,
    'user_city': userCity,
    'user_score': userScore,
    'is_facebook': isFaceboook,
    'is_google': isGoogle,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userToken: json['user_token'],
    userId: json['user_id'],
    userName: json['user_name'],
    userEmail: json['user_email'],
    userPass: json['user_pass'],
    userImage: json['user_image'],
    userAddress: json['user_address'],
    userCity: json['user_city'],
    userScore: json['user_score'],
    isFaceboook: json['is_facebook'],
    isGoogle: json['is_google'],
  );
}