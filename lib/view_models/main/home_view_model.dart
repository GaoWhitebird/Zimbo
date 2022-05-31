
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/dash_model.dart';
import 'package:zimbo/model/common/profile_insight_model.dart';
import 'package:zimbo/model/common/profile_level_model.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/home_detail_view.dart';
import 'package:zimbo/views/other/edit_profile_view.dart';
import 'package:zimbo/views/other/how_work_view.dart';

class HomeViewModel extends BaseViewModel {
  DashModel? dashModel;
  UserModel? userModel;
  ProfileInsightModel? insightModel;
  String? token;
  bool isLevelAvailable = false;
  List<ProfileLevelModel> mLevelList = [];
  List<String> mLevelStrList = [];
  int selectedIndex = 0;
  int curInsightIndex = 1;
  String curInsightValue = '0';

  initialize(BuildContext context) async {
    userModel = await sharedService.getUser();
    token = await sharedService.getToken();

    await networkService.doGetDashboardData(token!).then((value) => {
      dashModel = value,
      if(dashModel != null){
        userModel = dashModel!.userModel,
        sharedService.saveUser(userModel),
        isLevelAvailable = dashModel!.available == '1',
        insightModel = dashModel!.insightModel,
        mLevelList = dashModel!.levelList!,
        
        mLevelStrList.clear(),
        for(int i = 0; i < mLevelList.length; i++){
          mLevelStrList.add(mLevelList[i].labelName),

          if(mLevelList[i].current == '1'){
            selectedIndex = i,
          }
        },

        curInsightIndex = 1,
        curInsightValue = insightModel!.savings,

        notifyListeners(),
      }
    });

  }

  onClickScore(BuildContext context) {
    const HowWorkView().launch(context);
  }

  
  onClickAddPhoto(BuildContext context) {
    EditProfileView().launch(context);
  }

  onInsightClicked(int index) {
    if(insightModel == null) return;

    curInsightIndex = index;
    switch (curInsightIndex) {
      case 0:
        curInsightValue = insightModel!.carbonOffset;
        break;
      case 1:
        curInsightValue = insightModel!.savings;
        break;
      case 2:
        curInsightValue = insightModel!.reuse;
        break;
      case 3:
        curInsightValue = insightModel!.tree;
        break;
      default:
        curInsightValue = insightModel!.savings;
        break;
    }

    notifyListeners();
  }

  onInsightSubClicked(BuildContext context) {
    String type = '';
    switch (curInsightIndex) {
      case 0:
        type = 'carbon_offset';
        break;
      case 1:
        type = 'savings';
        break;
      case 2:
        type = 'reuse';
        break;
      case 3:
        type = 'tree';
        break;
    }
    if(type.isNotEmpty){
      HomeDetailView(type: type,).launch(context);
    }
  }


}