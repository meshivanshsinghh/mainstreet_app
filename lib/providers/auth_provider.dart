import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainstreet/helpers/app_preferences.dart';
import 'package:mainstreet/models/user_model.dart';

class AuthProviderCustom extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _onboardingCompleted = false;
  bool get onboardingCompleted => _onboardingCompleted;

  final _appPreferences = AppPreferences();
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  AuthProviderCustom() {
    checkSignIn();
    checkOnBoarding();
  }

  void checkOnBoarding() async {
    _onboardingCompleted = await _appPreferences.getOnboarding();
    notifyListeners();
  }

  void checkSignIn() async {
    _isSignedIn = await _appPreferences.getSignIn();
    notifyListeners();
  }

  Future<void> setUserModel() async {
    UserModel? userData = await _appPreferences.getUserModel();
    _userModel = userData;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
