import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/plan_name_model.dart';
import 'package:zimbo/model/common/subscription_status_model.dart';
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
                height: height * 0.15,
                alignment: Alignment.center,
                child: textView(StringUtils.txtTimeToTakeItPersonally,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeXLarge,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
                    maxLine: 2),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        ImageUtils.imgIcUnLock,
                        color: ColorUtils.appColorWhite,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      textView(StringUtils.txtUnlockZimboSmall,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          fontWeight: FontWeight.w600,
                          isCentered: true,
                          maxLine: 2),
                    ],
                  )),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(
                    color: ColorUtils.appColorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01,
                          width * 0.01, width * 0.01),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            ImageUtils.imgIcCheckCircleSuccess,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          textView(StringUtils.txtPersonalSustainabilityScore,
                              textColor: ColorUtils.appColorTextLight,
                              fontSize: SizeUtils.textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              maxLine: 2),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01,
                          width * 0.01, width * 0.01),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            ImageUtils.imgIcCheckCircleSuccess,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          textView(StringUtils.txtMonitorMoneySavedFromReuse,
                              textColor: ColorUtils.appColorTextLight,
                              fontSize: SizeUtils.textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              maxLine: 2),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01,
                          width * 0.01, width * 0.01),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            ImageUtils.imgIcCheckCircleSuccess,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          textView(StringUtils.txtMonitorPersonalCarbonOffset,
                              textColor: ColorUtils.appColorTextLight,
                              fontSize: SizeUtils.textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              maxLine: 2),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01,
                          width * 0.01, width * 0.01),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            ImageUtils.imgIcCheckCircleSuccess,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          textView(StringUtils.txtMonitorPositiveEnvironment,
                              textColor: ColorUtils.appColorTextLight,
                              fontSize: SizeUtils.textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              maxLine: 2),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(width * 0.05, width * 0.01,
                          width * 0.01, width * 0.01),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            ImageUtils.imgIcCheckCircleSuccess,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          textView(StringUtils.txtExclusiveOffersAndDiscounts,
                              textColor: ColorUtils.appColorTextLight,
                              fontSize: SizeUtils.textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              maxLine: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                alignment: Alignment.center,
                child: textView(StringUtils.txtTry14DaysFree,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeSMedium,
                    fontWeight: FontWeight.w600,
                    isCentered: true,
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
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RoundButton(
                  isStroked: false,
                  backgroundColor: ColorUtils.appColorWhite,
                  textColor: ColorUtils.appColorTextTitle,
                  textContent: StringUtils.txtContinueAsFree,
                  textSize: SizeUtils.textSizeMedium,
                  radius: 30,
                  onPressed: () => model.onClickContinueFree(context),
                ),
              )
              //.visible(false)
              .visible(model.userModel != null &&
                  model.userModel!.subscriptionInfo != null &&
                  model.userModel!.subscriptionInfo!.planName ==
                      PlanNameModel.free &&
                  model.userModel!.subscriptionInfo!.status ==
                      SubscriptionStatusModel.active)
              ,
              Container(
                margin: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                alignment: Alignment.center,
                child: textView(StringUtils.txtNoNeedToPay,
                    textColor: ColorUtils.appColorWhite_50,
                    fontSize: SizeUtils.textSizeSmall,
                    fontWeight: FontWeight.w400,
                    isCentered: true,
                    maxLine: 2),
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
