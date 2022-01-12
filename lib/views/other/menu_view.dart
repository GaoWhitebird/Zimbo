import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/menu_view_model.dart';
import 'package:zimbo/views/items/item_menu_view.dart';
import 'package:zimbo/views/other/profile_view.dart';
import 'package:zimbo/views/other/subscription_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuViewModel>.reactive(
      viewModelBuilder: () => MenuViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, MenuViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorWhite);
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: textView(StringUtils.txtMenu,
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
                  Icons.close,
                  color: ColorUtils.appColorTextTitle,
                ),
                onPressed: () => finishView(context),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MenuViewItem(
                    imageStr: ImageUtils.imgIcMenuProfile,
                    titleStr: StringUtils.txtProfile,
                    onTap: () => {
                          finishView(context),
                          const ProfileView().launch(context),
                        }),
                MenuViewItem(
                    imageStr: ImageUtils.imgIcMyItems,
                    titleStr: StringUtils.txtSubscription,
                    onTap: () => {
                          finishView(context),
                          const SubscriptionView().launch(context),
                        }),
                MenuViewItem(
                    imageStr: ImageUtils.imgIcMenuSupport,
                    titleStr: StringUtils.txtSupport,
                    onTap: () => finishView(context, 4)),
                Expanded(child: Container()),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(ImageUtils.imgIcMenuLogout,
                            color: ColorUtils.appColorBlack),
                        const SizedBox(width: 20),
                        Expanded(
                          child: textView(StringUtils.txtLogout,
                              textColor: ColorUtils.appColorTextDark,
                              fontSize: SizeUtils.textSizeMedium),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => model.onClickLogout(context),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textView(StringUtils.txtAppName, textColor: ColorUtils.appColorTextLight, fontSize: SizeUtils.textSizeSMedium, fontWeight: FontWeight.w600, isCentered: false),
                      textView(StringUtils.txtAppVersion + " " + model.version, textColor: ColorUtils.appColorTextWhite, fontSize: SizeUtils.textSizeSmall, fontWeight: FontWeight.w400, isCentered: false),
                    ],
                  ),
                )
              ],
            )),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
