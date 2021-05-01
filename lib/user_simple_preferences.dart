import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyEmail = 'email_user';
  static const _keyCity = 'city_filter';
  static const _keyCategory = 'category';
  static const _keyUserName = 'user_name';
  static const _keyPhoneNum = 'phnum';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String getEmail() => _preferences.getString(_keyEmail);

  static Future setCity(String city) async =>
      await _preferences.setString(_keyCity, city);

  static String getCity() => _preferences.getString(_keyCity);

  static Future setCategory(String cat) async =>
      await _preferences.setString(_keyCategory, cat);

  static String getCategory() => _preferences.getString(_keyCategory);

  static Future setUserName(String name) async =>
      await _preferences.setString(_keyUserName, name);

  static String getUserName() => _preferences.getString(_keyUserName);

  static Future setphonenumber(String phnum) async =>
      await _preferences.setString(_keyPhoneNum, phnum);

  static String getphonenumber() => _preferences.getString(_keyPhoneNum);
}
