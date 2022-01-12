import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimbo/locator.dart';
import 'package:zimbo/model/common/point_item_model.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/add_score_req.dart';
import 'package:zimbo/model/request/auto_login_req.dart';
import 'package:zimbo/model/request/delete_recyclable_req.dart';
import 'package:zimbo/model/request/login_req.dart';
import 'package:zimbo/model/request/post_support_req.dart';
import 'package:zimbo/model/request/signup_email_req.dart';
import 'package:zimbo/model/request/signup_facebook_req.dart';
import 'package:zimbo/model/request/signup_google_req.dart';
import 'package:zimbo/model/request/token_req.dart';
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
      Response response = await dio.post(
        url,
        queryParameters: token,
        data: param == null ? '' : FormData.fromMap(param),
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
    if(res == null) return null;

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
    var res = await doPostRequest(ApiUtils.urlLoginFacebook, param: req.toJson());
    if(res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doSignUpGoogle(SignUpGoogleReq req) async {
    var res = await doPostRequest(ApiUtils.urlLoginGoogle, param: req.toJson());
    if(res == null) return null;

    String token = res['token'];
    var sharedService = locator<SharedService>();
    sharedService.saveToken(token);

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future doLogout(String token) async {
    var res = await doPostRequest(ApiUtils.urlLogout, token: TokenReq(token: token).toJson());
    if (res == null) return false;

    return true;
  }

  Future<List<RecyclableItemModel>?> doGetRecyclableItemList(String token) async {
    var res = await doGetRequest(ApiUtils.urlGetRecyclableList, TokenReq(token: token).toJson());
    if (res == null) return [];

    List<dynamic> _list = res['recyclable_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++){
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }
    return list;
  }

    Future<List<RecyclableItemModel>?> doGetAvailableRecyclableItemList(String token) async {
    var res = await doGetRequest(ApiUtils.urlGetAvailableRecyclableList, TokenReq(token: token).toJson());
    if (res == null) return [];

    List<dynamic> _list = res['recyclable_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++){
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future<List<RecyclableItemModel>?> doGetUserRecyclableList(String token) async {
    var res = await doGetRequest(ApiUtils.urlGetUserRecyclableList, TokenReq(token: token).toJson());
    if (res == null) return [];

    List<dynamic> _list = res['user_recyclable_item_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++){
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future doAddRecyclableItems(String token, AddRecyclableReq req,) async {
    var res = await doPostRequest(ApiUtils.urlAddRecyclableItems, param: req.toJson(), token: TokenReq(token: token).toJson());
    if (res == null) return null;

    List<dynamic> _list = res['user_recyclable_item_list'];
    List<RecyclableItemModel> list = [];
    for (int i = 0; i < _list.length; i++){
      list.add(RecyclableItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future<List<PointItemModel>?> doGetPointHistory(String token) async {
    var res = await doGetRequest(ApiUtils.urlGetPointHistory, TokenReq(token: token).toJson());
    if(res == null) return [];

    List<dynamic> _list = res['list'];
    List<PointItemModel> list = [];
    for (int i = 0; i < _list.length; i++){
      list.add(PointItemModel.fromJson(_list[i]));
    }
    return list;
  }

  Future<UserModel?> doGetProfile(String token) async {
    var res = await doGetRequest(ApiUtils.urlGetUserProfile, TokenReq(token: token).toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doUpdateProfile(String token, UpdateProfileReq req) async {
    var res = await doPostRequest(ApiUtils.urlUpdateProfile, token: TokenReq(token: token).toJson(), param: req.toJson());
    if (res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future<UserModel?> doAddScore(String token, AddScoreReq req) async {
    var res = await doPostRequest(ApiUtils.urlAddScore, param: req, token: TokenReq(token: token).toJson());
    if(res == null) return null;

    UserModel userModel = UserModel.fromJson(res['user_info']);
    return userModel;
  }

  Future doDeleteProfile(String token) async {
    var res = await doPostRequest(ApiUtils.urlDeleteUserProfile, token: TokenReq(token: token).toJson());
    if(res == null) return false;

    return true;
  }

  Future doDeleteRecyclableItem(String token, DeleteRecyclableReq req) async {
    var res = await doPostRequest(ApiUtils.urlDeleteRecyclableItem, token: TokenReq(token: token,).toJson(), param: req.toJson());
    if(res == null) return false;

    return true;
  }

  Future doUpdateRecyclableCount(String token, UpdateRecyclableReq req) async {
    var res = await doPostRequest(ApiUtils.urlUpdateRecyclableItemCount, token: TokenReq(token: token).toJson(), param: req.toJson());
    if(res == null) return false;

    return true;
  }

  Future doPostSupport(String token, PostSupportReq req) async {
    var res = await doPostRequest(ApiUtils.urlPostSupport, token: TokenReq(token: token).toJson(), param: req.toJson());
    if(res == null) return false;

    return true;
  }
}
