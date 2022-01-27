
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {

  String? token;
  UserModel? userModel;
  String imagePath = '';
  String userPhonePrefix = '';
  String userPhone = '';
  String userEmail = '';
  String userAddress = '';

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
    networkService.doGetProfile(token!).then((value) => {
      if(value != null){
        userModel = value,
        imagePath = userModel!.userImage!,
        userPhonePrefix = userModel!.userPhonePrefix!,
        userPhone = userModel!.userPhone!,
        userEmail = userModel!.userEmail!,
        userAddress = userModel!.address!,

        notifyListeners(),
      }
    });
  }

  void onClickEdit(BuildContext context) {}

  onClickAddPhoto(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      imagePath = image.path;
    }

    notifyListeners();
  }

  onClickReset(BuildContext context) {}

  onClickDelete(BuildContext context) {}

}