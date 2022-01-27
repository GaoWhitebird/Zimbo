import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/image_utils.dart';
import 'package:zimbo/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'string_utils.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(ImageUtils.imgIcLogo, height: 25, fit: BoxFit.fitHeight),
          Container(
            width: 20,
          ),
          Text(StringUtils.txtWarning,
              style: boldTextStyle(color: Colors.orange)),
        ],
      ),
      content: Text(StringUtils.txtDoYouWantToExit,
          style: primaryTextStyle(color: ColorUtils.appColorBlack)),
      actions: [
        TextButton(
          child: Text(StringUtils.txtCancel,
              style: secondaryTextStyle(color: ColorUtils.appColorBlack)),
          onPressed: () {
            finish(context);
          },
        ),
        TextButton(
          child: Text(StringUtils.txtExit,
              style: secondaryTextStyle(color: ColorUtils.appColorAccent)),
          onPressed: () {
            finish(context);
            exit(0);
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.okButtonStr,
    required this.cancelButtonStr,
    required this.okClicked,
  }) : super(key: key);

  String title;
  String description;
  String okButtonStr;
  String cancelButtonStr;
  Function okClicked;

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(ImageUtils.imgIcLogo, height: 25, fit: BoxFit.fitHeight),
          Container(
            width: 20,
          ),
          Text(title, style: boldTextStyle(color: Colors.orange)),
        ],
      ),
      content: Text(description,
          style: primaryTextStyle(color: ColorUtils.appColorBlack)),
      actions: [
        TextButton(
          child: Text(cancelButtonStr,
              style: secondaryTextStyle(color: ColorUtils.appColorBlack)),
          onPressed: () {
            finish(context);
          },
        ),
        TextButton(
          child: Text(okButtonStr,
              style: secondaryTextStyle(color: ColorUtils.appColorAccent)),
          onPressed: () {
            okClicked();
            finish(context);
          },
        ),
      ],
    );
  }
}

Widget textView(
  String? text, {
  var fontSize = SizeUtils.textSizeNormal,
  Color? textColor,
  var fontFamily,
  var fontWeight,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.1,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      fontStyle: fontFamily ?? FontStyle.normal,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: textColor ?? ColorUtils.appColorBlack,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget textViewUnderline(
  String? text, {
  var fontSize = SizeUtils.textSizeNormal,
  Color? textColor,
  var fontFamily,
  var fontWeight,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.1,
  bool textAllCaps = false,
  var isLongText = false,
  bool dash = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      fontStyle: fontFamily ?? FontStyle.normal,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: textColor ?? ColorUtils.appColorBlack,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: TextDecoration.underline,
      decorationStyle:
          dash ? TextDecorationStyle.dashed : TextDecorationStyle.solid,
    ),
  );
}

// ignore: must_be_immutable
class EditTextField extends StatefulWidget {
  EditTextField(
      {Key? key,
      required this.hintText,
      required this.isPassword,
      required this.isSecure,
      required this.mController,
      this.onTap,
      this.textInputType,
      this.inputFormatters,
      this.autoFocus,
      this.cursorColor,
      this.hintColor,
      this.borderColor,
      this.borderRadius,
      this.textColor,
      this.fontFamily,
      this.fontWeight,
      this.fontSize,
      this.isCentered,
      this.maxLine,
      this.latterSpacing,
      this.lineThrough})
      : super(key: key);
  String hintText;
  bool isPassword;
  bool isSecure;
  TextEditingController mController;

  Color? cursorColor;
  Color? hintColor;
  Color? borderColor;
  Color? backgroundColor;
  double? borderRadius;
  Color? textColor;
  FontStyle? fontFamily;
  FontWeight? fontWeight;
  double? fontSize;
  bool? isCentered;
  int? maxLine;
  double? latterSpacing;
  bool? lineThrough;
  bool? autoFocus;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;
  VoidCallback? onTap;

  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSecure) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: GoogleFonts.poppins(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeMedium,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor ?? ColorUtils.appColorBlack,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(25, 8, 4, 8),
                hintText: widget.hintText,
                labelText: widget.hintText,
                hintStyle: TextStyle(
                    color: widget.hintColor ?? ColorUtils.appColorTextLight),
                labelStyle: TextStyle(
                    color: widget.hintColor ?? ColorUtils.appColorTextLight,
                    fontSize: SizeUtils.textSizeSmall),
                filled: true,
                fillColor:
                    widget.backgroundColor ?? ColorUtils.appColorGreyLight,
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 30.0),
                  borderSide: BorderSide(
                      color:
                          widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 30.0),
                  borderSide: BorderSide(
                      color:
                          widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  child: Icon(
                      widget.isPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black),
                )),
            cursorColor: widget.cursorColor ?? ColorUtils.appColorBlack,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.text,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap ?? null,
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: GoogleFonts.poppins(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeMedium,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor ?? ColorUtils.appColorBlack,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(25, 8, 4, 8),
              hintText: widget.hintText,
              labelText: widget.hintText,
              hintStyle: TextStyle(
                  color: widget.hintColor ?? ColorUtils.appColorTextLight),
              labelStyle: TextStyle(
                  color: widget.hintColor ?? ColorUtils.appColorTextLight,
                  fontSize: SizeUtils.textSizeSmall),
              filled: true,
              fillColor: widget.backgroundColor ?? ColorUtils.appColorGreyLight,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 30.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 30.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
            ),
            cursorColor: widget.cursorColor ?? ColorUtils.appColorBlack,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.text,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap ?? null,
          ));
    }
  }
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

