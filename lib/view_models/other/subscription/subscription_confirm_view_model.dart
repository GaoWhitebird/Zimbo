
import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/add_postal_address_req.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/subscription/keychain_confirm_view.dart';

class SubscriptionConfirmViewModel extends BaseViewModel {
  
  String? token;
  initialize(BuildContext context) async {
    token = await sharedService.getToken();
  }

  onClickSubmit(BuildContext context, String postalAddress) async {
    if(postalAddress.isEmpty){
      showMessage(StringUtils.txtPleaseEnterPostalAddress, null);
      return;
    }
    
    AddPostalAddressReq req = AddPostalAddressReq(postalAddress: postalAddress);
    networkService.doAddPostalAddress(token!, req).then((value) {
      if(value) {
        
        finishView(context);
        const KeychainConfirmView().launch(context);
      }else{
        showMessage(StringUtils.txtSomethingWentWrong, null);
      }
    });

  }

}