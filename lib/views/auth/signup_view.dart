import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerName =
      TextEditingController();
  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();
  final TextEditingController textEditingControllerReferralCode =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SignUpViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorBlue);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Image.asset(ImageUtils.imgIcLogo,
                  width: width * 0.15, fit: BoxFit.scaleDown),
              backgroundColor: ColorUtils.appColorBlue,
              centerTitle: true,
              elevation: 0,
              leading: BackButton(
                color: ColorUtils.appColorWhite,
                onPressed: () {
                  model.onClickBack(context);
                },
              ),
            ),
            body: SingleChildScrollView(
                child: Stack(
              children: <Widget>[
                Container(
                  color: ColorUtils.appColorBlue,
                  width: width,
                  height: height,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: height * 0.1,
                        alignment: Alignment.center,
                        child: textView(StringUtils.txtSignUp,
                            textColor: ColorUtils.appColorWhite,
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
                                  onPressed: () =>
                                      model.onClickFacebookLogin(context),
                                  icon: SvgPicture.asset(
                                      ImageUtils.imgIcFacebook),
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
                                  onPressed: () =>
                                      model.onClickGoogleLogin(context),
                                  icon:
                                      SvgPicture.asset(ImageUtils.imgIcGoogle),
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
                            textColor: ColorUtils.appColorWhite,
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
                        height: height * 0.75,
                        child: Column(
                          children: [
                            textView(StringUtils.txtCreateAnAccount,
                                textColor: ColorUtils.appColorTextDark,
                                fontSize: SizeUtils.textSizeNormal,
                                fontWeight: FontWeight.w600,
                                isCentered: true),
                            EditTextField(
                              hintText: StringUtils.txtUserName,
                              isPassword: false,
                              isSecure: false,
                              mController: textEditingControllerName,
                              borderColor: ColorUtils.appColorBlack_10,
                            ),
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
                            EditTextField(
                              hintText: StringUtils.txtReferralCode,
                              isPassword: false,
                              isSecure: false,
                              mController: textEditingControllerReferralCode,
                              borderColor: ColorUtils.appColorBlack_10,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: width,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: RoundButton(
                                          isStroked: false,
                                          textContent: StringUtils.txtSignUp,
                                          textSize: SizeUtils.textSizeMedium,
                                          radius: 30,
                                          onPressed: () => model.onClickSignUp(
                                              context,
                                              textEditingControllerName.text,
                                              textEditingControllerEmail.text,
                                              textEditingControllerPassword.text,
                                              textEditingControllerReferralCode.text,
                                              )),
                                    ),
                                    Column(
                                      children: [
                                        textView(StringUtils.txtByTap,
                                            textColor:
                                                ColorUtils.appColorTextWhite,
                                            fontSize: SizeUtils.textSizeSMedium,
                                            fontWeight: FontWeight.w400,
                                            isCentered: false),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              child: textViewUnderline(
                                                StringUtils.txtPrivacyPolicy,
                                                textColor:
                                                    ColorUtils.appColorAccent,
                                                fontSize:
                                                    SizeUtils.textSizeMedium,
                                                fontWeight: FontWeight.w500,
                                                isCentered: false,
                                              ),
                                              onTap: () =>
                                                  model.onClickPrivacy(context),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            textView(StringUtils.txtAnd,
                                                textColor: ColorUtils
                                                    .appColorTextWhite,
                                                fontSize:
                                                    SizeUtils.textSizeSMedium,
                                                fontWeight: FontWeight.w400,
                                                isCentered: false),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              child: textViewUnderline(
                                                StringUtils.txtTermsAndCondition,
                                                textColor:
                                                    ColorUtils.appColorAccent,
                                                fontSize:
                                                    SizeUtils.textSizeMedium,
                                                fontWeight: FontWeight.w500,
                                                isCentered: false,
                                              ),
                                              onTap: () => model
                                                  .onClickCondition(context),
                                            ),
                                          ],
                                        )
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
              ],
            ))),
        onWillPop: () {
          model.onClickBack(context);
          return Future.value(false);
        });
  }
}
