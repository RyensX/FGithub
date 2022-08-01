import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/profile.dart';

class Global {
  static late SharedPreferences _prefs;
  static const _profileKey = "profile";

  static late Profile profile;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    //加载用户配置
    var profileJson = _prefs.getString(_profileKey);
    if (profileJson != null) {
      try {
        profile = Profile.fromJson(jsonDecode(profileJson));
      } catch (e) {
        print(e);
      }
    } else {
      profile = Profile();
    }
  }

  static saveProfile() =>
      _prefs.setString(_profileKey, jsonEncode(profile.toJson()));
}
