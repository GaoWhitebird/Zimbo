import 'package:zimbo/services/common_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimbo/services/network_service.dart';
import 'package:zimbo/services/shared_service.dart';
import '../locator.dart';

class BaseViewModel extends ChangeNotifier{
  bool _busy = false;
  bool get isBusy => _busy;

  CommonService commonService = locator<CommonService>();
  NetworkService networkService = locator<NetworkService>();
  SharedService sharedService = locator<SharedService>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}