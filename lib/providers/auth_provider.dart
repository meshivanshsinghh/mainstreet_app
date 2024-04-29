import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mainstreet/app.dart';
import 'package:mainstreet/common/common_utils.dart';
import 'package:mainstreet/helpers/app_preferences.dart';
import 'package:mainstreet/models/user_model.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProviderCustom extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _onboardingCompleted = false;
  bool get onboardingCompleted => _onboardingCompleted;
  String? _uid;
  String? get uid => _uid;
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

  Future<void> signInUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        notifyListeners();
        await handleAfterAuth(userModel: UserModel());
      }
    } on FirebaseAuthException catch (e) {
      CommonUtils().showSnackBar(
        content: e.message.toString(),
        context: mainNavigatorKey.currentContext!,
      );
      debugPrint(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> signUpUserWithEmailPassword({
    required String email,
    required String password,
    required Function onSuccess,
  }) async {
    setLoading(true);
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        notifyListeners();
        onSuccess();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<bool> isNewUser({required String userId}) async {
    DocumentSnapshot dSnapshot =
        await _firebaseFirestore.collection('users').doc(userId).get();
    return !dSnapshot.exists;
  }

  Future<void> handleAfterAuth({
    required UserModel userModel,
  }) async {
    try {
      if (_uid != null) {
        if (await isNewUser(userId: _uid!)) {
          userModel.userId = _uid;
          _firebaseFirestore
              .collection('users')
              .doc(userModel.userId)
              .set(userModel.toJson())
              .then((value) {
            getUserDataFromFirebase();
          });
        } else {
          // existing user
          await getUserDataFromFirebase();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.of(mainNavigatorKey.currentContext!).popUntil(
        (route) => route.isFirst,
      );
      Navigator.of(mainNavigatorKey.currentContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBarCustom(
            currentIndex: 0,
          ),
        ),
      );
    }
  }

  Future<void> getUserDataFromFirebase() async {
    DocumentSnapshot dSnapshot =
        await _firebaseFirestore.collection('users').doc(_uid).get();
    if (dSnapshot.exists) {
      _userModel = UserModel.fromJson(dSnapshot.data() as dynamic);
      await _appPreferences.setUserModel(user: _userModel!);
      await _appPreferences.setSignIn();
      notifyListeners();
    } else {
      userSignOut();
    }
  }

  Future<void> userSignOut() async {
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    _userModel = null;
    clearAllData();
    notifyListeners();
  }

  Future<void> clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
