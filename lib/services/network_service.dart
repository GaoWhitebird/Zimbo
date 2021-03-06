import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zimbo/locator.dart';
import 'package:zimbo/model/common/dash_model.dart';
import 'package:zimbo/model/common/home_detail_model.dart';
import 'package:zimbo/model/common/payment_history_item_model.dart';
import 'package:zimbo/model/common/point_item_model.dart';
import 'package:zimbo/model/common/profile_insight_model.dart';
import 'package:zimbo/model/common/profile_level_model.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/common/subscription_info_model.dart';
import 'package:zimbo/model/common/summary_model.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/add_postal_address_req.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/add_score_req.dart';
import 'package:zimbo/model/request/auto_login_req.dart';
import 'package:zimbo/model/request/charge_apple_req.dart';
import 'package:zimbo/model/request/charge_card_req.dart';
import 'package:zimbo/model/request/charge_google_req.dart';
import 'package:zimbo/model/request/charge_iap_google_req.dart';
import 'package:zimbo/model/request/delete_recyclable_req.dart';
import 'package:zimbo/model/request/forgot_password_req.dart';
import 'package:zimbo/model/request/get_home_detail_req.dart';
import 'package:zimbo/model/request/login_req.dart';
import 'package:zimbo/model/request/post_support_req.dart';
import 'package:zimbo/model/request/reset_password_req.dart';
import 'package:zimbo/model/request/shopping_day_req.dart';
import 'package:zimbo/model/request/signup_apple_req.dart';
import 'package:zimbo/model/request/signup_email_req.dart';
import 'package:zimbo/model/request/signup_facebook_req.dart';
import 'package:zimbo/model/request/signup_google_req.dart';
import 'package:zimbo/model/request/token_req.dart';
import 'package:zimbo/model/request/update_payment_req.dart';
import 'package:zimbo/model/request/update_profile_req.dart';
import 'package:zimbo/model/request/update_recyclable_req.dart';
import 'package:zimbo/services/shared_service.dart';
import 'package:zimbo/utils/api_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

import '../model/request/cancel_subscription_req.dart';
import '../model/request/charge_iap_req.dart';
import '../model/request/get_merchant_req.dart';

class NetworkService {
  var dio = Dio(); 

