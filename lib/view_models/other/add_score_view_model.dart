
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/common/score_model.dart';
import 'package:zimbo/model/request/add_score_req.dart';
import 'package:zimbo/model/request/get_merchant_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class AddScoreViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = [];
  String? token;
  String? mQrID;

  initialize(BuildContext context, String? qrId) async {
    token = await sharedService.getToken();
    mQrID = qrId;
    if(qrId == null || qrId.isEmpty){
      await networkService.doGetUserRecyclableList(token!).then((value) => {
          if (value != null)
            {
              mList = value[0],
              for(int i = 0; i < mList.length; i++){
                mList[i].isChecked = mList[i].isMultiple,
              },

              notifyListeners(),
            }
        });
    }else {
      await networkService.doGetMerchantRecyclableList(token!, GetMerchantReq(merchantId: qrId)).then((value) => {
          if (value != null)
            {
              mList = value,
              for(int i = 0; i < mList.length; i++){
                mList[i].isChecked = mList[i].isMultiple,
              },

              notifyListeners(),
            }
        });
    }
    
  }

  onClickAddScore(BuildContext context) async {
    
  }

  void onAddRemoveClicked(BuildContext context, RecyclableItemModel item) {
    
  }

  onClickSubmit(BuildContext context) {
      List<dynamic> list = [];
      for (int i = 0; i < mList.length; i++){
        if(mList[i].isChecked == '1'){
          ScoreModel req = ScoreModel(id: mList[i].id, count: mList[i].count,);
          list.add(req.toJson());
        }
      }

      bool isMerchant = false;
      if(mQrID == null || mQrID!.isEmpty){
        isMerchant = false;
      }else {
        isMerchant = true;
      }

      networkService.doAddScore(token!, AddScoreReq(recyclableIds: list, merchant: isMerchant)).then((value) => {
        if(value != null) {
          sharedService.saveUser(value),
          showMessage(StringUtils.txtScoreAddedSuccess, null),
          Future.delayed(const Duration(milliseconds: 500), () {
            MainView(index: 2,).launch(context, isNewTask: false);
          }),
        }else {
          showMessage(StringUtils.txtScoreAddedFail, null),
        }
      });
    }
}