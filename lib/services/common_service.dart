import 'package:shared_preferences/shared_preferences.dart';

class CommonService{
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  static const String termsUrl = 'https://www.google.com';
  static const String conditionsUrl = 'https://www.google.com';
}