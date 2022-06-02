import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/login_req.dart';
import 'package:zimbo/model/request/signup_facebook_req.dart';
import 'package:zimbo/model/request/signup_google_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/forgot_pass_view.dart';
import 'package:zimbo/views/auth/reset_pass_view.dart';
import 'package:zimbo/views/auth/select_item_view.dart';
import 'package:zimbo/views/auth/signup_view.dart';
import 'package:zimbo/views/main/main_view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../model/common/subscription_status_model.dart';
import '../../model/request/signup_apple_req.dart';
import '../../views/other/subscription/subscription_lock_view.dart';

class LoginViewModel extends BaseViewModel {
  String email = '';
  String password = '';
  String? deviceKey = '';
  late GoogleSignIn googleSignIn;
  bool initialUriIsHandled = false;
  String? firebaseToken = '';
  String platformType = '';

  initialize(BuildContext context) async {
    handleIncomingLinks(context);
    deviceKey = await getDeviceId();
    googleSignIn = GoogleSignIn();
    firebaseToken = await FirebaseMessaging.instance.getToken();
    if (Platform.isAndroid) {
      platformType = 'android';
    } else if (Platform.isIOS) {
      platformType = 'ios';
    }
  }

  onClickFacebookLogin(BuildContext context) async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken!;
        final profile = await fb.getUserProfile();
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        final email = await fb.getUserEmail();

        SignUpFacebookReq req = SignUpFacebookReq(
            name: profile!.name!,
            facebookId: accessToken.token,
            email: email!,
            image: imageUrl!,
            deviceKey: deviceKey!,
            firebaseToken: firebaseToken!,
            deviceType: platformType);
        networkService.doSignUpFacebook(req).then((value) async => {
              if (value != null)
                {
                  sharedService.saveUser(value),
                  if (await sharedService.getIsFirst())
                    {
                      const SelectItemView().launch(context, isNewTask: true),
                    }
                  else
                    {
                     if (value.subscriptionInfo == null ||
                        value.subscriptionInfo!.status !=
                            SubscriptionStatusModel.active)
                      {
                        const SubscriptionLockView().launch(context),
                      }
                      else
                        {
                          MainView().launch(context, isNewTask: true),
                        },
                    }
                }
            });

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        showMessage('Error while log in: ${res.error}', null);
        break;
    }
  }

  onClickGoogleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount? _currentUser;
      googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        _currentUser = account;

        if (_currentUser != null) {
          SignUpGoogleReq req = SignUpGoogleReq(
              userName: _currentUser!.displayName!,
              googleId: _currentUser!.id,
              email: _currentUser!.email,
              image: _currentUser!.photoUrl!,
              deviceKey: deviceKey!,
              firebaseToken: firebaseToken!,
              deviceType: platformType);

          networkService.doSignUpGoogle(req).then((value) async => {
                if (value != null)
                  {
                    sharedService.saveUser(value),
                    if (await sharedService.getIsFirst())
                      {
                        const SelectItemView().launch(context, isNewTask: true),
                      }
                    else
                      {
                        if (value.subscriptionInfo == null ||
                        value.subscriptionInfo!.status !=
                            SubscriptionStatusModel.active)
                        {
                          const SubscriptionLockView().launch(context),
                        }
                        else
                          {
                            MainView().launch(context, isNewTask: true),
                          },
                      }
                  }
              });
        } else {
          showMessage('Error while log in', null);
        }
      });
      googleSignIn.signInSilently();

      await googleSignIn.signIn();
    } catch (error) {
      showMessage(StringUtils.txtSomethingWentWrong, null);
    }

    notifyListeners();
  }

  onClickAppleLogin(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      String userName = '';
      String userEmail = '';
      if (credential.givenName != null && credential.familyName != null) {
        userName = credential.givenName! + ' ' + credential.familyName!;
      }
      if (credential.email != null) {
        userEmail = credential.email!;
      }

      SignUpAppleReq req = SignUpAppleReq(
          userName: userName,
          appleId: credential.userIdentifier!,
          email: userEmail,
          deviceKey: deviceKey!,
          firebaseToken: firebaseToken!,
          deviceType: platformType);

      networkService.doSignUpApple(req).then((value) async => {
            if (value != null)
              {
                sharedService.saveUser(value),
                if (await sharedService.getIsFirst())
                  {
                    const SelectItemView().launch(context, isNewTask: true),
                  }
                else
                  {
                    if (value.subscriptionInfo == null ||
                        value.subscriptionInfo!.status !=
                            SubscriptionStatusModel.active)
                      {
                        const SubscriptionLockView().launch(context),
                      }
                      else
                        {
                          MainView().launch(context, isNewTask: true),
                        },
                  }
              }
          });
    } catch (error) {
      showMessage(StringUtils.txtSomethingWentWrong, null);
    }

    notifyListeners();
  }

  onClickLogin(BuildContext context, String _email, String _password) async {
    email = _email.trim();
    password = _password;

    if (checkValidate()) {
      LoginReq req = LoginReq(
          email: email,
          password: password,
          deviceKey: deviceKey ?? '',
          firebaseToken: firebaseToken!,
          deviceType: platformType);

      await networkService.doLogin(req).then((value) => {
            if (value != null)
              {
                sharedService.saveUser(value),
                if (value.subscriptionInfo == null ||
                        value.subscriptionInfo!.status !=
                            SubscriptionStatusModel.active)
                      {
                        const SubscriptionLockView().launch(context),
                      }
                      else
                        {
                          MainView().launch(context, isNewTask: true),
                        },
              }
          });
    }
  }

  onClickRegister(BuildContext context) {
    SignUpView().launch(context, isNewTask: false);
  }

  onClickResetPass(BuildContext context) {
    ForgotPassView().launch(context, isNewTask: false);
  }

  bool checkValidate() {
    if (email.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterNameOrEmail, null);
      return false;
    }
    if (password.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return false;
    }
    // if (!isValidEmail(email)) {
    //   showMessage(StringUtils.txtPleaseEnterCorrectEmail, null);
    //   return false;
    // }
    if (!isValidPassword(password)) {
      showMessage(StringUtils.txtPleaseEnterCorrectPassword, null);
      return false;
    }
    return true;
  }

  void handleIncomingLinks(BuildContext context) {
    uriLinkStream.listen((Uri? uri) async {
      if (uri != null && uri.toString().contains('token=')) {
        if (!initialUriIsHandled) {
          initialUriIsHandled = true;
          String uriStr = uri.toString();
          String token = uriStr.split('token=')[1];
          ResetPassView(token: token).launch(context);
        }
      }
    }, onError: (Object err) {});
  }
}
