import 'package:flutter/material.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

// ignore: must_be_immutable
class PhotoSelectDlg extends StatefulWidget {
  PhotoSelectDlg(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.buttonText1,
      required this.buttonText2,
      this.onButtonClicked1,
      this.onButtonClicked2})
      : super(key: key);
  final String title, descriptions, buttonText1, buttonText2;
  Function? onButtonClicked1;
  Function? onButtonClicked2;

  @override
  State<PhotoSelectDlg> createState() => _PhotoSelectDlgState();
}

class _PhotoSelectDlgState extends State<PhotoSelectDlg> {
  
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: ColorUtils.appColorTransparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: ColorUtils.appColorWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: ColorUtils.appColorBlack_50,
                    offset: Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              textView(widget.title,
                  textColor: ColorUtils.appColorTextDark,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w600,
                  isCentered: true,
                  maxLine: 4),
              const SizedBox(height: 15,),
              textView(widget.descriptions,
                  textColor: ColorUtils.appColorTextLight,
                  fontSize: SizeUtils.textSizeSMedium,
                  fontWeight: FontWeight.w400,
                  isCentered: true,
                  maxLine: 5),
              const SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundButton(
                    isStroked: false,
                    textContent: widget.buttonText1,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 5,
                    onPressed: () {
                      finishView(context);
                      if(widget.onButtonClicked1 != null){
                        widget.onButtonClicked1!();
                      }
                    }),
                    const SizedBox(height: 10,),
                  RoundButton(
                    isStroked: false,
                    textContent: widget.buttonText2,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 5,
                    onPressed: () {
                      finishView(context);
                      if(widget.onButtonClicked2 != null){
                        widget.onButtonClicked2!();
                      }
                    }),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
