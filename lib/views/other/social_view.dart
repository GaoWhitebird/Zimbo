import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/social_view_model.dart';

class SocialView extends StatelessWidget {
  const SocialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      viewModelBuilder: () => SocialViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SocialViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
            backgroundColor: ColorUtils.appColorBlue,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: width,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    textView(StringUtils.txtSocial1,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeNormal,
                        fontWeight: FontWeight.bold,
                        isCentered: false,
                        maxLine: 10),
                    SizedBox(
                      width: width,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                  ImageUtils.imgIcShareIdea,
                                  height: width * 0.3,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: textView(StringUtils.txtSocial2,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false,
                                    maxLine: 15),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: textView(StringUtils.txtSocial2_2,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false,
                                    maxLine: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: <Widget>[
                        Positioned(
                          child: SvgPicture.asset(
                            ImageUtils.imgIcShareBack,
                            width: width,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: textView(StringUtils.txtSocial3,
                                      textColor: ColorUtils.appColorBlue,
                                      fontSize: SizeUtils.textSizeSmall,
                                      fontWeight: FontWeight.w400,
                                      isCentered: true,
                                      maxLine: 15),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: RoundButton(
                                      isStroked: false,
                                      textContent:
                                          StringUtils.txtSubmissionForm,
                                      textSize: SizeUtils.textSizeMedium,
                                      radius: 30,
                                      onPressed: () {
                                        model.onClickSubmissionForm(context);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textView(StringUtils.txtSocial4,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeNormal,
                        fontWeight: FontWeight.bold,
                        isCentered: false,
                        maxLine: 10),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: width,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                  ImageUtils.imgIcReferNewFriend,
                                  height: width * 0.3,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: textView(StringUtils.txtSocial5,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false,
                                    maxLine: 15),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: textView(StringUtils.txtSocial6,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false,
                                    maxLine: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: RoundButton(
                          isStroked: false,
                          textContent: StringUtils.txtShareApp,
                          textSize: SizeUtils.textSizeMedium,
                          radius: 30,
                          onPressed: () {
                            model.onClickShareApp(context);
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: textView(StringUtils.txtSocial7,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          fontWeight: FontWeight.bold,
                          isCentered: false,
                          maxLine: 10),
                      ),
                    const SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: textView(StringUtils.txtSocial8,
                        textColor: ColorUtils.appColorAccent,
                        fontSize: SizeUtils.textSizeNormal,
                        fontWeight: FontWeight.bold,
                        isCentered: false,
                        maxLine: 10),
                    ),
                    SizedBox(
                      width: width,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              right: 0,
                              top: 20,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  ImageUtils.imgIcPlasticFree,
                                  height: width * 0.4,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: textView(StringUtils.txtSocial9,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false,
                                    maxLine: 15),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: textView(StringUtils.txtSocial10,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false,
                                    maxLine: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          const EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: RoundButton(
                          isStroked: false,
                          textContent:
                              StringUtils.txtSubmissionForm,
                          textSize: SizeUtils.textSizeMedium,
                          radius: 30,
                          onPressed: () {
                            model.onClickSubmissionForm(context);
                          }),
                    ),
                  ],
                ),
              ),
            )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
