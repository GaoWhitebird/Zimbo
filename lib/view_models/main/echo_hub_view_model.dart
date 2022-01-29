
import 'package:flutter/material.dart';
import 'package:zimbo/model/common/eco_hub_model.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class EcoHubViewModel extends BaseViewModel {

  List<EcoHubModel> mList = <EcoHubModel>[];

  initialize(BuildContext context) async {
    mList.add(EcoHubModel(id: 0, title: 'Eco ' + StringUtils.txtEcoTitle_1, description: StringUtils.txtEcoDescription_1, image: 'https://scontent.fvte5-1.fna.fbcdn.net/v/t1.18169-9/c19.0.812.425a/s480x480/1235007_710243798991436_1859655361_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=dd9801&_nc_ohc=oU9edmxW-VQAX-Q0BbH&_nc_ht=scontent.fvte5-1.fna&oh=00_AT_KGEatyW_kpacKYCnV3b9Wju_VcpD2Dsp315Z4L8r-lA&oe=621571A4'));
    mList.add(EcoHubModel(id: 1, title: 'Eco ' + StringUtils.txtEcoTitle_2, description: StringUtils.txtEcoDescription_2, image: 'https://scontent.fvte5-1.fna.fbcdn.net/v/t1.18169-9/c19.0.812.425a/s480x480/1235007_710243798991436_1859655361_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=dd9801&_nc_ohc=oU9edmxW-VQAX-Q0BbH&_nc_ht=scontent.fvte5-1.fna&oh=00_AT_KGEatyW_kpacKYCnV3b9Wju_VcpD2Dsp315Z4L8r-lA&oe=621571A4'));
    mList.add(EcoHubModel(id: 2, title: 'Eco ' + StringUtils.txtEcoTitle_3, description: StringUtils.txtEcoDescription_3, image: 'https://scontent.fvte5-1.fna.fbcdn.net/v/t1.18169-9/c19.0.812.425a/s480x480/1235007_710243798991436_1859655361_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=dd9801&_nc_ohc=oU9edmxW-VQAX-Q0BbH&_nc_ht=scontent.fvte5-1.fna&oh=00_AT_KGEatyW_kpacKYCnV3b9Wju_VcpD2Dsp315Z4L8r-lA&oe=621571A4'));
  }

}