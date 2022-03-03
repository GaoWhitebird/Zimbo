
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/post_support_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class SupportViewModel extends BaseViewModel {
  
  String imagePath = '';
  String? token;

  initialize(BuildContext context) async {

    token = await sharedService.getToken();

  }

  onClickSend(BuildContext context, String content) async {
    if(content.isEmpty){
      showMessage(StringUtils.txtPleaseEnterDescription, null);
      return;
    }

    String timeStr = new DateTime.now().microsecond.toString();
    PostSupportReq req;
    if(imagePath.isNotEmpty){
       req = PostSupportReq(content: content, attachment: await MultipartFile.fromFile(imagePath, filename: 'upload_' + timeStr + '.jpg'));
    }else {
      req = PostSupportReq(content: content,);
    }
    
    await networkService.doPostSupport(token!, req).then((value) => {
      if(value){
        showMessage(StringUtils.txtSentSuccess, null),
        imagePath = '',

        const MainView().launch(context, isNewTask: true),
      }
    });
  }

  onClickAddImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      imagePath = image.path;
    }

    notifyListeners();
  }

}