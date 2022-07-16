import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';
import 'package:zimbo/view_models/other/qr_scanner_view_model.dart';
import 'package:zimbo/views/other/add_score_view.dart';


class QrScannerView extends StatefulWidget {
  const QrScannerView({Key? key}) : super(key: key);
 
  @override
  _QrScannerViewState createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  Barcode? result;
  MobileScannerController controller = MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

Widget _buildQrView(BuildContext context) {

    return MobileScanner(
            allowDuplicates: false,
            controller: controller,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                result = barcode;
                final String code = barcode.rawValue!;
                if(code.toLowerCase().contains(StringUtils.txtAppName)) {
                  
                  String urlStr = code;
                  String qrId = '';
                  if(urlStr.contains("merchant")){
                    qrId = urlStr.split("code=")[1];
                  }
                  
                  controller.stop();
                  finishView(context);
                  AddScoreView(qrId: qrId,).launch(context);
                }
              }
            });
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
              icon: ValueListenableBuilder(
                valueListenable: controller.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: ColorUtils.appColorWhite);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: ColorUtils.appColorWhite);
                  }
                },
              ),
              onPressed: () {
                controller.toggleTorch();
              },
            ),
            IconButton(
              splashRadius: 25,
              icon: ValueListenableBuilder(
                valueListenable: controller.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.cameraswitch_outlined);
                    case CameraFacing.back:
                      return const Icon(Icons.cameraswitch_outlined);
                  }
                },
              ),
              onPressed: () {
                controller.switchCamera();
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
            child: result == null ? Container() : textView(result!.rawValue, textColor: ColorUtils.appColorWhite, fontSize: SizeUtils.textSizeSMedium),
          )
        ],
      ),
    );
  }
}