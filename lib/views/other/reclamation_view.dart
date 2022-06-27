import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/reclamation_view_model.dart';

class ReclamationView extends StatelessWidget {
  const ReclamationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReclamationViewModel>.reactive(
      viewModelBuilder: () => ReclamationViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ReclamationViewModel model, Widget? child) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          width: width * 0.6,
                          child: textView(StringUtils.txtReclamationStr_0,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeNormal,
                            fontWeight: FontWeight.w600,
                            isCentered: false,
                            maxLine: 15),
                        ),
                          SvgPicture.asset(
                            ImageUtils.imgIcRefresh,
                            color: ColorUtils.appColorWhite,
                            width: width * 0.3,
                            height: width * 0.3,
                          ),
                      ],
                    ),
                    textView(StringUtils.txtReclamationStr_1,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeSMedium,
                      fontWeight: FontWeight.w400,
                      isCentered: false,
                      maxLine: 15),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(width * 0.1, width * 0.1, 0, 0),
                        width: width,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          textView(StringUtils.txtReclamationStr_2,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 2),
                          textView(StringUtils.txtReclamationStr_3,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 2),
                          textView(StringUtils.txtReclamationStr_4,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 2),
                          textView(StringUtils.txtReclamationStr_5,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 2),
                        ],
                      ),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(ImageUtils.imgIcReclamationIc1, width: width * 0.4, height: width * 0.4,),
                        Image.asset(ImageUtils.imgIcReclamationIc2, width: width * 0.4, height: width * 0.4,),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(ImageUtils.imgIcReclamationIc3, width: width * 0.4, height: width * 0.4,),
                        Image.asset(ImageUtils.imgIcReclamationIc4, width: width * 0.4, height: width * 0.4,),
                      ],
                    ),
                    textView(StringUtils.txtReclamationStr_6,
                      textColor: ColorUtils.appColorWhite,
                      fontSize: SizeUtils.textSizeSMedium,
                      fontWeight: FontWeight.w400,
                      isCentered: false,
                      maxLine: 15),
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: width,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          textView(StringUtils.txtReclamationStr_7,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 1),
                          const SizedBox(height: 10,),
                          textView(StringUtils.txtReclamationStr_8,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 1),
                          textView(StringUtils.txtReclamationStr_9,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 1),
                          textView(StringUtils.txtReclamationStr_10,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSMedium,
                            fontWeight: FontWeight.w400,
                            isCentered: false,
                            maxLine: 1),
                        ],
                      ),
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
