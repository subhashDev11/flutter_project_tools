import 'package:flutter_project_tools/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService {
  SharedPreferences? appPref;

  init() async {
    appPref = await SharedPreferences.getInstance();
  }

  Future<bool> setString({required String key, required String data}) async {
    try {
      appPref ??= await SharedPreferences.getInstance();
      appPref?.setString(key, data);
      return true;
    } catch (e) {
      AppLogger.e('Exception to set data on pref -> $e');
      return false;
    }
  }

  Future<String?>? getString({
    required String key,
  }) async {
    try {
      appPref ??= await SharedPreferences.getInstance();
      return appPref?.getString(key);
    } catch (e) {
      AppLogger.e('Exception to set data on pref -> $e');
      return null;
    }
  }

  Future<bool> setBool({required String key, required bool value}) async {
    try {
      appPref ??= await SharedPreferences.getInstance();
      appPref?.setBool(key, value);
      return true;
    } catch (e) {
      AppLogger.e('Exception to set data on pref -> $e');
      return false;
    }
  }

  Future<bool?> getBool({required String key}) async {
    try {
      appPref ??= await SharedPreferences.getInstance();
      return appPref?.getBool(key);
    } catch (e) {
      AppLogger.e('Exception to set data on pref -> $e');
      return null;
    }
  }

  Future delete(String key, bool clearAll) async {
    appPref ??= await SharedPreferences.getInstance();
    appPref?.remove(key);
    if (clearAll) {
      appPref?.clear();
    }
  }
}
