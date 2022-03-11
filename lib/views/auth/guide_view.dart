import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/guide_view_model.dart';

class GuideView extends StatelessWidget {
  const GuideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GuideViewModel>.reactive(
      viewModelBuilder: () => GuideViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, GuideViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorBlue);
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Image.asset(ImageUtils.imgIcLogo,
                width: width * 0.15, fit: BoxFit.scaleDown),
            backgroundColor: ColorUtils.appColorBlue,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
              color: ColorUtils.appColorBlue,
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
                        child: textView(StringUtils.txtYourGuide,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeNormal,
                            fontWeight: FontWeight.w600,
                            isCentered: true,
                            maxLine: 2),
                      ),
                      Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: ExactAssetImage(
                                          ImageUtils.imgIcGuideBack),
                                      fit: BoxFit.fitHeight)))),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: RoundButton(
                            isStroked: false,
                            textContent: StringUtils.txtGotIt,
                            textSize: SizeUtils.textSizeMedium,
                            radius: 30,
                            onPressed: () => model.onClickGotIt(context)),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        onWillPop: () {
          return Future.value(false);
        });
  }
}
