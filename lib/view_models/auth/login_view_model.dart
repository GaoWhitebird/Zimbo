import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/login_req.dart';
import 'package:zimbo/model/request/signup_facebook_req.dart';
import 'package:zimbo/model/request/signup_google_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/reset_pass_view.dart';
import 'package:zimbo/views/auth/signup_view.dart';
import 'package:zimbo/views/main/main_view.dart';

class LoginViewModel extends BaseViewModel {
  String email = '';
  String password = '';
  String? deviceKey = '';
  late GoogleSignIn googleSignIn;

  initialize(BuildContext context) async {
    deviceKey = await getDeviceId();
    googleSignIn = GoogleSignIn();
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
          deviceKey: deviceKey!);
        networkService.doSignUpFacebook(req).then((value) => {
          if (value != null)
                {
                  sharedService.saveUser(value),
                  MainView().launch(context, isNewTask: true),
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
          deviceKey: deviceKey!);

          networkService.doSignUpGoogle(req).then((value) => {
            if (value != null)
                  {
                    sharedService.saveUser(value),
                    MainView().launch(context, isNewTask: true),
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

  onClickLogin(BuildContext context, String _email, String _password) async {
    email = _email.trim();
    password = _password;

    if (checkValidate()) {
      LoginReq req = LoginReq(
          email: email, password: password, deviceKey: deviceKey ?? '');

      await networkService.doLogin(req).then((value) => {
            if (value != null)
              {
                sharedService.saveUser(value),
                MainView().launch(context, isNewTask: true),
              }
          });
    }
  }

  onClickRegister(BuildContext context) {
    SignUpView().launch(context, isNewTask: false);
  }

  onClickResetPass(BuildContext context) {
    ResetPassView().launch(context, isNewTask: false);
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
}