class WalkThrough extends StatelessWidget {
  final String? textTitle;
  final String? textContent;
  final String walkImg;

  WalkThrough(
      {Key? key, this.textTitle, this.textContent, required this.walkImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: h * 0.05),
            height: h * 0.4,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(walkImg, width: width * 0.6, height: h * 0.3),
              ],
            ),
          ),
          SizedBox(height: h * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: textView(textTitle,
                textColor: ColorUtils.appColorWhite,
                fontSize: SizeUtils.textSizeXLarge,
                maxLine: 2,
                isCentered: true),
          ),
          SizedBox(height: h * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: textView(textContent,
                textColor: ColorUtils.appColorWhite,
                fontSize: SizeUtils.textSizeMedium,
                maxLine: 5,
                isCentered: true),
          )
        ],
      ),
    );
  }
}

BoxDecoration boxDecoration(
    {double? radius,
    Color? borderColor,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? ColorUtils.appColorAccent,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: borderColor ?? ColorUtils.appColorAccent),
    borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
  );
}

class RoundButton extends StatefulWidget {
  final String textContent;
  final Color? textColor;
  final double? textSize;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool isStroked;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final Color? strokeColor;

  RoundButton({
    Key? key,
    required this.isStroked,
    required this.textContent,
    this.textColor,
    this.textSize,
    this.height,
    this.radius,
    this.padding,
    this.backgroundColor,
    this.strokeColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  RoundButtonState createState() => RoundButtonState();
}

class RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      color: widget.backgroundColor ?? ColorUtils.appColorAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
          side: BorderSide(
            color: widget.isStroked
                ? widget.strokeColor ?? ColorUtils.appColorAccent
                : ColorUtils.appColorTransparent,
          )),
      child: Container(
        height: widget.height ?? 45,
        padding: widget.padding ?? const EdgeInsets.fromLTRB(25, 5, 25, 5),
        alignment: Alignment.center,
        child: textView(widget.textContent,
            fontSize: widget.textSize ?? SizeUtils.textSizeNormal,
            textColor: widget.textColor ?? ColorUtils.appColorWhite,
            fontWeight: FontWeight.w500,
            isCentered: true),
      ),
    );
  }
}

void showMessage(String str, double? alignment) {
  BotToast.showText(
      text: str,
      textStyle: const TextStyle(
          fontSize: SizeUtils.textSizeSMedium, color: ColorUtils.appColorWhite),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      contentColor: ColorUtils.appColorAccent,
      align: Alignment(0, alignment ?? 0.2));
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: ColorUtils.appColorBlack_50,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: const CircularProgressIndicator(
        backgroundColor: ColorUtils.appColorWhite,
        color: ColorUtils.appColorAccent_50,
      ),
    );
  }
}

void showLoading() {
  BotToast.showCustomLoading(
    toastBuilder: (_) => const LoadingWidget(),
    backgroundColor: ColorUtils.appColorTransparent,
  );
}

void hideLoading() {
  BotToast.closeAllLoading();
}
