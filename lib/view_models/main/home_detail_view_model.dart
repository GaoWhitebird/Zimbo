
import 'package:flutter/material.dart';
import 'package:zimbo/model/common/home_detail_model.dart';
import 'package:zimbo/model/common/summary_model.dart';
import 'package:zimbo/model/request/get_home_detail_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class HomeDetailViewModel extends BaseViewModel {

  HomeDetailModel? homeDetailModel;
  String title = StringUtils.txtAppName;
  String total = '';
  List<SummaryModel> mList = [];
  String? token;
  initialize(BuildContext context, String type) async {
    
    GetHomeDetailReq req = GetHomeDetailReq(type: type);
    token = await sharedService.getToken();

    networkService.doGetHomeDetail(token!, req).then((value) => {
      homeDetailModel = value,
      title = homeDetailModel!.title!,
      total = homeDetailModel!.total!,
      mList = homeDetailModel!.summaryList!,
      
      notifyListeners(),
    },);
  }

}