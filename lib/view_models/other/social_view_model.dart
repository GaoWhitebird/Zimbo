
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/submission_form_view.dart';

class SocialViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {

  }

  
  onClickSubmissionForm(BuildContext context) {
    SubmissionFormView().launch(context);
  }

  
  onClickShareApp(BuildContext context) async {
    if(Platform.isAndroid){
      Share.share(StringUtils.txtPleaseInstallThisApp + "https://play.google.com/store/apps/details?id=" + StringUtils.txtAndroidID);
    }else if(Platform.isIOS) {
      Share.share(StringUtils.txtPleaseInstallThisApp + "https://apps.apple.com/au/app/" + StringUtils.txtIOSID);
    }
  }

}