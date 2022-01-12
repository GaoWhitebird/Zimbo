import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, LoginViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorPrimaryDark);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: textView(StringUtils.txtAppName,
                  textColor: ColorUtils.appColorTextTitle,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w500,
                  isCentered: true),
              backgroundColor: ColorUtils.appColorPrimaryDark,
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: height * 0.1,
                      alignment: Alignment.center,
                      child: textView(StringUtils.txtLogin,
                          textColor: ColorUtils.appColorBlack,
                          fontSize: SizeUtils.textSizeLarge,
                          fontWeight: FontWeight.w600,
                          isCentered: true),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
                            child: ElevatedButton.icon(
                                onPressed: () => model.onClickFacebookLogin(context),
                                icon:
                                    SvgPicture.asset(ImageUtils.imgIcFacebook),
                                label: textView(StringUtils.txtFacebook,
                                    textColor: ColorUtils.appColorBlack,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w500,
                                    isCentered: true),
                                style: ElevatedButton.styleFrom(
                                    primary: ColorUtils.appColorWhite,
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ))),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
                            child: ElevatedButton.icon(
                                onPressed: () => model.onClickGoogleLogin(context),
                                icon: SvgPicture.asset(ImageUtils.imgIcGoogle),
                                label: textView(StringUtils.txtGoogle,
                                    textColor: ColorUtils.appColorBlack,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w500,
                                    isCentered: true),
                                style: ElevatedButton.styleFrom(
                                    primary: ColorUtils.appColorWhite,
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ))),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: height * 0.1,
                      alignment: Alignment.center,
                      child: textView(StringUtils.txtOr,
                          textColor: ColorUtils.appColorTextLight,
                          fontSize: SizeUtils.textSizeSMedium,
                          fontWeight: FontWeight.w500,
                          isCentered: true),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: ColorUtils.appColorWhite,
                          boxShadow: [
                            BoxShadow(
                                color: ColorUtils.appColorBlack_10,
                                blurRadius: 10,
                                offset: Offset(0, 0)),
                          ]),
                      padding: const EdgeInsets.all(10),
                      width: width,
                      height: height * 0.6,
                      child: Column(
                        children: [
                          textView(StringUtils.txtSigninViaEmail,
                              textColor: ColorUtils.appColorTextDark,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.w600,
                              isCentered: true),
                          const SizedBox(height: 10,),
                          EditTextField(
                            hintText: StringUtils.txtEmail,
                            isPassword: false,
                            isSecure: false,
                            mController: textEditingControllerEmail,
                            borderColor: ColorUtils.appColorBlack_10,
                          ),
                          EditTextField(
                            hintText: StringUtils.txtPassword,
                            isPassword: true,
                            isSecure: true,
                            mController: textEditingControllerPassword,
                            borderColor: ColorUtils.appColorBlack_10,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      textView(StringUtils.txtForgotPassword,
                                          textColor:
                                              ColorUtils.appColorTextWhite,
                                          fontSize: SizeUtils.textSizeSMedium,
                                          fontWeight: FontWeight.w400,
                                          isCentered: false),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        child: textViewUnderline(
                                          StringUtils.txtResetHere,
                                          textColor: ColorUtils.appColorAccent,
                                          fontSize: SizeUtils.textSizeMedium,
                                          fontWeight: FontWeight.w500,
                                          isCentered: false,
                                        ),
                                        onTap: () =>
                                            model.onClickResetPass(context),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: RoundButton(
                                      isStroked: false,
                                      textContent: StringUtils.txtLogin,
                                      textSize: SizeUtils.textSizeMedium,
                                      radius: 30,
                                      onPressed: () => model.onClickLogin(context, textEditingControllerEmail.text, textEditingControllerPassword.text,)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      textView(StringUtils.txtNoAccount,
                                          textColor:
                                              ColorUtils.appColorTextWhite,
                                          fontSize: SizeUtils.textSizeSMedium,
                                          fontWeight: FontWeight.w400,
                                          isCentered: false),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        child: textViewUnderline(
                                          StringUtils.txtRegisterHere,
                                          textColor: ColorUtils.appColorAccent,
                                          fontSize: SizeUtils.textSizeMedium,
                                          fontWeight: FontWeight.w500,
                                          isCentered: false,
                                        ),
                                        onTap: () =>
                                            model.onClickRegister(context),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            )),
        onWillPop: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const ExitDialog(),
          );
          return Future.value(false);
        });
  }
}
