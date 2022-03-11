import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/add_score_view.dart';
import 'package:zimbo/views/other/barcode_scanner_view.dart';
import 'package:zimbo/views/other/menu_view.dart';

class MainViewModel extends BaseViewModel {
  int selectedIndex = 2;
  bool initialUriIsHandled = false;

  initialize(BuildContext context) async {
    handleIncomingLinks(context);
    handleInitialUri(context);
  }

  onClickMenu(BuildContext context) async {
    final result = await const MenuView().launch(context);
    if (result != null) selectedIndex = result;
    notifyListeners();
  }

  onClickBarcode(BuildContext context) {
    const BarcodeScannerScreen().launch(context);
  }

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void handleIncomingLinks(BuildContext context) {
    uriLinkStream.listen((Uri? uri) async {
      if(uri != null) {
        setSelectedIndex(1);
        final result = await const AddScoreView().launch(context);
        if (result != null){
          setSelectedIndex(result);
        }
      }
    }, onError: (Object err) {
    });
  }

  Future<void> handleInitialUri(BuildContext context) async {
    try {
      if(!initialUriIsHandled){
        initialUriIsHandled = true;
        final uri = await getInitialUri();
        if (uri == null) {
        } else { 
          setSelectedIndex(1);
          final result = await const AddScoreView().launch(context);
          if (result != null){
            setSelectedIndex(result);
          }
        }
      }
        
    } on PlatformException {
    } on FormatException {
    }
  }
}
