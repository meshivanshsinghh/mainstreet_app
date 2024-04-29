import 'dart:convert';

import 'package:mainstreet/helpers/app_preferences_key.dart';
import 'package:mainstreet/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final AppPreferencesKeys _appPreferenceKeys = AppPreferencesKeys();

  Future<void> setSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_appPreferenceKeys.isSignedIn, true);
  }

  Future<bool> getSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_appPreferenceKeys.isSignedIn) ?? false;
  }

  Future<void> setOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      _appPreferenceKeys.onBoarding,
      true,
    );
  }

  Future<bool> getOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_appPreferenceKeys.onBoarding) ?? false;
  }

  Future<void> setUserModel({
    required UserModel user,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _appPreferenceKeys.userModel,
      jsonEncode(
        user.toJson(),
      ),
    );
  }

  Future<UserModel?> getUserModel() async {
    final prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(_appPreferenceKeys.userModel) ?? '';
    if (data.trim().isNotEmpty) {
      UserModel savedUser = UserModel.fromJson(jsonDecode(data));
      return savedUser;
    } else {
      return null;
    }
  }
}
