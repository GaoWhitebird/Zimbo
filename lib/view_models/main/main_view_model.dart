import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/other/add_score_view.dart';
import 'package:zimbo/views/other/menu_view.dart';
import 'package:zimbo/views/other/qr_scanner_view.dart';

class MainViewModel extends BaseViewModel {
  int selectedIndex = 2;
  bool initialUriIsHandled = false;

  initialize(BuildContext context, int? selectedVal) async {
    if(selectedVal != null){
      selectedIndex = selectedVal;
    }
    
    handleIncomingLinks(context);
    handleInitialUri(context);
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request().then((value) => {
        
      });
    }
  }

  onClickMenu(BuildContext context) async {
    final result = await const MenuView().launch(context);
    if (result != null) selectedIndex = result;
    notifyListeners();
  }

  onClickBarcode(BuildContext context) async {
    const QrScannerView().launch(context);
  }

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void handleIncomingLinks(BuildContext context) {
    uriLinkStream.listen((Uri? uri) async {
      if(uri != null) {
        if(!initialUriIsHandled){
          initialUriIsHandled = true;
          setSelectedIndex(2);
          const AddScoreView().launch(context);
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
          setSelectedIndex(2);
          const AddScoreView().launch(context);
        }
      }
        
    } on PlatformException {
    } on FormatException {
    }
  }
}
