
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/guide_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

import '../../views/other/subscription/subscription_confirm_view.dart';

class GuideViewModel extends BaseViewModel {

  List<GuideModel> mList = [];
  initialize(BuildContext context) async {
    mList.add(GuideModel(id: '1', title: StringUtils.txtGuideTitle_1, description: StringUtils.txtGuideDescription_1, backgroundColor: ColorUtils.appColorBlue, imageStr: ImageUtils.imgIcGuide1));
    mList.add(GuideModel(id: '2', title: StringUtils.txtGuideTitle_2, description: StringUtils.txtGuideDescription_2, backgroundColor: ColorUtils.appColorGreen, imageStr: ImageUtils.imgIcGuide2));
    mList.add(GuideModel(id: '3', title: StringUtils.txtGuideTitle_3, description: StringUtils.txtGuideDescription_3, backgroundColor: ColorUtils.appColorBlueLight, imageStr: ImageUtils.imgIcGuide3));
    mList.add(GuideModel(id: '4', title: StringUtils.txtGuideTitle_4, description: StringUtils.txtGuideDescription_4, backgroundColor: ColorUtils.appColorBlue, imageStr: ImageUtils.imgIcGuide4));
    mList.add(GuideModel(id: '5', title: StringUtils.txtGuideTitle_5, description: StringUtils.txtGuideDescription_5, backgroundColor: ColorUtils.appColorGreen, imageStr: ImageUtils.imgIcGuide5));
  }

  onClickGotIt(BuildContext context) {
    //const MainView().launch(context, isNewTask: true);
    finishView(context);
  }

  onClickContinue(BuildContext context) {
    SubscriptionConfirmView().launch(context);
  }

}