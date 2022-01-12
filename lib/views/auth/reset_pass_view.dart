import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/reset_pass_view_model.dart';

class ResetPassView extends StatelessWidget {
  ResetPassView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerEmail =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPassViewModel>.reactive(
      viewModelBuilder: () => ResetPassViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ResetPassViewModel model, Widget? child) {
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
              leading: BackButton(
                color: ColorUtils.appColorBlack,
                onPressed: () {
                  model.onClickRemember(context);
                },
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: height * 0.1,
                      alignment: Alignment.center,
                      child: textView(StringUtils.txtResetPassword,
                          textColor: ColorUtils.appColorBlack,
                          fontSize: SizeUtils.textSizeLarge,
                          fontWeight: FontWeight.w600,
                          isCentered: true),
                    ),
                    Container(
                      height: height * 0.1,
                      alignment: Alignment.center,
                      child: textView(StringUtils.txtWeWillSend,
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
                          Expanded(
                            child: SizedBox(
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EditTextField(
                                    hintText: StringUtils.txtEmail,
                                    isPassword: false,
                                    isSecure: false,
                                    mController: textEditingControllerEmail,
                                    borderColor: ColorUtils.appColorBlack_10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    child: RoundButton(
                                        isStroked: false,
                                        textContent: StringUtils.txtSend,
                                        textSize: SizeUtils.textSizeMedium,
                                        radius: 30,
                                        onPressed: () =>
                                            model.onClickSend(context)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        child: textViewUnderline(
                                          StringUtils.txtIRemember,
                                          textColor: ColorUtils.appColorAccent,
                                          fontSize: SizeUtils.textSizeMedium,
                                          fontWeight: FontWeight.w500,
                                          isCentered: false,
                                        ),
                                        onTap: () =>
                                            model.onClickRemember(context),
                                      ),
                                    ),
                                  ),
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
          model.onClickRemember(context);
          return Future.value(false);
        });
  }
}
