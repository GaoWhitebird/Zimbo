import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/about_us_view_model.dart';
import 'package:zimbo/views/items/item_about_us_new.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutUsViewModel>.reactive(
      viewModelBuilder: () => AboutUsViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, AboutUsViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorUtils.appColorBlue,
      appBar: AppBar(
              title: textView(StringUtils.txtThisIsZimbo,
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
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AboutUsNewItem(blgImage: ImageUtils.imgIcAboutUS1, blgTitle: StringUtils.txtAboutTitle_1, blgDescription: StringUtils.txtAboutDescription_1, blgWidth: width * 0.95,),
                      AboutUsNewItem(blgImage: ImageUtils.imgIcAboutUS2, blgTitle: StringUtils.txtAboutTitle_2, blgDescription: StringUtils.txtAboutDescription_2, blgWidth: width * 0.95,),
                      AboutUsNewItem(blgImage: ImageUtils.imgIcAboutUS3, blgTitle: StringUtils.txtAboutTitle_3, blgDescription: StringUtils.txtAboutDescription_3, blgWidth: width * 0.95,),
                    ],
                  ),
                ),
        )
      )
    );
  }
}
