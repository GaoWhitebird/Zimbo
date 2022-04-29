class ApiUtils {
  // ignore: constant_identifier_names
  static const BASE_URL = 'http://52.64.223.19/zimbo/mobile/';  
  //static const BASE_URL = 'http://192.168.0.75/zimbo/mobile/';  
  static const urlSignupEmail = BASE_URL + 'main/signup_email';
  static const urlLogin = BASE_URL + 'main/login';
  static const urlAutoLogin = BASE_URL + 'main/auto_login';
  static const urlLoginFacebook = BASE_URL + 'main/login_facebook';
  static const urlLoginGoogle = BASE_URL + 'main/login_google';
  static const urlFortgotPassword = BASE_URL + 'main/forgot_password';
  static const urlResetPassword = BASE_URL + 'main/reset_password';
  static const urlLogout = BASE_URL + 'user/logout';
  static const urlUpdateProfile = BASE_URL + 'user/update_profile';
  static const urlGetUserProfile = BASE_URL + 'user/profile';
  static const urlDeleteUserProfile = BASE_URL + 'user/delete_profile';
  static const urlResetScore = BASE_URL + 'user/reset_score';
  static const urlSetShoppingDay = BASE_URL + 'user/set_shopping_day';

  static const urlGetRecyclableList = BASE_URL + 'user/get_recyclable_list';
  static const urlGetAvailableRecyclableList = BASE_URL + 'user/get_available_recyclable_list';
  static const urlAddRecyclableItems = BASE_URL + 'user/add_user_recyclable_items';
  static const urlDeleteRecyclableItem = BASE_URL + 'user/delete_user_recyclable_item';
  static const urlUpdateRecyclableItemCount = BASE_URL + 'user/update_user_recyclable_count';
  static const urlGetPointHistory = BASE_URL + 'user/get_point_history';
  static const urlGetUserRecyclableList = BASE_URL + 'user/get_user_recyclable_list';
  static const urlAddScore = BASE_URL + 'user/add_user_score';
  static const urlPostSupport = BASE_URL + 'user/post_support';
  static const urlPostShare = BASE_URL + 'user/post_share';

  static const urlGetStripeKey = BASE_URL + 'payment/get_publish_key';
  static const urlUpdatePaymentInfo = BASE_URL + 'payment/update_payment';
  static const urlCancelPayment = BASE_URL + 'payment/cancel_payment';
  static const urlGetSubscriptionInfo = BASE_URL + 'payment/get_subscription_info';
  static const urlGetPaymentHistory = BASE_URL + 'payment/get_payment_history';

  static const urlFacebookAppId = '765052451139435';
  static const urlFacebookClientToken = 'dbd9508541ce22ef8f3d16e86a736461';
}