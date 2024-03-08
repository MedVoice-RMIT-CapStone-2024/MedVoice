import 'package:shared_preferences/shared_preferences.dart';

enum SharedData {
  UPDATED_VERSION,
  APP_LANGUAGE,
  PHONE_COUNTRY,
  APP_FIRST_INSTALL,
}

class SharedPreferencesHelper {

  Future<SharedPreferences> getSharedPreference() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    await ref.reload();
    return ref;
  }

  void setStringValue(String key, String value) async {
    SharedPreferences ref = await getSharedPreference();
    ref.setString(key, value);
  }

  Future<String> getStringValue(String key, {String? defaultValue}) async {
    SharedPreferences ref = await getSharedPreference();
    final String? returnValue = ref.getString(key);
    if (returnValue == null) return defaultValue ?? "";
    return returnValue;
  }

  Future<void> setIntValue(String key, int value) async {
    SharedPreferences ref = await getSharedPreference();
    ref.setInt(key, value);
  }

  Future<int> getIntValue(String key, {int? defaultValue}) async {
    SharedPreferences ref = await getSharedPreference();
    final int? returnValue = ref.getInt(key);
    if (returnValue == null) return defaultValue ?? 0;
    return returnValue;
  }

  Future<void> setBoolValue(String key, bool value) async {
    SharedPreferences ref = await getSharedPreference();
    ref.setBool(key, value);
  }

  Future<bool> getBoolValue(String key, {bool? defaultValue}) async {
    SharedPreferences ref = await getSharedPreference();
    final bool? returnValue = ref.getBool(key);
    if (returnValue == null) return defaultValue ?? false;
    return returnValue;
  }
}
