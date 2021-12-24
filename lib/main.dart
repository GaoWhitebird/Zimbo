import 'package:bot_toast/bot_toast.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/utils/string_utils.dart';
import 'package:flutter/material.dart';

import 'locator.dart';
import 'views/auth/splash_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringUtils.txtAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorUtils.appColorPrimary,
        primaryColorDark: ColorUtils.appColorPrimaryDark, 
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorUtils.appColorAccent),
        brightness: Brightness.light
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const SplashView(),
    );
  }
}