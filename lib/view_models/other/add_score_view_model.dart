import 'package:flutter/material.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/common/score_model.dart';
import 'package:zimbo/model/request/add_score_req.dart';
import 'package:zimbo/model/request/get_merchant_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class AddScoreViewModel extends BaseViewModel {
  List<RecyclableItemModel> mList = [];
  String? token;
  String? mQrID;

  initialize(BuildContext context, String? qrId) async {
    token = await sharedService.getToken();
    mQrID = qrId;
    if (qrId == null || qrId.isEmpty) {
      mQrID = '';
      await networkService.doGetUserRecyclableList(token!).then((value) => {
            if (value != null)
              {
                mList = value[0],
                for (int i = 0; i < mList.length; i++)
                  {
                    mList[i].isChecked = mList[i].isMultiple,
                    mList[i].selectedIndex = -1,
                  },
                notifyListeners(),
              }
          });
    } else {
      await networkService
          .doGetMerchantRecyclableList(token!, GetMerchantReq(merchantId: qrId))
          .then((value) => {
                if (value != null)
                  {
                    mList = value,
                    for (int i = 0; i < mList.length; i++)
                      {
                        mList[i].isChecked = mList[i].isMultiple,
                        mList[i].selectedIndex = -1,
                      },
                    notifyListeners(),
                  }
              });
    }
  }

  onClickAddScore(BuildContext context) async {}

  void onAddRemoveClicked(BuildContext context, RecyclableItemModel item) {}

  onClickSubmit(BuildContext context) {
    int count = 0;
    List<dynamic> list = [];
    for (int i = 0; i < mList.length; i++) {
      if (mList[i].isChecked == '1') {
        ScoreModel req;

        if((mList[i].isMultiple == '1' && mList[i].count != '0')){
          count ++;
          req = ScoreModel(
            id: mList[i].id,
            count: mList[i].count,
            hasSub: '0',
          );
          list.add(req.toJson());
        }else if(mList[i].hasSub == '1' && mList[i].selectedIndex != -1){
          count ++;
          RecyclableItemModel item =  RecyclableItemModel.fromJson(mList[i].subList[mList[i].selectedIndex!]);
          req = ScoreModel(
            id: item.id,
            count: mList[i].count,
            hasSub: '1',
          );
          list.add(req.toJson());
        }else if(mList[i].hasSub == '0' && mList[i].isMultiple == '0'){
          count ++;
          req = ScoreModel(
            id: mList[i].id,
            count: mList[i].count,
            hasSub: '0',
          );
          list.add(req.toJson());
        }
      }
    }

    bool isMerchant = false;
    if (mQrID == null || mQrID!.isEmpty) {
      isMerchant = false;
    } else {
      isMerchant = true;
    }

    if (count == 0) {
      showMessage(StringUtils.txtPleaseSelectItem, null);
      return;
    }

    networkService
        .doAddScore(
            token!, AddScoreReq(recyclableIds: list, merchant: isMerchant, merchantId: mQrID ?? ''))
        .then((value) => {
              if (value != null)
                {
                  sharedService.saveUser(value),
                  showMessage(StringUtils.txtScoreAddedSuccess, null),
                  finishView(context)
                }
              else
                {
                  showMessage(StringUtils.txtScoreAddedFail, null),
                }
            });
  }
}
