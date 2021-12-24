import 'dart:async';
import 'dart:convert';

import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/user_model.dart';
import 'package:zimbo/services/common_service.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zimbo/views/auth/intro_view.dart';

class SplashViewModel extends BaseViewModel{
  late SharedPreferences prefs;
  late UserModel userModel;

  initialize(BuildContext context) async {
    prefs = await CommonService.prefs;
    var modelStr = prefs.getString(StringUtils.txtPrefUser);
    if(modelStr != null){
      Map<String,dynamic> userMap = jsonDecode(modelStr) as Map<String, dynamic>;
      userModel = UserModel.fromJson(userMap);
    }else{
      Timer(const Duration(seconds: 3), () {
        const IntroView().launch(context, isNewTask: true);
    });
    }
  }
}