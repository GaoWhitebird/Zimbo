
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/login_view.dart';

class MenuViewModel extends BaseViewModel {

  String version = '1.0.0';
  String? token;

  initialize(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    token = await sharedService.getToken();

    notifyListeners(); 
  }

  onClickLogout(BuildContext context) async {
    networkService.doLogout(token!).then((value) => {
      if(value){
        sharedService.saveToken(''),
        sharedService.saveUser(null),
        LoginView().launch(context, isNewTask: true),
      }
    });
  }

}