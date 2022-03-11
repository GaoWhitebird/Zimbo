import 'dart:async';

import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/barcode_scanner_view_model.dart';
import 'package:zimbo/views/other/add_score_view.dart';

final codeStream = StreamController<Barcode>.broadcast();

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final _torchIconState = ValueNotifier(false);
  late StreamSubscription _streamToken;
  Map<String, int> detectionCount = {};
  final detectionInfo = ValueNotifier("");
  String barcodeStr = '';

  @override
  void initState() {
    super.initState();

    _streamToken = codeStream.stream.listen((event) {
      barcodeStr = event.value;
      final count = detectionCount.update(event.value, (value) => value + 1,
          ifAbsent: () => 1);
      detectionInfo.value = "${count}x\n${event.value}";

      if(barcodeStr.toLowerCase().contains(StringUtils.txtAppName)){
        finishView(context);
        const AddScoreView().launch(context);
      }
    });
  }

  @override
  void dispose() {
    _streamToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BarcodeScannerViewModel>.reactive(
      viewModelBuilder: () => BarcodeScannerViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, BarcodeScannerViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: textView(StringUtils.txtBarcodeScanner,
            textColor: ColorUtils.appColorWhite,
            fontSize: SizeUtils.textSizeNormal,
            fontWeight: FontWeight.w500,
            isCentered: true),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: ColorUtils.appColorWhite,
          onPressed: () => finishView(context),
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _torchIconState,
            builder: (context, state, _) => IconButton(
              splashRadius: 25,
              icon: state
                  ? const Icon(Icons.flash_on)
                  : const Icon(Icons.flash_off),
              onPressed: () async {
                await CameraController.instance.toggleTorch();
                _torchIconState.value =
                    CameraController.instance.state.torchState;
              },
            ),
          ),
        ],
      ),
      body: BarcodeCamera(
        types: const [
          BarcodeType.ean8,
          BarcodeType.ean13,
          BarcodeType.code128,
          BarcodeType.qr
        ],
        resolution: Resolution.hd720,
        framerate: Framerate.fps30,
        mode: DetectionMode.pauseVideo,
        position: CameraPosition.back,
        onScan: (code) => codeStream.add(code),
        children: [
          const MaterialPreviewOverlay(animateDetection: false),
          const BlurPreviewOverlay(),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    child: ValueListenableBuilder(
                      valueListenable: detectionInfo,
                      builder: (context, dynamic info, child) => textView(info,
                          isCentered: true,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeSmall,
                          maxLine: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: ElevatedButton(
                          child: textView(StringUtils.txtResume,
                              textColor: ColorUtils.appColorAccent,
                              fontSize: SizeUtils.textSizeSMedium),
                          style: ElevatedButton.styleFrom(
                              primary: ColorUtils.appColorWhite,
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                          onPressed: () =>
                              CameraController.instance.resumeDetector(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: ElevatedButton(
                          child: textView(StringUtils.txtSave,
                              textColor: ColorUtils.appColorWhite,
                              fontSize: SizeUtils.textSizeSMedium),
                          style: ElevatedButton.styleFrom(
                              primary: ColorUtils.appColorAccent,
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                          onPressed: () =>
                              model.onClickSave(context, detectionCount, barcodeStr),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
