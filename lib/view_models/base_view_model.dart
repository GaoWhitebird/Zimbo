import 'package:zimbo/services/common_service.dart';
import 'package:flutter/cupertino.dart';
import '../locator.dart';

class BaseViewModel extends ChangeNotifier{
  bool _busy = false;
  bool get isBusy => _busy;

  CommonService commonService = locator<CommonService>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}