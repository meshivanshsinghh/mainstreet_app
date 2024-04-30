import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mainstreet/helpers/app_preferences_key.dart';
import 'package:mainstreet/models/auth/access_token_model.dart';
import 'package:mainstreet/models/merchant_model.dart';
import 'package:mainstreet/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final AppPreferencesKeys _appPreferenceKeys = AppPreferencesKeys();

  final FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> setSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_appPreferenceKeys.isSignedIn, true);
  }

  Future<bool> getSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_appPreferenceKeys.isSignedIn) ?? false;
  }

  Future<void> setCurrentAppUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _appPreferenceKeys.userType,
      user,
    );
  }

  Future<String> getCurrentAppUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appPreferenceKeys.userType) ?? 'user';
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

  Future<void> setMerchantModel({
    required Merchant merchant,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _appPreferenceKeys.merchantModel,
      jsonEncode(
        merchant.toJson(),
      ),
    );
  }

  Future<Merchant?> getMerchantModel() async {
    final prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(_appPreferenceKeys.merchantModel) ?? '';
    if (data.trim().isNotEmpty) {
      Merchant savedUser = Merchant.fromJson(jsonDecode(data));
      return savedUser;
    } else {
      return null;
    }
  }

  Future<AccessTokenModel?> getAccessTokenModel() async {
    String? data = await flutterSecureStorage.read(
      key: _appPreferenceKeys.accessTokenMerchant,
    );
    if (data != null && data.trim().isNotEmpty) {
      return AccessTokenModel.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }

  Future<void> setAccessTokenModel({
    required AccessTokenModel accessTokenModel,
  }) async {
    await flutterSecureStorage.write(
      key: _appPreferenceKeys.accessTokenMerchant,
      value: jsonEncode(
        accessTokenModel.toJson(),
      ),
    );
  }
}
