
import 'package:flutter/material.dart';
import 'package:zimbo/model/about_model.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class AboutUsViewModel extends BaseViewModel {

  List<AboutModel> mList = <AboutModel>[];

  initialize(BuildContext context) async {
    mList.add(AboutModel(id: 0, title: StringUtils.txtAboutTitle_1, description: StringUtils.txtAboutDescription_1));
    mList.add(AboutModel(id: 1, title: StringUtils.txtAboutTitle_2, description: StringUtils.txtAboutDescription_2));
    mList.add(AboutModel(id: 2, title: StringUtils.txtAboutTitle_3, description: StringUtils.txtAboutDescription_3));

    notifyListeners();
  }

}