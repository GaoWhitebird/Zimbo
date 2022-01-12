
import 'package:flutter/material.dart';
import 'package:zimbo/model/common/eco_hub_model.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class EcoHubViewModel extends BaseViewModel {

  List<EcoHubModel> mList = <EcoHubModel>[];

  initialize(BuildContext context) async {
    mList.add(EcoHubModel(id: 0, title: 'Eco ' + StringUtils.txtAboutTitle_1, description: StringUtils.txtAboutDescription_1, image: 'https://scontent.fvte5-1.fna.fbcdn.net/v/t1.18169-9/cp0/e15/q65/p160x160/1235007_710243798991436_1859655361_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=dd9801&_nc_ohc=9ctKWdBydDAAX_ayfvE&_nc_ht=scontent.fvte5-1.fna&oh=00_AT-XHZWfF2bq-_RNy1IdV12LRk7_IUsNX--Ro1ABEnUAXQ&oe=61EA3E7D'));
    mList.add(EcoHubModel(id: 1, title: 'Eco ' + StringUtils.txtAboutTitle_2, description: StringUtils.txtAboutDescription_2, image: 'https://scontent.fvte5-1.fna.fbcdn.net/v/t1.18169-9/cp0/e15/q65/p160x160/1235007_710243798991436_1859655361_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=dd9801&_nc_ohc=9ctKWdBydDAAX_ayfvE&_nc_ht=scontent.fvte5-1.fna&oh=00_AT-XHZWfF2bq-_RNy1IdV12LRk7_IUsNX--Ro1ABEnUAXQ&oe=61EA3E7D'));
    mList.add(EcoHubModel(id: 2, title: 'Eco ' + StringUtils.txtAboutTitle_3, description: StringUtils.txtAboutDescription_3, image: 'https://scontent.fvte5-1.fna.fbcdn.net/v/t1.18169-9/cp0/e15/q65/p160x160/1235007_710243798991436_1859655361_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=dd9801&_nc_ohc=9ctKWdBydDAAX_ayfvE&_nc_ht=scontent.fvte5-1.fna&oh=00_AT-XHZWfF2bq-_RNy1IdV12LRk7_IUsNX--Ro1ABEnUAXQ&oe=61EA3E7D'));
  }

}