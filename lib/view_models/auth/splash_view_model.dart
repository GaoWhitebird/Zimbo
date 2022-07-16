import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/auto_login_req.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/views/auth/intro_view.dart';
import 'package:zimbo/views/auth/login_view.dart';
import 'package:zimbo/views/main/main_view.dart';

import '../../model/common/subscription_status_model.dart';
import '../../views/other/subscription/get_keychain_view.dart';
import '../../views/other/subscription/subscription_lock_view.dart';

class SplashViewModel extends BaseViewModel {
  String? deviceKey = '';
  late UserModel? userModel;
  String? firebaseToken = '';
  String platformType = '';

  initialize(BuildContext context) async {
    await Firebase.initializeApp();
    String? token = await sharedService.getToken();

    if (token != null) {
      userModel = await sharedService.getUser();
      if (userModel == null) {
        LoginView().launch(context);
        return;
      }

      deviceKey = userModel!.userEmail;
      firebaseToken = await FirebaseMessaging.instance.getToken();
      if (Platform.isAndroid) {
        platformType = 'android';
      } else if (Platform.isIOS) {
        platformType = 'ios';
      }

      AutoLoginReq req = AutoLoginReq(
          token: token,
          deviceKey: deviceKey ?? '',
          firebaseToken: firebaseToken!,
          deviceType: platformType);

      await networkService.doAutoLogin(req).then((value) => {
            if (value != null)
              {
                userModel = value,
                sharedService.saveUser(userModel),
                if (userModel!.subscriptionInfo == null ||
                    userModel!.subscriptionInfo!.status !=
                        SubscriptionStatusModel.active)
                  {
                    const SubscriptionLockView()
                        .launch(context, isNewTask: true),
                  }
                else
                  {
                    if (value.country!.isEmpty || value.zipCode!.isEmpty) {
                      GetKeychainView().launch(context, isNewTask: true)
                    } else {
                        MainView().launch(context, isNewTask: true),
                    }
                  },
              }
            else
              {
                LoginView().launch(context, isNewTask: true),
              }
          });
    } else {
      Timer(const Duration(seconds: 3), () {
        const IntroView().launch(context, isNewTask: true);
      });
    }
  }
}
