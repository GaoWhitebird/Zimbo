import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimbo/model/common/recyclable_item_model.dart';
import 'package:zimbo/model/request/add_recyclable_req.dart';
import 'package:zimbo/model/request/recyclable_item_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/dialog/photo_select_dlg.dart';
import 'package:zimbo/views/dialog/take_photo_help_dlg.dart';

class PantryItemPhotoViewModel extends BaseViewModel {
  String? token;
  List<RecyclableItemModel> mList = [];
  List<RecyclableItemReq> mReqList = [];

  initialize(BuildContext context, List<RecyclableItemModel> list) async {
    token = await sharedService.getToken();

    mList.clear();
    mList.addAll(list);
    mReqList.clear();
    for (int i = 0; i < mList.length; i++) {
      RecyclableItemReq req = new RecyclableItemReq(id: mList[i].id);
      mReqList.add(req);
    }

    notifyListeners();
  }

  void onClickPhoto(BuildContext context, RecyclableItemModel item) async {
    showDialog(
        context: context,
        builder: (BuildContext dlgContext) => PhotoSelectDlg(
            title: StringUtils.txtPhoto,
            descriptions: StringUtils.txtYouCanSelectImage,
            buttonText1: StringUtils.txtGallery,
            buttonText2: StringUtils.txtCamera,
            onButtonClicked1: () {
              onSelectImageFromPicker(item);
            },
            onButtonClicked2: () {
              onSelectImageFromCamera(item);
            }));
  }

  onClickHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext dlgContext) {
          return TakePhotoHelpDlg(
              title: StringUtils.txtWhyINeed,
              descriptions: StringUtils.txtWhyINeedDescription,
              buttonText: StringUtils.txtGotIt);
        });
  }

  onClickLater(BuildContext context){
    finishView(context, true);
  }

  onClickNext(BuildContext context) async {
    List _list = [];
    for (int i = 0; i < mReqList.length; i++) {
      if(mReqList[i].image == null){
        showMessage(StringUtils.txtAddPantryItemImage, null);
        return;
      }

      _list.add(mReqList[i].toJson());
    }

    await networkService
        .doAddRecyclableItems(token!, AddRecyclableReq(list: _list))
        .then((value) => {
              if (value != null)
                {
                  showMessage(StringUtils.txtRecyclableItemsAdded, null),
                }else {
                  showMessage(StringUtils.txtRecyclableItemsAddedFail, null),
                },
              finishView(context, true),
            });
  }

  onSelectImageFromPicker(RecyclableItemModel item) async {
    String timeStr = new DateTime.now().microsecond.toString();
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      MultipartFile imageFile = await MultipartFile.fromFile(image.path, filename: 'upload_' + timeStr + '.jpg');
      for(int i = 0; i < mReqList.length; i++){
        if(item.id == mReqList[i].id){
          mReqList[i].image = imageFile;
          mList[i].userRecyclableImage = image.path;
          item.userRecyclableImage = image.path;
          notifyListeners();
          break;
        }
      }
    }
  }

  onSelectImageFromCamera(RecyclableItemModel item) async {
    String timeStr = new DateTime.now().microsecond.toString();
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if(image != null){
      MultipartFile imageFile = await MultipartFile.fromFile(image.path, filename: 'upload_' + timeStr + '.jpg');
      for(int i = 0; i < mReqList.length; i++){
        if(item.id == mReqList[i].id){
          mReqList[i].image = imageFile;
          mList[i].userRecyclableImage = image.path;
          item.userRecyclableImage = image.path;
          notifyListeners();
          break;
        }
      }
    }
  }
}