  Future doPostRequest(String url, {dynamic param, dynamic token}) async {
    showLoading();
    try {
      var formData = FormData();
      if(param != null){
        formData = FormData.fromMap(param);
      }
      Response response = await dio.post(
        url,
        queryParameters: token,
        data: param == null ? '' : formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      hideLoading();


      var resData = jsonDecode(response.data);
      if (resData['res'] != 'success') {
        showMessage(resData['err_msg'], null);

        return null;
      }
      return resData['api_result'];
    } catch (e) {
      hideLoading();
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future doGetRequest(String url, dynamic param) async {
    showLoading();
    try {
      Response response = await dio.get(
        url,
        queryParameters: param,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      hideLoading();

      var resData = jsonDecode(response.data);
      if (resData['res'] != 'success') {
        showMessage(resData['err_msg'], null);

        return null;
      }
      return resData['api_result'];
    } catch (e) {
      hideLoading();
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<UserModel?> doLogin(LoginReq req) async {
    var res = await doPostRequest(ApiUtils.urlLogin, param: req.toJson());
    if (res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doAutoLogin(AutoLoginReq req) async {
    var res = await doPostRequest(ApiUtils.urlAutoLogin, param: req.toJson());
    if (res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doSignUpEmail(SignUpEmailReq req) async {
    var res = await doPostRequest(ApiUtils.urlSignupEmail, param: req.toJson());
    if (res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doSignUpFacebook(SignUpFacebookReq req) async {
    var res =
        await doPostRequest(ApiUtils.urlLoginFacebook, param: req.toJson());
    if (res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    bool isFirstSignUp = res['first_signup'];
    sharedService.saveIsFirst(isFirstSignUp);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doSignUpGoogle(SignUpGoogleReq req) async {
    var res = await doPostRequest(ApiUtils.urlLoginGoogle, param: req.toJson());
    if (res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    bool isFirstSignUp = res['first_signup'];
    sharedService.saveIsFirst(isFirstSignUp);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doSignUpApple(SignUpAppleReq req) async {
    var res = await doPostRequest(ApiUtils.urlLoginApple, param: req.toJson());
    if (res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    bool isFirstSignUp = res['first_signup'];
    sharedService.saveIsFirst(isFirstSignUp);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future doLogout(String token) async {
    var res = await doPostRequest(ApiUtils.urlLogout,
        token: TokenReq(token: token).toJson());
    if (res == null) return false;

    return true;
  }

  Future doForgotPassword(ForgotPasswordReq req) async {
    var res = await doPostRequest(ApiUtils.urlFortgotPassword, param: req.toJson());
    if (res == null) return null;

     return res;
  }

  Future doResetPassword(ResetPasswordReq req) async {
    var res = await doPostRequest(ApiUtils.urlResetPassword, param: req.toJson());
    if (res == null) return null;

    return res;
  }

  Future<List<RecyclableItemModel>?> doGetRecyclableItemList(
      String token) async {
    var res = await doGetRequest(
        ApiUtils.urlGetRecyclableList, TokenReq(token: token).toJson());
    if (res == null) return [];

    List<dynamic> _list = res['recyclable_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++) {
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future<List<RecyclableItemModel>?> doGetAvailableRecyclableItemList(
      String token) async {
    var res = await doGetRequest(ApiUtils.urlGetAvailableRecyclableList,
        TokenReq(token: token).toJson());
    if (res == null) return [];

    List<dynamic> _list = res['recyclable_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++) {
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future<List<List<RecyclableItemModel>>?> doGetUserRecyclableList(
      String token) async {
    var res = await doGetRequest(
        ApiUtils.urlGetUserRecyclableList, TokenReq(token: token).toJson());
    if (res == null) return null;

    List<dynamic> _list = res['user_recyclable_item_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++) {
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }

    List<dynamic> _tempList = res['available_recyclable_list'];
    List<RecyclableItemModel> templist = [];
    for (int i = 0; i < _tempList.length; i++) {
      templist.add(RecyclableItemModel.fromJson(_tempList[i]));
    }

    List<List<RecyclableItemModel>> totalList = [];
    totalList.add(list);
    totalList.add(templist);

    return totalList;
  }

  Future<List<RecyclableItemModel>?> doGetMerchantRecyclableList(
      String token, GetMerchantReq req) async {
    var res = await doPostRequest(
        ApiUtils.urlGetMerchantRecyclableList, param: req.toJson(), token: TokenReq(token: token).toJson());
    if (res == null) return null;

    List<dynamic> _list = res['user_recyclable_item_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++) {
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }

    return list;
  }

  Future doAddRecyclableItems(
    String token,
    AddRecyclableReq req,
  ) async {
    showLoading();
    var res = await doPostRequest(ApiUtils.urlAddRecyclableItems, param: req.toJson(), token: TokenReq(token: token).toJson());
    if (res == null) return null;

    List<dynamic> _list = res['user_recyclable_item_list'];
      List<RecyclableItemModel> list = [];
      for (int i = 0; i < _list.length; i++) {
        list.add(RecyclableItemModel.fromJson(_list[i]));
      }
      return list;
  }

  Future<List<PointItemModel>?> doGetPointHistory(String token) async {
    var res = await doGetRequest(
        ApiUtils.urlGetPointHistory, TokenReq(token: token).toJson());
    if (res == null) return [];

    List<dynamic> _list = res['list'];
    List<PointItemModel> list = [];
    for (int i = 0; i < _list.length; i++) {
      list.add(PointItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future<UserModel?> doGetProfile(String token) async {
    var res = await doGetRequest(
        ApiUtils.urlGetUserProfile, TokenReq(token: token).toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doUpdateProfile(String token, UpdateProfileReq req) async {
    var res = await doPostRequest(ApiUtils.urlUpdateProfile,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<HomeDetailModel?> doGetHomeDetail(String token, GetHomeDetailReq req) async {
    var res = await doPostRequest(ApiUtils.urlGetHomeDetail,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return null;

    HomeDetailModel homeDetailModel = HomeDetailModel();
    homeDetailModel.summaryList = [];
    homeDetailModel.title = res['title'];
    homeDetailModel.total = res['total'];
    
    List<dynamic> summaryList = res['summary_list'];
    for(int i = 0; i < summaryList.length; i++){
      homeDetailModel.summaryList!.add(SummaryModel.fromJson(summaryList[i]));
    }
    
    return homeDetailModel;
  }

  Future<DashModel?> doGetDashboardData(String token) async {
    var res = await doGetRequest(
        ApiUtils.urlGetDash, TokenReq(token: token).toJson());
    if (res == null) return null;

    DashModel dashModel = DashModel();
    dashModel.levelList = [];
    dashModel.available = res['available'];
    UserModel userModel = UserModel.fromJson(res['user_info']);
    dashModel.userModel = userModel;
    ProfileInsightModel insightModel = ProfileInsightModel.fromJson(res['insight_list']);
    dashModel.insightModel = insightModel;
    
    List<dynamic> levelList = res['level_list'];
    for(int i = 0; i < levelList.length; i++){
      dashModel.levelList!.add(ProfileLevelModel.fromJson(levelList[i]));
    }
    
    return dashModel;
  }

  Future<UserModel?> doAddScore(String token, AddScoreReq req) async {
    var res = await doPostRequest(ApiUtils.urlAddScore,
        param: req.toJson(), token: TokenReq(token: token).toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future doDeleteProfile(String token) async {
    var res = await doPostRequest(ApiUtils.urlDeleteUserProfile,
        token: TokenReq(token: token).toJson());
    if (res == null) return false;

    return true;
  }

  Future doResetScore(String token) async {
    var res = await doPostRequest(ApiUtils.urlResetScore,
        token: TokenReq(token: token).toJson());
    if (res == null) return false;

    return true;
  }

  Future<UserModel?> doDeleteRecyclableItem(String token, DeleteRecyclableReq req) async {
    var res = await doPostRequest(ApiUtils.urlDeleteRecyclableItem,
        token: TokenReq(
          token: token,
        ).toJson(),
        param: req.toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doUpdateRecyclableCount(String token, UpdateRecyclableReq req) async {
    var res = await doPostRequest(ApiUtils.urlUpdateRecyclableItemCount,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future doPostSupport(String token, PostSupportReq req) async {
    var res = await doPostRequest(ApiUtils.urlPostSupport,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doPostShare(String token, PostSupportReq req) async {
    var res = await doPostRequest(ApiUtils.urlPostShare,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doChargeCard(String token, ChargeCardReq req) async {
    var res = await doPostRequest(ApiUtils.urlChargeCard,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doChargeGoogle(String token, ChargeGoogleReq req) async {
    var res = await doPostRequest(ApiUtils.urlChargeGoogle,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doChargeApple(String token, ChargeAppleReq req) async {
    var res = await doPostRequest(ApiUtils.urlChargeApple,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doChargeIAP(String token, ChargeIapReq req) async {
    var res = await doPostRequest(ApiUtils.urlChargeIAP,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doChargeIAPGoogle(String token, ChargeIapGoogleReq req) async {
    var res = await doPostRequest(ApiUtils.urlChargeIAPGoogle,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }


  Future doCancelSubscription(String token, CancelSubscriptionReq req) async {
    var res = await doPostRequest(ApiUtils.urlCancelSubscription,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doUpdatePayment(String token, UpdatePaymentReq req) async {
    var res = await doPostRequest(ApiUtils.urlUpdatePaymentInfo,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future<String?> doGetStripeKey(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetStripeKey,
        token: TokenReq(token: token).toJson());
    if (res == null) return null;

    String publishKey = res['publish_key'];
    return publishKey;
  }

  Future<String?> doGetPaymentMethodInfo(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetPaymentMethodInfo,
        token: TokenReq(token: token).toJson());
    if (res == null) return null;

    Map stripe = res[1];
    Map attribute = stripe['attributes'];
    String environment = stripe['environment'];
    String? publishKey; 
    if(environment == '0'){
      publishKey = attribute['test_publishable_key'];
    }else {
      publishKey = attribute['publishable_key'];
    }
    
    return publishKey;
  }

  Future<SubscriptionInfoModel?> doGetSubscriptionInfo(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetSubscriptionInfo,
        token: TokenReq(token: token).toJson());

    if (res == null) return null;
    SubscriptionInfoModel model = SubscriptionInfoModel.fromJson(res['subscription_info']);
    return model;
  }

  Future<List<PaymentHistoryItemModel>?> doGetPaymentHistory(
      String token) async {
    var res = await doPostRequest(ApiUtils.urlGetPaymentHistory,
        token: TokenReq(token: token).toJson());

    if (res == null) return null;
    List<dynamic> _list = res['history'];
    List<PaymentHistoryItemModel> list = [];
    for (int i = 0; i < _list.length; i++) {
      list.add(PaymentHistoryItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future doSetShoppingDay(String token, ShoppingDayReq req) async {
    var res = await doPostRequest(ApiUtils.urlSetShoppingDay,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

  Future doGetReferralCode(String token) async {
    var res = await doGetRequest(
        ApiUtils.urlGetReferralCode, TokenReq(token: token).toJson());
    if (res == null) return '';

    String code = res['referral_code'];
    return code;
  }

    Future doAddPostalAddress(String token, AddPostalAddressReq req) async {
    var res = await doPostRequest(ApiUtils.urlAddPostalAddress,
        token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return false;

    return true;
  }

}
