import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mainstreet/app.dart';
import 'package:mainstreet/helpers/app_preferences.dart';
import 'package:mainstreet/models/merchant_model.dart';
import 'package:mainstreet/screens/auth/merchant/merchant_list_view.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar_merchant.dart';
import 'package:mainstreet/services/api_service.dart';

class MerchantAuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService _apiService = ApiService();
  final AppPreferences _appPreferences = AppPreferences();
  final _firebaseFirestore = FirebaseFirestore.instance;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getAccessToken({
    required String code,
  }) async {
    setLoading(true);
    try {
      final data = await _apiService.getAccessTokenFromCode(code: code);
      if (data != null) {
        await _appPreferences.setAccessTokenModel(accessTokenModel: data);
        final merchantData = await _apiService.getMerchantData(
          merchantId: data.merchantId!,
        );
        if (merchantData != null && merchantData.merchant != null) {
          DocumentSnapshot dSnapshot = await _firebaseFirestore
              .collection('merchants')
              .doc(merchantData.merchant!.id)
              .get();
          if (dSnapshot.exists) {
            // old merchant
            final documentSnapshot = await _firebaseFirestore
                .collection('merchants')
                .doc(merchantData.merchant!.id)
                .get();
            Merchant storedMerchant = Merchant.fromJson(
              documentSnapshot.data() as dynamic,
            );
            await _appPreferences.setSignIn();
            await _appPreferences.setCurrentAppUser(
              'merchant',
            );
            await _appPreferences.setMerchantModel(
              merchant: storedMerchant,
            );
            Navigator.of(mainNavigatorKey.currentContext!).popUntil(
              (route) => route.isFirst,
            );
            Navigator.of(mainNavigatorKey.currentContext!).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavbarMerchant(
                  currentIndex: 0,
                ),
              ),
            );
          } else {
            // new user

            Merchant merchant = merchantData.merchant!;
            merchant.shopPicture = '';
            merchant.lat = '';
            merchant.long = '';
            await _firebaseFirestore
                .collection('merchants')
                .doc(merchantData.merchant!.id)
                .set(merchantData.toJson(), SetOptions(merge: true));
            await _appPreferences.setSignIn();
            await _appPreferences.setCurrentAppUser(
              'merchant',
            );
            await _appPreferences.setMerchantModel(
              merchant: merchantData.merchant!,
            );
            Navigator.of(mainNavigatorKey.currentContext!).popUntil(
              (route) => route.isFirst,
            );
            Navigator.of(mainNavigatorKey.currentContext!).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MerchantListView(
                  merchant: merchantData.merchant!,
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
