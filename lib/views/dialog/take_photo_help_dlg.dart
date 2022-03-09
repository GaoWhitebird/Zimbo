import 'package:flutter/material.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:zimbo/utils/system_utils.dart';
import 'package:zimbo/utils/widget_utils.dart';

class TakePhotoHelpDlg extends StatefulWidget {
  TakePhotoHelpDlg(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.buttonText})
      : super(key: key);
  final String title, descriptions, buttonText;

  @override
  State<TakePhotoHelpDlg> createState() => _TakePhotoHelpDlgState();
}

class _TakePhotoHelpDlgState extends State<TakePhotoHelpDlg> {
  
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
              textView(StringUtils.txtWhyINeed,
                  textColor: ColorUtils.appColorTextDark,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w600,
                  isCentered: true,
                  maxLine: 2),
              const SizedBox(height: 15,),
              textView(StringUtils.txtWhyINeedDescription,
                  textColor: ColorUtils.appColorTextLight,
                  fontSize: SizeUtils.textSizeSMedium,
                  fontWeight: FontWeight.w400,
                  isCentered: true,
                  maxLine: 3),
              const SizedBox(height: 15,),
              RoundButton(
                    isStroked: false,
                    textContent: StringUtils.txtGotIt,
                    textSize: SizeUtils.textSizeMedium,
                    radius: 30,
                    onPressed: (){
                      finishView(context);
                    }),
            ],
          ),
        )
      ],
    );
  }
}
