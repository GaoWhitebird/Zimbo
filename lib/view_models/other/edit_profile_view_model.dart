
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/model/request/update_profile_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class EditProfileViewModel extends BaseViewModel {

  String? token;
  UserModel? userModel;
  String imagePath = '';

  String userImage = '';
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  String userCountry = '';
  String userAddress = '';

  initialize(BuildContext context, TextEditingController textEditingControllerName, 
  TextEditingController textEditingControllerPhone, 
  TextEditingController textEditingControllerEmail, 
  TextEditingController textEditingControllerCountry, 
  TextEditingController textEditingControllerAddress) async {
    token = await sharedService.getToken();
    networkService.doGetProfile(token!).then((value) => {
      if(value != null){
        userModel = value,

        userImage = userModel!.userImage!,
        userName = userModel!.userName!,
        userPhone = userModel!.userPhone!,
        userEmail = userModel!.userEmail!,
        userCountry = userModel!.country!,
        userAddress = userModel!.address!,

        textEditingControllerName.text = userName,
        textEditingControllerPhone.text = userPhone,
        textEditingControllerEmail.text = userEmail,
        textEditingControllerCountry.text = userCountry,
        textEditingControllerAddress.text = userAddress,

        notifyListeners(),
      }
    });
  }

  onClickAddPhoto(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      imagePath = image.path;
    }

    notifyListeners();
  }

  onClickSave(BuildContext context, String textName, String textPhone, String textEmail, String textCountry, String textAddress) async {
    if(checkValidate(textName, textEmail,)){
       String timeStr = new DateTime.now().microsecond.toString();
      UpdateProfileReq req = new UpdateProfileReq(userName: textName, userPhone: textPhone, country: textCountry, address: textAddress,
      userImage: imagePath.isNotEmpty ? await MultipartFile.fromFile(imagePath, filename: 'upload_' + timeStr + '.jpg') : null);

      networkService.doUpdateProfile(token!, req).then((value) => {
        if(value != null){
          sharedService.saveUser(value),
          showMessage(StringUtils.txtProfileUpdatedSuccess, null),
          imagePath = '',
          
          finishView(context, true),
        }
      });
    }
  }

  bool checkValidate(String name, String email){
    if(name.isEmpty){
      showMessage(StringUtils.txtPleaseEnterName, null);
      return false;
    }
    if(email.isEmpty){
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return false;
    }
    return true;
  }
}