import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_select_view_model.dart';

import '../../../utils/image_utils.dart';

class SubscriptionSelectView extends StatelessWidget {
  const SubscriptionSelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionSelectViewModel>.reactive(
      viewModelBuilder: () => SubscriptionSelectViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionSelectViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                finishView(context);
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: height * 0.15,
                alignment: Alignment.center,
                child: textView(StringUtils.txtChooseYourPaymentMethod,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeXLarge,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
                    maxLine: 2),
              ),
              GestureDetector(
                child: Container(
                  height: height * 0.1,
                  alignment: Alignment.center,
                  child: textView(StringUtils.txt199Month,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeLarge,
                      fontWeight: FontWeight.w600,
                      isCentered: true,
                      maxLine: 2),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                            onPressed: () => model.onClickApplePay(context),
                            icon: SvgPicture.asset(
                              ImageUtils.imgIcApple,
                              width: 30,
                              height: 30,
                            ),
                            label: textView(StringUtils.txtPay,
                                textColor: ColorUtils.appColorBlack,
                                fontSize: SizeUtils.textSizeLarge,
                                fontWeight: FontWeight.w500,
                                isCentered: true),
                            style: ElevatedButton.styleFrom(
                                primary: ColorUtils.appColorWhite,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                      ),
                    ).visible(Platform.isIOS),
                    //.visible(model.isApplePay),
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                            onPressed: () => model.onClickGooglePay(context),
                            icon: SvgPicture.asset(
                              ImageUtils.imgIcGoogle,
                              width: 30,
                              height: 30,
                            ),
                            label: textView(StringUtils.txtPay,
                                textColor: ColorUtils.appColorBlack,
                                fontSize: SizeUtils.textSizeLarge,
                                fontWeight: FontWeight.w500,
                                isCentered: true),
                            style: ElevatedButton.styleFrom(
                                primary: ColorUtils.appColorWhite,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                      ),
                    ).visible(model.isGooglePay),
                    Container(
                      width: width,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton.icon(
                            onPressed: () => model.onClickCardPay(context),
                            icon: SvgPicture.asset(
                              ImageUtils.imgIcCard,
                              width: 30,
                              height: 30,
                            ),
                            label: textView(StringUtils.txtPay,
                                textColor: ColorUtils.appColorBlack,
                                fontSize: SizeUtils.textSizeLarge,
                                fontWeight: FontWeight.w500,
                                isCentered: true),
                            style: ElevatedButton.styleFrom(
                                primary: ColorUtils.appColorWhite,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
