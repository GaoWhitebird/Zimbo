
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/login_view.dart';
import 'package:zimbo/views/other/edit_profile_view.dart';

class ProfileViewModel extends BaseViewModel {

  String? token;
  UserModel? userModel;
  String imagePath = '';
  String userPhone = '';
  String userEmail = '';
  String userAddress = '';

  initialize(BuildContext context) async {
    token = await sharedService.getToken();

    networkService.doGetProfile(token!).then((value) => {
      if(value != null){
        userModel = value,
        imagePath = userModel!.userImage!,
        userPhone = userModel!.userPhone!,
        userEmail = userModel!.userEmail!,
        userAddress = userModel!.address!,

        notifyListeners(),
      }
    });
  }

  void onClickEdit(BuildContext context) async {
        final result = await EditProfileView().launch(context);

    if (result != null) {
      initialize(context);
    }
  }

  onClickAddPhoto(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      imagePath = image.path;
    }

    notifyListeners();
  }

  onClickReset(BuildContext context) async {
    await networkService.doResetScore(token!).then((value) => {
      if(value){
       showMessage(StringUtils.txtResetScoreSuccess, null),
       userModel!.userScore = '0',
       sharedService.saveUser(userModel),
      }
    });
  }

  onClickDelete(BuildContext context) async {
    
    await networkService.doDeleteProfile(token!).then((value) => {
      if(value){
        sharedService.saveToken(''),
        sharedService.saveUser(null),
        LoginView().launch(context, isNewTask: true),
      }
    });
  }

}