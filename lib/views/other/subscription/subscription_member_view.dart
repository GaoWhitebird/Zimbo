import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/subscription/subscription_member_view_model.dart';

class SubscriptionMemberView extends StatelessWidget {
  const SubscriptionMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionMemberViewModel>.reactive(
      viewModelBuilder: () => SubscriptionMemberViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, SubscriptionMemberViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    var width = MediaQuery.of(context).size.width;
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
                finishView(context);
              },
            ),
          ),
          body: Container(
            color: ColorUtils.appColorWhite,
            child: Stack(
              children: <Widget>[
                SizedBox(height: height,),
                Container(
                  height: height * 0.52,
                  decoration: const BoxDecoration(
                            color: ColorUtils.appColorAccent,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                ),
                Container(
                  height: height * 0.5,
                  width: width,
                  decoration: const BoxDecoration(
                            color: ColorUtils.appColorBlue,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: height * 0.1,
                        alignment: Alignment.center,
                        child: textView(StringUtils.txtUnlockZimbo,
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
                              Image.asset(ImageUtils.imgIcUnLockMain,
                                color: ColorUtils.appColorWhite,
                                width: height * 0.1,
                                height: height * 0.1,)
                            ],
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                    color: ColorUtils.appColorAccent,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  textView(StringUtils.txtPersonalSustainabilityScore,
                                      textColor: ColorUtils.appColorWhite,
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
                                    color: ColorUtils.appColorAccent,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  textView(StringUtils.txtMonitorMoneySavedFromReuse,
                                      textColor: ColorUtils.appColorWhite,
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
                                    color: ColorUtils.appColorAccent,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  textView(StringUtils.txtMonitorPersonalCarbonOffset,
                                      textColor: ColorUtils.appColorWhite,
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
                                    color: ColorUtils.appColorAccent,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  textView(StringUtils.txtMonitorPositiveEnvironment,
                                      textColor: ColorUtils.appColorWhite,
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
                                    color: ColorUtils.appColorAccent,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  textView(StringUtils.txtExclusiveOffersAndDiscounts,
                                      textColor: ColorUtils.appColorWhite,
                                      fontSize: SizeUtils.textSizeSMedium,
                                      fontWeight: FontWeight.w400,
                                      maxLine: 2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    height: height * 0.3,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RoundButton(
                            isStroked: false,
                            backgroundColor: ColorUtils.appColorWhite,
                            textColor: ColorUtils.appColorTextTitle,
                            textContent: StringUtils.txtYouAlreadySubscribed,
                            textSize: SizeUtils.textSizeMedium,
                            radius: 30,
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                          alignment: Alignment.center,
                          child: textView(StringUtils.txtFor14Days,
                              textColor: ColorUtils.appColorBlue,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.w500,
                              isCentered: true,
                              maxLine: 2),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                          alignment: Alignment.center,
                          child: textView(StringUtils.txtNoNeedToPay,
                              textColor: ColorUtils.appColorBlue,
                              fontSize: SizeUtils.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              isCentered: true,
                              maxLine: 2),
                        ),
                      
                      ],
                    ),
                  )
                  
                )
                
              ],
            )
            
          )
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
