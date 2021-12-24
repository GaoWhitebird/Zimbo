import 'package:flutter/material.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/barcode_scanner_view.dart';
import 'package:zimbo/views/other/menu_view.dart';

class MainViewModel extends BaseViewModel {

  int selectedIndex = 2;

  initialize(BuildContext context) async {

  }

  onClickMenu(BuildContext context) {
    const MenuView().launch(context);
  }

  onClickBarcode(BuildContext context) {
    const BarcodeScannerScreen().launch(context);
  }

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

}