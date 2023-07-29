import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? sharedPreferences;

  static void clear() {
    sharedPreferences!.clear();
  }

  static void set(String key, String value) {
    sharedPreferences!.setString('type', value);
  }

  static String load(key) {
    return sharedPreferences == null ? "" : (sharedPreferences!.getString(key) ?? "");
  }
}
