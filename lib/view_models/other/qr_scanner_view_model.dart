import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class QrScannerViewModel extends BaseViewModel {
  String? mBarcodeStr = '';
  initialize(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request().then((value) => {
        
      });
    }
  }

  onClickSave(BuildContext context, Map<String, int> detectionCount, String barcodeStr) async {
    if (barcodeStr.isNotEmpty) {
      int count = detectionCount.update(barcodeStr, (value) => value,
          ifAbsent: () => 0);

      showMessage(barcodeStr + " ------> " + count.toString(), 0.5);
      finishView(context);
    } else {
      showMessage(StringUtils.txtQRNotScanned, 0.5);
    }
  }
}