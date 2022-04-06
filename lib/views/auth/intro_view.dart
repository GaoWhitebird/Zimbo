import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/dots_indicator/dots_indicator.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/intro_view_model.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IntroViewModel>.reactive(
      viewModelBuilder: () => IntroViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }
}

buildWidget(BuildContext context, IntroViewModel model, Widget? child) {
  setStatusBarColor(ColorUtils.appColorTransparent);
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return WillPopScope(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(ImageUtils.imgIcSplash,
                width: width, height: height, fit: BoxFit.fill),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: model.pageController,
                children: <Widget>[
                  WalkThrough(
                    textTitle: StringUtils.txtIntroTitle_1,
                    textContent: StringUtils.txtIntroDescription_1,
                    walkImg: ImageUtils.imgIcLogo,
                    backImg: ImageUtils.imgIcIntroBack1,
                  ),
                  WalkThrough(
                      textTitle: StringUtils.txtIntroTitle_2,
                      textContent: StringUtils.txtIntroDescription_2,
                      walkImg: ImageUtils.imgIcLogo,
                      backImg: ImageUtils.imgIcIntroBack1),
                  WalkThrough(
                      textTitle: StringUtils.txtIntroTitle_3,
                      textContent: StringUtils.txtIntroDescription_3,
                      walkImg: ImageUtils.imgIcLogo,
                      backImg: ImageUtils.imgIcIntroBack1),
                ],
                onPageChanged: (value) {
                  model.setCurrentIndex(value);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.3,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DotsIndicator(
                        dotsCount: 3,
                        position: model.currentIndex,
                        decorator: const DotsDecorator(
                          color: ColorUtils.appColorWhite_20,
                          activeColor: ColorUtils.appColorWhite,
                          activeSize: Size.square(12.0),
                        )),
                    const Expanded(child: SizedBox()),
                    Container(
                        width: width,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * 0.9,
                          child: RoundButton(
                            isStroked: false,
                            textContent: model.buttonTextList[model.currentIndex],
                            textSize: SizeUtils.textSizeMedium,
                            onPressed: () => model.onClickNext(context),
                            textColor: ColorUtils.appColorWhite,
                            backgroundColor: ColorUtils.appColorBlue,
                            radius: 30,
                          ),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width * 0.3,
                          child: TextButton(
                            child: textView(StringUtils.txtSkip,
                                fontSize: SizeUtils.textSizeMedium,
                                textColor: ColorUtils.appColorWhite,
                                textAllCaps: true),
                            onPressed: () => model.onClickSkip(context),
                          ),
                        )).visible(false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: RoundButton(
                            isStroked: true,
                            textContent: StringUtils.txtBack,
                            textSize: SizeUtils.textSizeMedium,
                            onPressed: () => model.onClickPrev(),
                            textColor: ColorUtils.appColorBlack,
                            strokeColor: ColorUtils.appColorAccent,
                            backgroundColor: ColorUtils.appColorWhite,
                            radius: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: RoundButton(
                          isStroked: false,
                          textContent: StringUtils.txtNext,
                          textSize: SizeUtils.textSizeMedium,
                          onPressed: () => model.onClickNext(context),
                          textColor: ColorUtils.appColorWhite,
                          backgroundColor: ColorUtils.appColorAccent,
                          radius: 50,
                        )),
                      ],
                    ).visible(false),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () {
        if (model.currentIndex > 0) {
          model.onClickPrev();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext dlgContext) => const ExitDialog(),
          );
        }
        return Future.value(false);
      });
}
