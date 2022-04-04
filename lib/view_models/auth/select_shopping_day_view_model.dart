import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/request/shopping_day_req.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/main/main_view.dart';

class SelectShoppingDayViewModel extends BaseViewModel {
  final weekDayValues = List.filled(7, false);
  final weekDayStringList = const [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ];

  var isChecked = false;
  String? token;
  var selectedGroup = -1;

  initialize(BuildContext context) async {
    token = await sharedService.getToken();
  }

  onClickSkip(BuildContext context) {
    MainView().launch(context, isNewTask: true);
  }

  void weekDayChanged(int day) {
    if(!isChecked){
      final index = day % 7;
      weekDayValues[index] = !weekDayValues[index];
      notifyListeners();
    }
  }

  onSetChecked(bool isCheck){
    isChecked = isCheck;

    if(isChecked){
      for(int i = 0; i < weekDayValues.length; i++){
        weekDayValues[i] = false;
      }
    }

    notifyListeners();
  }

  onGroupSelected(int index, bool isSelected) {
    selectedGroup = 0;
  }

  onClickApply(BuildContext context) async {
    ShoppingDayReq req;
    if(isChecked){
      if(selectedGroup > -1){
        req = ShoppingDayReq(specificDay: false, dayInfo: '$selectedGroup');
        await networkService.doSetShoppingDay(token!, req).then((value) => {
          if(value != null){
            onClickSkip(context),
          }
        });
      }else {
        onClickSkip(context);
      }
    }else {
      if(weekDayValues.where((element) => true).length > 0){
        String dayInfoStr = '';
        for(int i = 0; i < weekDayValues.length; i++){
          if(weekDayValues[i] == true){
            dayInfoStr = dayInfoStr + ',' + '$i';
          }
        }
        String _dayInfoStr = dayInfoStr.substring(1);

        req = ShoppingDayReq(specificDay: false, dayInfo: _dayInfoStr);
        await networkService.doSetShoppingDay(token!, req).then((value) => {
          if(value != null){
            onClickSkip(context),
          }
        });
      }else {
        onClickSkip(context);
      }
    }
  }

}