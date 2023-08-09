import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences preferences;
  static Future<void> initPrefs() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setGettingStarted() async {
    preferences.setBool('gettingStarted', true);
  }

  static Future<bool> getGettingStarted() async {
    return preferences.containsKey('gettingStarted');
  }

}
