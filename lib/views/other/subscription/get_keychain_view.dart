import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/get_keychain_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class GetKeychainView extends StatelessWidget {
  GetKeychainView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerAddress1 =
      TextEditingController();
  final TextEditingController textEditingControllerAddress2 =
      TextEditingController();
  final TextEditingController textEditingControllerSuburb =
      TextEditingController();
  final TextEditingController textEditingControllerState =
      TextEditingController();
  final TextEditingController textEditingControllerPostCode =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetKeychainViewModel>.reactive(
      viewModelBuilder: () => GetKeychainViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(
          context,
          textEditingControllerAddress1,
          textEditingControllerAddress2,
          textEditingControllerSuburb,
          textEditingControllerState,
          textEditingControllerPostCode),
    );
  }

  buildWidget(BuildContext context, GetKeychainViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
            backgroundColor: ColorUtils.appColorBlue,
            appBar: AppBar(
              title: textView(StringUtils.txtPostalAddress,
                  textColor: ColorUtils.appColorTextTitle,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w500,
                  isCentered: true),
              backgroundColor: ColorUtils.appColorWhite,
              centerTitle: true,
              elevation: 0,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              leading: BackButton(
                color: ColorUtils.appColorBlack,
                onPressed: () {
                  MainView().launch(context, isNewTask: true);
                },
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      textView(StringUtils.txtTimeToReceiveKey,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeMedium,
                          fontWeight: FontWeight.w400,
                          isCentered: true,
                          maxLine: 2),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      textView(StringUtils.txtPleaseEnterPostalAddress,
                          textColor: ColorUtils.appColorWhite_50,
                          fontSize: SizeUtils.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          isCentered: true,
                          maxLine: 2),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtAddressLine1,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerAddress1,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtAddressLine2,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerAddress2,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      EditTextField(
                        hintText: StringUtils.txtSuburb,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerSuburb,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                      ),
                      Stack(
                        children: <Widget>[
                          EditTextField(
                            hintText: StringUtils.txtState,
                            hintColor: ColorUtils.appColorWhite,
                            isPassword: false,
                            isSecure: false,
                            mController: textEditingControllerState,
                            borderColor: ColorUtils.appColorWhite,
                            textColor: ColorUtils.appColorWhite,
                            autoFocus: false,
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              model.showBottomPicker(
                                  context, textEditingControllerState);
                            },
                          ),
                        ],
                      ),
                      EditTextField(
                        hintText: StringUtils.txtPostCode,
                        hintColor: ColorUtils.appColorWhite,
                        isPassword: false,
                        isSecure: false,
                        mController: textEditingControllerPostCode,
                        borderColor: ColorUtils.appColorWhite,
                        textColor: ColorUtils.appColorWhite,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: RoundButton(
                            isStroked: false,
                            textContent: StringUtils.txtSubmit,
                            textSize: SizeUtils.textSizeMedium,
                            radius: 30,
                            onPressed: () => model.onClickSubmit(
                                  context,
                                  textEditingControllerAddress1.text,
                                  textEditingControllerAddress2.text,
                                  textEditingControllerSuburb.text,
                                  textEditingControllerState.text,
                                  textEditingControllerPostCode.text,
                                )),
                      )
                    ],
                  )
                ],
              ),
            )),
        onWillPop: () {
          MainView().launch(context, isNewTask: true);
          return Future.value(false);
        });
  }
}
