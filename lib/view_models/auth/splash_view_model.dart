import 'dart:async';

import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/auto_login_req.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/views/auth/intro_view.dart';
import 'package:zimbo/views/auth/login_view.dart';
import 'package:zimbo/views/main/main_view.dart';

class SplashViewModel extends BaseViewModel{
  String? deviceKey = '';
  late UserModel? userModel;
  initialize(BuildContext context) async {
    String? token = await sharedService.getToken();
    deviceKey = await getDeviceId();
    
    if(token != null){
      AutoLoginReq req = AutoLoginReq(token: token, deviceKey: deviceKey ?? '');

      await networkService.doAutoLogin(req).then((value) => {
        if(value != null){
          userModel = value,
          sharedService.saveUser(userModel),
          MainView().launch(context, isNewTask: true),
        }else {
          LoginView().launch(context, isNewTask: true),
        }
      });
    }else{
      Timer(const Duration(seconds: 3), () {
        const IntroView().launch(context, isNewTask: true);
    });
    }
  }
}