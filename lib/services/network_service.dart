import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimbo/locator.dart';
import 'package:zimbo/model/common/payment_history_item_model.dart';
import 'package:zimbo/model/common/point_item_model.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/common/subscription_info_model.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/add_score_req.dart';
import 'package:zimbo/model/request/auto_login_req.dart';
import 'package:zimbo/model/request/delete_recyclable_req.dart';
import 'package:zimbo/model/request/forgot_password_req.dart';
import 'package:zimbo/model/request/login_req.dart';
import 'package:zimbo/model/request/post_support_req.dart';
import 'package:zimbo/model/request/reset_password_req.dart';
import 'package:zimbo/model/request/shopping_day_req.dart';
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

  Future doCancelPayment(String token) async {
    var res = await doPostRequest(ApiUtils.urlCancelPayment,
        token: TokenReq(token: token).toJson());
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

  Future<SubscriptionInfoModel?> doGetSubscriptionInfo(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetSubscriptionInfo,
        token: TokenReq(token: token).toJson());

    if (res == null) return null;
    SubscriptionInfoModel model = SubscriptionInfoModel.fromJson(res);
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

}
