import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/login_view.dart';

class MenuViewModel extends BaseViewModel {
  String version = '1.0.0';
  String? token;
  UserModel? userModel;

  initialize(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();

    notifyListeners();
  }

  onClickLogout(BuildContext context) async {
    try {
      if (userModel!.signupType == 'facebook') {
        final fb = FacebookLogin();
        fb.logOut();
      } else if (userModel!.signupType == 'google') {
        GoogleSignIn googleSignIn = GoogleSignIn();
        googleSignIn.signOut();
      }
    } catch (error) {}

    networkService.doLogout(token!).then((value) => {
          if (value)
            {
              sharedService.saveToken(''),
              sharedService.saveUser(null),
              LoginView().launch(context, isNewTask: true),
            }
        });
  }
}
