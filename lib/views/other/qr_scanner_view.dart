import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/qr_scanner_view_model.dart';
import 'package:zimbo/views/other/add_score_view.dart';

final codeStream = StreamController<Barcode>.broadcast();

class QrScannerView extends StatefulWidget {
  const QrScannerView({Key? key}) : super(key: key);

  @override
  _QrScannerViewState createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

Widget _buildQrView(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var scanArea = width * 0.7;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorUtils.appColorWhite,
          borderRadius: 5,
          borderLength: 30,
          borderWidth: 5,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
        if(result != null){
          var barcodeStr = result!.code;
          if(barcodeStr!.toLowerCase().contains(StringUtils.txtAppName)) {
            await controller.pauseCamera();
            finishView(context);
            const AddScoreView().launch(context);
          }
        }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrScannerViewModel>.reactive(
      viewModelBuilder: () => QrScannerViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, QrScannerViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: textView(StringUtils.txtQRScanner,
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
           IconButton(
              splashRadius: 25,
              icon: controller?.getFlashStatus() != null
                  ? const Icon(Icons.flash_on)
                  : const Icon(Icons.flash_off),
              onPressed: () async {
                await controller?.toggleFlash();
                              setState(() {});
              },
            ),
            IconButton(
              splashRadius: 25,
              icon: controller?.getCameraInfo() != null
                  ? const Icon(Icons.cameraswitch_outlined)
                  : const Icon(Icons.cameraswitch_outlined),
              onPressed: () async {
                await controller?.flipCamera();
                              setState(() {});
              },
            ),
        ],
      ),
      body:  Stack(
        children: <Widget>[
          Container(
            child: _buildQrView(context),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: result == null ? Container() : textView(result!.code, textColor: ColorUtils.appColorWhite, fontSize: SizeUtils.textSizeSMedium),
          )
        ],
      ),
    );
  }
}
