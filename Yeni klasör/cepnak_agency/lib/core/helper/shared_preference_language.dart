import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceLanguage {
  static Future<void> setLanguage(String language) async {
    SharedPreferences lang = await SharedPreferences.getInstance();
    await lang.setString('language', language);
  }

  static Future<String?> getLanguage() async {
    SharedPreferences lang = await SharedPreferences.getInstance();
    return lang.getString('language');
  }

  static Future<void> setOnboardValue(bool value) async{
    SharedPreferences lang = await SharedPreferences.getInstance();
    await lang.setBool('value', value);
  }
  static Future<bool?> checkOnboardValue() async {
    SharedPreferences lang = await SharedPreferences.getInstance();
    return lang.getBool('value');
  }
}
