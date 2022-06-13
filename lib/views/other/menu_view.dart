import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/plan_name_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/menu_view_model.dart';
import 'package:zimbo/views/auth/guide_view.dart';
import 'package:zimbo/views/items/item_menu_view.dart';
import 'package:zimbo/views/main/about_us_view.dart';
import 'package:zimbo/views/other/subscription/cancel_subscription_view.dart';
import 'package:zimbo/views/other/subscription/subscription_lock_view.dart';
import 'package:zimbo/views/other/support_view.dart';
import 'package:zimbo/views/other/profile_view.dart';

import '../../model/common/subscription_status_model.dart';
import 'subscription/subscription_confirm_view.dart';

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
          backgroundColor: ColorUtils.appColorBlue,
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
                    imageStr: ImageUtils.imgIcBottomHelp,
                    titleStr: StringUtils.txtThisIsZimbo,
                    onTap: () {
                          const AboutUsView().launch(context);
                        }),
                MenuViewItem(
                    imageStr: ImageUtils.imgIcAboutUs,
                    titleStr: StringUtils.txtHowDoesZimboWork,
                    onTap: () async {
                          const GuideView().launch(context);
                        }),
                MenuViewItem(
                    imageStr: ImageUtils.imgIcMenuProfile,
                    titleStr: StringUtils.txtMyDetails,
                    onTap: () => {
                          ProfileView().launch(context),
                        }),
                MenuViewItem(
                    imageStr: ImageUtils.imgIcMyItems,
                    titleStr: StringUtils.txtSubscription,
                    onTap: () => {
                        if(model.userModel!.subscriptionInfo == null ||
                            model.userModel!.subscriptionInfo!.planName == PlanNameModel.free ||
                             model.userModel!.subscriptionInfo!.status != SubscriptionStatusModel.active){
                               const SubscriptionLockView().launch(context),
                             } else {
                              SubscriptionConfirmView().launch(context),
                              //const CancelSubscriptionView().launch(context),
                             }
                        }),
                MenuViewItem(
                    imageStr: ImageUtils.imgIcMenuSupport,
                    titleStr: StringUtils.txtSupport,
                    onTap: () => {
                      SupportView().launch(context),
                    }),
                Expanded(child: Container()),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(ImageUtils.imgIcMenuLogout,
                            color: ColorUtils.appColorWhite),
                        const SizedBox(width: 20),
                        Expanded(
                          child: textView(StringUtils.txtLogout,
                              textColor: ColorUtils.appColorWhite,
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
                      textView(StringUtils.txtAppName, textColor: ColorUtils.appColorWhite, fontSize: SizeUtils.textSizeSMedium, fontWeight: FontWeight.w600, isCentered: false),
                      textView(StringUtils.txtAppVersion + " " + model.version, textColor: ColorUtils.appColorWhite, fontSize: SizeUtils.textSizeSmall, fontWeight: FontWeight.w300, isCentered: false),
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
