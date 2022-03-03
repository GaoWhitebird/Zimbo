import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/main/main_view_model.dart';
import 'package:zimbo/views/main/about_us_view.dart';
import 'package:zimbo/views/main/community_view.dart';
import 'package:zimbo/views/main/home_view.dart';
import 'package:zimbo/views/main/my_items_view.dart';
import 'package:zimbo/views/main/sphere_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => MainViewModel(),
        builder: (context, model, child) => buildWidget(context, model, child),
        onModelReady: (model) => model.initialize(context));
  }
}

List<String> navTitles = [
  StringUtils.txtThisIsZimbo,
  StringUtils.txtPantry,
  StringUtils.txtDashboard,
  StringUtils.txtZimboSphere,
  StringUtils.txtCommunity,
];

List<SvgPicture> navIcons = [
  SvgPicture.asset(
    ImageUtils.imgIcBottomHelp,
    width: 24,
    height: 24,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomList,
    width: 24,
    height: 24,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomDashboard,
    width: 72,
    height: 72,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomChar,
    width: 24,
    height: 24,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomCommunity,
    width: 24,
    height: 24,
  ),
];

List<SvgPicture> navIconsActive = [
  SvgPicture.asset(
    ImageUtils.imgIcBottomHelp,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomList,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomDashboard,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomChar,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcBottomCommunity,
    color: ColorUtils.appColorAccent,
  ),
];

List<Widget> navWidgets = [
  const SizedBox(
    child: AboutUsView(),
  ),
  const SizedBox(
    child: MyItemsView(),
  ),
  const SizedBox(
    child: HomeView(),
  ),
  const SizedBox(
    child: SphereView(),
  ),
  const SizedBox(
    child: CommunityView(),
  ),
];

buildWidget(BuildContext context, MainViewModel model, Widget? child) {
  setStatusBarColor(ColorUtils.appColorWhite);
  return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorUtils.appColorBlue,
        appBar: AppBar(
          title: textView(navTitles[model.selectedIndex],
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
          leading: IconButton(
            splashRadius: 25,
            icon: const Icon(
              Icons.menu_rounded,
              color: ColorUtils.appColorTextTitle,
            ),
            onPressed: () {
              model.onClickMenu(context);
            },
          ),
          actions: [
            IconButton(
              splashRadius: 25,
              icon: const Icon(
                Icons.photo_camera_outlined,
                color: ColorUtils.appColorTextTitle,
              ),
              onPressed: () {
                model.onClickBarcode(context);
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(child: navWidgets[model.selectedIndex]),
                Material(
                    elevation: 1.0,
                    color: ColorUtils.appColorBlue,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: ColorUtils.appColorWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    splashRadius: 25,
                                    icon: navIcons[0],
                                    onPressed: () {
                                      model.setSelectedIndex(0);
                                    },
                                  ),
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: ShapeDecoration(
                                        color: model.selectedIndex == 0
                                            ? ColorUtils.appColorBlue
                                            : ColorUtils.appColorTransparent,
                                        shape: const CircleBorder()),
                                  )
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    splashRadius: 25,
                                    icon: navIcons[1],
                                    onPressed: () {
                                      model.setSelectedIndex(1);
                                    },
                                  ),
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: ShapeDecoration(
                                        color: model.selectedIndex == 1
                                            ? ColorUtils.appColorBlue
                                            : ColorUtils.appColorTransparent,
                                        shape: const CircleBorder()),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    splashRadius: 25,
                                    icon: navIcons[3],
                                    onPressed: () {
                                      model.setSelectedIndex(3);
                                    },
                                  ),
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: ShapeDecoration(
                                        color: model.selectedIndex == 3
                                            ? ColorUtils.appColorBlue
                                            : ColorUtils.appColorTransparent,
                                        shape: const CircleBorder()),
                                  )
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    splashRadius: 25,
                                    icon: navIcons[4],
                                    onPressed: () {
                                      model.setSelectedIndex(4);
                                    },
                                  ),
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: ShapeDecoration(
                                        color: model.selectedIndex == 4
                                            ? ColorUtils.appColorBlue
                                            : ColorUtils.appColorTransparent,
                                        shape: const CircleBorder()),
                                  )
                                ],
                              ),
                            ),
                          ]),
                    )),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 5,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: ColorUtils.appColorTransparent,
                        child: IconButton(
                          iconSize: 75,
                          onPressed: () => model.setSelectedIndex(2),
                          icon: Image.asset(ImageUtils.imgIcDashboard),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: ShapeDecoration(
                            color: model.selectedIndex == 2
                                ? ColorUtils.appColorBlue
                                : ColorUtils.appColorTransparent,
                            shape: const CircleBorder()),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      onWillPop: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => const ExitDialog(),
        );
        return Future.value(false);
      });
}
