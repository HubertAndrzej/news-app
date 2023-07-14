import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  static const themeStatus = 'THEMESTATUS';

  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(themeStatus) ?? false;
  }

  setDarkTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool(themeStatus, value);
  }
}
