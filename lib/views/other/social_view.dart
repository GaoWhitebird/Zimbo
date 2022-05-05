import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/social_view_model.dart';

class SocialView extends StatelessWidget {
  const SocialView({ Key? key }) : super(key: key);

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
            appBar: AppBar(
              title: textView(StringUtils.txtSocial,
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
                  finishView(context, 2);
                },
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: width,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    textViewUnderline(StringUtils.txtSocial1,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeXLarge,
                      fontWeight: FontWeight.bold,
                      isCentered: true,),
                    Stack(
                      children: <Widget>[
                        Image.asset(ImageUtils.imgIcSocialBubble, width: width, height: width,),
                        Positioned(
                          bottom: 0,
                          left: width * 0.4,
                          right: 0,
                          child: Image.asset(ImageUtils.imgIcSocialHeader, width: width * 0.3, height: width * 0.3,),
                        ),
                        Container(
                          width: width,
                          height: width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(width * 0.1),
                          child: textView(StringUtils.txtSocial2,
                            textColor: ColorUtils.appColorBlue,
                            fontSize: SizeUtils.textSizeSSmall,
                            fontWeight: FontWeight.w600,
                            isCentered: true,
                            maxLine: 15),
                        )
                        
                      ],
                    ),  
                    textView(StringUtils.txtSocial3,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: true,
                            maxLine: 15),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(
                          10, 30, 10, 10),
                      child: RoundButton(
                          isStroked: false,
                          textContent: StringUtils.txtSubmissionForm,
                          textSize: SizeUtils.textSizeMedium,
                          radius: 30,
                          onPressed: () {
                            model.onClickSubmissionForm(context);
                          }),
                    ),
                    const SizedBox(height: 30,),
                    textViewUnderline(StringUtils.txtSocial4,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeXLarge,
                      fontWeight: FontWeight.bold,
                      isCentered: true,),
                    const SizedBox(height: 30,),
                    textView(StringUtils.txtSocial5,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: true,
                            maxLine: 15),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(
                          10, 30, 10, 10),
                      child: RoundButton(
                          isStroked: false,
                          textContent: StringUtils.txtShareApp,
                          textSize: SizeUtils.textSizeMedium,
                          radius: 30,
                          onPressed: () {
                            model.onClickShareApp(context);
                          }),
                    ),
                    Image.asset(ImageUtils.imgIcSocialHeader, width: width, height: width,),
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