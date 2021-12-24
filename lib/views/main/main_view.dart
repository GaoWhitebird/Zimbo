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
import 'package:zimbo/views/main/eco_hub_view.dart';
import 'package:zimbo/views/main/home_view.dart';
import 'package:zimbo/views/main/my_items_view.dart';
import 'package:zimbo/views/main/support_view.dart';

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
  StringUtils.txtAboutUS,
  StringUtils.txtMyItems,
  StringUtils.txtAppName,
  StringUtils.txtEcoHub,
  StringUtils.txtSupport,
];

List<SvgPicture> navIcons = [
  SvgPicture.asset(ImageUtils.imgIcAboutUs),
  SvgPicture.asset(ImageUtils.imgIcMyItems),
  SvgPicture.asset(ImageUtils.imgIcHome),
  SvgPicture.asset(ImageUtils.imgIcEcoHub),
  SvgPicture.asset(ImageUtils.imgIcSupport),
];

List<SvgPicture> navIconsActive = [
  SvgPicture.asset(
    ImageUtils.imgIcAboutUs,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcMyItems,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcHome,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcEcoHub,
    color: ColorUtils.appColorAccent,
  ),
  SvgPicture.asset(
    ImageUtils.imgIcSupport,
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
    child: EcoHubView(),
  ),
  const SizedBox(
    child: SupportView(),
  ),
];

buildWidget(BuildContext context, MainViewModel model, Widget? child) {
  return WillPopScope(
      child: Scaffold(
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
        body: navWidgets[model.selectedIndex],
        bottomNavigationBar: Material(
            elevation: 1.0,
            color: ColorUtils.appColorWhite,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Container(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: navIcons.map((icon) {
                  int index = navIcons.indexOf(icon);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 25,
                          icon: model.selectedIndex == index
                              ? navIconsActive[index]
                              : navIcons[index],
                          onPressed: () {
                            model.setSelectedIndex(index);
                          },
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: ShapeDecoration(
                              color: model.selectedIndex == index
                                  ? ColorUtils.appColorAccent
                                  : ColorUtils.appColorTransparent,
                              shape: const CircleBorder()),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            )),
      ),
      onWillPop: () {
        // showDialog(
        //         context: context,
        //         builder: (BuildContext context) => const ExitDialog(),
        //       );
        finishView(context);
        return Future.value(false);
      });
}
