import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/subscription_select_view.dart';

import '../../../views/auth/login_view.dart';
import '../../../views/other/subscription/subscription_confirm_view.dart';

class SubscriptionLockViewModel extends BaseViewModel {
  UserModel? userModel;
  String? token;
  initialize(BuildContext context) async {
    userModel = await sharedService.getUser();
    token = await sharedService.getToken();
    notifyListeners();
  }

  onClickContinue(BuildContext context) {
    const SubscriptionSelectView().launch(context);
  }

  onClickContinueFree(BuildContext context) {
    SubscriptionConfirmView().launch(
      context,
    );
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
