import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 本地存储
class StoragePrefs {
  StoragePrefs._internal();
  static final StoragePrefs _instance = StoragePrefs._internal();

  factory StoragePrefs() {
    return _instance;
  }

  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // json字符串
  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return prefs!.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = prefs?.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  // bool
  Future<bool> setBool(String key, bool val) {
    return prefs!.setBool(key, val);
  }

  bool? getBool(String key) {
    return prefs!.getBool(key);
  }


  // 存取字符串
  String? getString(String key) {
    return prefs!.getString(key);
  }

  setStringPrefs(String key, String value) {
    return prefs!.setString(key, value);
  }

  // 存取字符串数组
  getStringListPrefs(String key) {
    return prefs!.getStringList(key);
  }

  setStringListPrefs(String key, List<String> value) {
    return prefs!.setStringList(key, value);
  }

  // 存取Int
  getIntPrefs(String key) async {
    return await prefs!.getInt(key);
  }

  setIntPrefs(String key, int value) async {
    return await prefs!.setInt(key, value);
  }

  // 存取double
  getDoublePrefs(String key) async {
    return await prefs!.getDouble(key);
  }

  setDoublePrefs(String key, double value) async {
    return await prefs!.setDouble(key, value);
  }

  Future<bool> remove(String key) {
    return prefs!.remove(key);
  }
}
