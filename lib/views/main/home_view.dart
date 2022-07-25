import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, HomeViewModel model, Widget? child) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ColorUtils.appColorBlue,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(width * 0.05),
                width: width,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: height * 0.15,
                      height: height * 0.15,
                      alignment: Alignment.center,
                      child: Stack(children: <Widget>[
                        model.userModel != null &&
                                model.userModel!.userImage!.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: SizedBox.fromSize(
                                  child: Image.network(
                                    model.userModel!.userImage!,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                  size: Size.fromRadius(height * 0.1),
                                )),
                              )
                            : SizedBox(
                                child: ClipOval(
                                    child: SizedBox.fromSize(
                                  child: Container(
                                    color: ColorUtils.appColorWhite,
                                  ),
                                  size: Size.fromRadius(height * 0.1),
                                )),
                              ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.camera_alt_outlined,
                                color: ColorUtils.appColorTextLight,
                              ),
                            ],
                          ),
                        ).visible(model.userModel == null ||
                            model.userModel!.userImage!.isEmpty),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: DottedBorder(
                              color: ColorUtils.appColorTextWhite,
                              strokeWidth: 1,
                              borderType: BorderType.Circle,
                              radius: const Radius.circular(10),
                              child: GestureDetector(
                                onTap: () => model.onClickAddPhoto(context),
                              )),
                        ).visible(model.userModel == null ||
                            model.userModel!.userImage!.isEmpty),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () => model.onClickAddPhoto(context),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtils.appColorWhite,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorUtils.appColorBlack_10,
                                          blurRadius: 10,
                                          offset: Offset(0, 5)),
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: ColorUtils.appColorBlue,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            )).visible(model.userModel !=
                                null &&
                            model.userModel!.userImage!.isNotEmpty),
                      ]),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    SizedBox(
                      height: height * 0.15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          textView(
                            StringUtils.txtWelcomeBack,
                            textColor: ColorUtils.appColorWhite_50,
                            fontSize: SizeUtils.textSizeSmall,
                            fontWeight: FontWeight.w300,
                            isCentered: false,
                          ),
                          textView(
                            model.userModel != null
                                ? model.userModel!.userName
                                : '',
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeMedium,
                            fontWeight: FontWeight.w500,
                            isCentered: false,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                child: textView(
                  StringUtils.txtMySustainabilityScore,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w500,
                  isCentered: true,
                ),
                onTap: () {},
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.05, 0, width * 0.05, width * 0.05),
                  child: textView(
                    StringUtils.txtYourScoreBasedOn,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeSMedium,
                    fontWeight: FontWeight.w200,
                    isCentered: true,
                    maxLine: 10,
                  ),
                ).visible(!model.isLevelAvailable),
                Container(
                  width: width,
                  margin: EdgeInsets.fromLTRB(0, width * 0.05, 0, width * 0.05),
                  child: GroupButton(
                    options: GroupButtonOptions(
                        unselectedColor: ColorUtils.appColorWhite_50,
                        selectedColor: ColorUtils.appColorAccent,
                        buttonWidth: width * 0.17,
                        buttonHeight: width * 0.17,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        runSpacing: 0,
                        spacing: 5,
                        textAlign: TextAlign.center,
                        unselectedTextStyle: const TextStyle(
                          color: ColorUtils.appColorBlack_50,
                          fontSize: SizeUtils.textSizeSmall,
                        ),
                        selectedTextStyle: const TextStyle(
                            color: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeSmall)),
                    onSelected: (buttons, index, isSelected) {
                      model.onButtonSelected(index);
                    },
                    isRadio: true,
                    controller: model.groupButtonController,
                    buttons: model.mLevelStrList,
                  ),
                ).visible(model.isLevelAvailable),
              ],
            ),
            Container(
              margin: EdgeInsets.all(width * 0.05),
              height: height * 0.3,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: ColorUtils.appColorWhite,
                  boxShadow: [
                    BoxShadow(
                        color: ColorUtils.appColorBlack_10,
                        blurRadius: 10,
                        offset: Offset(0, 5)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: textView(StringUtils.txtPersonalInsights,
                        textColor: ColorUtils.appColorTextTitle,
                        fontSize: SizeUtils.textSizeNormal,
                        fontWeight: FontWeight.w500,
                        isCentered: true),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              model.onInsightClicked(0);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                textView(StringUtils.txtCarbonOffset,
                                    textColor: model.curInsightIndex == 0
                                        ? ColorUtils.appColorAccent
                                        : ColorUtils.appColorTextTitle,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w500,
                                    isCentered: true),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 3,
                                  width: width * 0.3,
                                  color: model.curInsightIndex == 0
                                      ? ColorUtils.appColorAccent
                                      : ColorUtils.appColorTransparent,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.onInsightClicked(1);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                textView(StringUtils.txtSavings,
                                    textColor: model.curInsightIndex == 1
                                        ? ColorUtils.appColorAccent
                                        : ColorUtils.appColorTextTitle,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w500,
                                    isCentered: true),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 3,
                                  width: width * 0.2,
                                  color: model.curInsightIndex == 1
                                      ? ColorUtils.appColorAccent
                                      : ColorUtils.appColorTransparent,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.onInsightClicked(2);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                textView(StringUtils.txtReuse,
                                    textColor: model.curInsightIndex == 2
                                        ? ColorUtils.appColorAccent
                                        : ColorUtils.appColorTextTitle,
                                    fontSize: SizeUtils.textSizeSMedium,
                                    fontWeight: FontWeight.w500,
                                    isCentered: true),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 3,
                                  width: width * 0.15,
                                  color: model.curInsightIndex == 2
                                      ? ColorUtils.appColorAccent
                                      : ColorUtils.appColorTransparent,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.onInsightClicked(3);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Image.asset(
                                  ImageUtils.imgIcTree,
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  color: model.curInsightIndex == 3
                                      ? ColorUtils.appColorAccent
                                      : ColorUtils.appColorTextTitle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 3,
                                  width: width * 0.1,
                                  color: model.curInsightIndex == 3
                                      ? ColorUtils.appColorAccent
                                      : ColorUtils.appColorTransparent,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: width,
                        height: 0.5,
                        color: ColorUtils.appColorBlack_10,
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorUtils.appColorAccent,
                          padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      onPressed: () {
                        model.onInsightSubClicked(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          textView(model.curInsightValue,
                              textColor: ColorUtils.appColorWhite,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.w500,
                              isCentered: true),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: ColorUtils.appColorWhite,
                            size: 24,
                          ),
                        ],
                      ))
                ],
              ),
            )
          ]),
        ));
  }

  @override
  bool get wantKeepAlive => false;
}
