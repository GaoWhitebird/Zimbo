import 'package:flutter/material.dart';
import 'package:zimbo/model/common/about_model.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class HowWorkViewModel extends BaseViewModel {
  

  List<AboutModel> mList = <AboutModel>[];

  initialize(BuildContext context) async {
    mList.add(AboutModel(id: 0, title: StringUtils.txtHowTitle_1, description: StringUtils.txtHowDescription_1));
    mList.add(AboutModel(id: 1, title: StringUtils.txtHowTitle_2, description: StringUtils.txtHowDescription_2));
    mList.add(AboutModel(id: 2, title: StringUtils.txtHowTitle_3, description: StringUtils.txtHowDescription_3));
    mList.add(AboutModel(id: 3, title: StringUtils.txtHowTitle_4, description: StringUtils.txtHowDescription_4));

    notifyListeners();
  }


}