import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/auth/guide_view_model.dart';
import 'package:zimbo/views/items/item_guide_view.dart';
import 'package:zimbo/views/main/main_view.dart';

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
    setStatusBarColor(ColorUtils.appColorWhite);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorBlue,
          appBar: AppBar(
              title: textView(StringUtils.txtSimplifyingSustainability,
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
                  MainView().launch(context, isNewTask: true);
                },
              ),
            ),
          body: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: model.mList.map((item) {
                        return ItemGuideView(
                          model: item,
                        );
                      }).toList(),
                    )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(
                          10, 30, 10, 10),
                      child: RoundButton(
                          isStroked: false,
                          backgroundColor: ColorUtils.appColorWhite,
                          textColor: ColorUtils.appColorAccent,
                          textContent: StringUtils.txtContinue,
                          textSize: SizeUtils.textSizeMedium,
                          radius: 30,
                          onPressed: () {
                            model.onClickContinue(context);
                          }),
                    ),)
               
              ],
            ),
          ),
        onWillPop: () {
          MainView().launch(context, isNewTask: true);
          return Future.value(false);
        });
  }
}
