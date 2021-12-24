import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/menu_view_model.dart';
import 'package:zimbo/views/items/item_menu_view.dart';
import 'package:zimbo/views/main/main_view.dart';
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
                onPressed: () {
                  finish(context);
                },
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget> [
                MenuViewItem(imageStr: ImageUtils.imgIcMenuProfile, titleStr: StringUtils.txtProfile, onTap:() => const ProfileView().launch(context)),
                MenuViewItem(imageStr: ImageUtils.imgIcMyItems, titleStr: StringUtils.txtSubscription, onTap:() => const SubscriptionView().launch(context)),
                MenuViewItem(imageStr: ImageUtils.imgIcMenuSupport, titleStr: StringUtils.txtSupport, onTap:() => const MainView().launch(context)),
              ],
            )
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
