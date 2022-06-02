import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_confirm_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class SubscriptionConfirmView extends StatelessWidget {
  SubscriptionConfirmView({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerAddress =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionConfirmViewModel>.reactive(
      viewModelBuilder: () => SubscriptionConfirmViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionConfirmViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
            title: textView(StringUtils.txtSubscription,
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
            child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.1,),
              textView(StringUtils.txtSubscriptionConfirmed,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeLarge,
                  fontWeight: FontWeight.w600,
                  isCentered: true,
                  maxLine: 2),
              SizedBox(height: height * 0.1,),  
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  textView(StringUtils.txtTimeToReceiveKey,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeNormal,
                      fontWeight: FontWeight.w400,
                      isCentered: true,
                      maxLine: 2),
                  SizedBox(height: height * 0.05,),  
                  textView(StringUtils.txtPleaseEnterPostalAddress,
                      textColor: ColorUtils.appColorWhite_50,
                      fontSize: SizeUtils.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      isCentered: true,
                      maxLine: 2),
                  SizedBox(height: height * 0.01,),  
                  EditTextField(
                    hintText: StringUtils.txtPostalAddress,
                    hintColor: ColorUtils.appColorWhite,
                    isPassword: false,
                    isSecure: false,
                    mController: textEditingControllerAddress,
                    borderColor: ColorUtils.appColorWhite,
                    textColor: ColorUtils.appColorWhite,
                  ),
                  SizedBox(height: height * 0.1,),  
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RoundButton(
                      isStroked: false,
                      textContent: StringUtils.txtSubmit,
                      textSize: SizeUtils.textSizeMedium,
                      radius: 30,
                      onPressed: () => model.onClickSubmit(context, textEditingControllerAddress.text),
                    ),
                  )
                ],
              )
            ],
          ),
          )
          
        ),
        onWillPop: () {
          MainView().launch(context, isNewTask: true);
          return Future.value(false);
        });
  }
}
