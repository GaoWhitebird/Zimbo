import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';

class BarcodeScannerViewModel extends BaseViewModel {
  initialize(BuildContext context) async {}

  onClickSave(BuildContext context, Map<String, int> detectionCount, String barcodeStr) async {
    if (barcodeStr.isNotEmpty) {
      int count = detectionCount.update(barcodeStr, (value) => value,
          ifAbsent: () => 0);

      BotToast.showText(
          text: barcodeStr + " ------> " + count.toString(),
          textStyle: const TextStyle(
              fontSize: SizeUtils.textSizeSMedium,
              color: ColorUtils.appColorWhite),
          borderRadius: const BorderRadius.all(Radius.circular(30),),
          contentColor: ColorUtils.appColorAccent_50,
          align: const Alignment(0, 0.5));

      finishView(context);
    } else {
      BotToast.showText(
          text: StringUtils.txtBarcodeNotScanned,
          textStyle: const TextStyle(
              fontSize: SizeUtils.textSizeSMedium,
              color: ColorUtils.appColorWhite),
          borderRadius: const BorderRadius.all(Radius.circular(30),),
          contentColor: ColorUtils.appColorAccent_50,
          align: const Alignment(0, 0.5));
    }
  }
}
