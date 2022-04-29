import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_lock_view_model.dart';

class SubscriptionLockView extends StatelessWidget {
  const SubscriptionLockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionLockViewModel>.reactive(
      viewModelBuilder: () => SubscriptionLockViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionLockViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
            title: textView(StringUtils.txtUnlockZimbo,
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
                height: height * 0.1,
                alignment: Alignment.center,
                child: textView(StringUtils.txtTimeToTakeItPersonally,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeLarge,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
                    maxLine: 2),
              ),
              Container(
                alignment: Alignment.center,
                child: textView(StringUtils.txtUnlockZimbo,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeNormal,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
                    maxLine: 2),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01, width * 0.01, width * 0.01),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: const <Widget>[
                            Icon(
                              Icons.circle,
                              size: 25,
                              color: ColorUtils.appColorAccent,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: ColorUtils.appColorWhite,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        textView(StringUtils.txtPersonalSustainabilityScore,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            maxLine: 2),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01, width * 0.01, width * 0.01),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: const <Widget>[
                            Icon(
                              Icons.circle,
                              size: 25,
                              color: ColorUtils.appColorAccent,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: ColorUtils.appColorWhite,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        textView(StringUtils.txtMonitorMoneySavedFromReuse,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            maxLine: 2),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01, width * 0.01, width * 0.01),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: const <Widget>[
                            Icon(
                              Icons.circle,
                              size: 25,
                              color: ColorUtils.appColorAccent,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: ColorUtils.appColorWhite,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        textView(StringUtils.txtMonitorPersonalCarbonOffset,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            maxLine: 2),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01, width * 0.01, width * 0.01),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: const <Widget>[
                            Icon(
                              Icons.circle,
                              size: 25,
                              color: ColorUtils.appColorAccent,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: ColorUtils.appColorWhite,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        textView(StringUtils.txtMonitorPositiveEnvironment,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            maxLine: 2),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01, width * 0.01, width * 0.01),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: const <Widget>[
                            Icon(
                              Icons.circle,
                              size: 25,
                              color: ColorUtils.appColorAccent,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: ColorUtils.appColorWhite,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        textView(StringUtils.txtExclusiveOffersAndDiscounts,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            maxLine: 2),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                alignment: Alignment.centerLeft,
                child: textView(StringUtils.txtTry14DaysFree,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeMedium,
                    fontWeight: FontWeight.w400,
                    isCentered: false,
                    maxLine: 2),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: RoundButton(
                    isStroked: false,
                    textContent: StringUtils.txtContinue,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 30,
                    onPressed: () => model.onClickContinue(context),
              ),
              )
            ],
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
