import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mainstreet/app.dart';
import 'package:mainstreet/common/common_utils.dart';
import 'package:mainstreet/models/merchant_model.dart';
import 'package:mainstreet/models/user_model.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  Merchant? _merchant;
  Merchant? get merchant => _merchant;
  bool _onboardingCompleted = false;
  bool get onboardingCompleted => _onboardingCompleted;
  String? _uid;
  String? get uid => _uid;
  String? _currentAppUser;
  String? get currentAppUser => _currentAppUser;

  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  UserAuthProvider() {
    checkSignIn();
    checkOnBoarding();
    checkCurrentAppUser();
  }

  void checkCurrentAppUser() async {
    _currentAppUser = await appPreferences.getCurrentAppUser();
    notifyListeners();
  }

  void checkOnBoarding() async {
    _onboardingCompleted = await appPreferences.getOnboarding();
    notifyListeners();
  }

  void checkSignIn() async {
    _isSignedIn = await appPreferences.getSignIn();
    notifyListeners();
  }

  Future<void> setUserModel() async {
    UserModel? userData = await appPreferences.getUserModel();
    _userModel = userData;
    notifyListeners();
  }

  Future<void> setMerchantModel() async {
    Merchant? merchant = await appPreferences.getMerchantModel();
    _merchant = merchant;
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
        await handleAfterAuth(userModel: null);
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

  Future<void> signUpWithGoogle() async {
    try {
      UserCredential currentUserCredential = await getGoogleCredentials();
      if (currentUserCredential.user != null) {
        _uid = currentUserCredential.user!.uid;
        notifyListeners();
        AdditionalUserInfo? additionalUserInfo =
            currentUserCredential.additionalUserInfo;

        if (additionalUserInfo != null) {
          UserModel userModel = UserModel(
            userId: _uid,
            profilePicture: additionalUserInfo.profile?['picture'],
            email: additionalUserInfo.profile?['email'],
            createdAt: DateTime.now().millisecondsSinceEpoch,
            lat: '',
            long: '',
            bio: '',
            fcmToken: '',
            name: additionalUserInfo.profile?['name'],
          );
          await handleAfterAuth(userModel: userModel);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserCredential> getGoogleCredentials() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> isNewUser({required String userId}) async {
    DocumentSnapshot dSnapshot =
        await _firebaseFirestore.collection('users').doc(userId).get();
    return !dSnapshot.exists;
  }

  Future<void> handleAfterAuth({
    required UserModel? userModel,
  }) async {
    try {
      if (_uid != null) {
        if (await isNewUser(userId: _uid!) && userModel != null) {
          userModel.userId = _uid;
          _firebaseFirestore
              .collection('users')
              .doc(userModel.userId)
              .set(userModel.toJson())
              .then((value) {
            getUserDataFromFirebase();
          });
        } else {
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
          builder: (context) => const BottomNavBarUser(
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
      await appPreferences.setUserModel(user: _userModel!);
      await appPreferences.setSignIn();
      await appPreferences.setCurrentAppUser('user');
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

  Future<void> signInMerchantAccount() async {}
}
