import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

/// Go back to previous screen.
void finishView(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) Navigator.pop(context, result);
}

/// Go to new screen with provided screen tag.
///
/// ```dart
/// launchNewScreen(context, '/HomePage');
/// ```
Future<T?> launchNewScreen<T>(BuildContext context, String tag) async =>
    Navigator.of(context).pushNamed(tag);

/// Removes all previous screens from the back stack and redirect to new screen with provided screen tag
///
/// ```dart
/// launchNewScreenWithNewTask(context, '/HomePage');
/// ```
Future<T?> launchNewScreenWithNewTask<T>(
        BuildContext context, String tag) async =>
    Navigator.of(context).pushNamedAndRemoveUntil(tag, (r) => false);

/// Change status bar Color and Brightness
Future<void> setStatusBarColor(
  Color statusBarColor, {
  Color? systemNavigationBarColor,
  Brightness? statusBarBrightness,
  Brightness? statusBarIconBrightness,
  int delayInMilliSeconds = 200,
}) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ??
          (statusBarColor.isDark() ? Brightness.light : Brightness.dark),
    ),
  );
}

/// This function will show status bar
Future<void> showStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
}

/// This function will hide status bar
Future<void> hideStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

/// Set orientation to portrait
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Set orientation to landscape
void setOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

/// Returns current PlatformName
String platformName() {
  if (isLinux) return 'Linux';
  if (isWeb) return 'Web';
  if (isMacOS) return 'macOS';
  if (isWindows) return 'Windows';
  if (isAndroid) return 'Android';
  if (isIOS) return 'iOS';
  return '';
}

/// Custom scroll behaviour
Widget Function(BuildContext, Widget?)? scrollBehaviour() {
  return (context, child) {
    return ScrollConfiguration(behavior: SBehavior(), child: child!);
  };
}

/// Custom scroll behaviour widget
class SBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// Invoke Native method and get result
Future<T?> invokeNativeMethod<T>(String channel, String method,
    [dynamic arguments]) async {
  var platform = MethodChannel(channel);
  return await platform.invokeMethod<T>(method, arguments);
}

Future<String?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

bool isValidEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(email);
}

bool isValidPassword(String password) {
  return password.length >= 6;
}
