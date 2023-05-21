import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../model/user_model.dart';

class LocalStorageUser {
  static setUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('users', json.encode(userModel.toJson()));
  }

  static Future<UserModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserModel.fromJson(
        json.decode(prefs.getString('users')!) as Map<String, dynamic>);
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
