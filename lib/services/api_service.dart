import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mainstreet/app.dart';
import 'package:mainstreet/common/constants.dart';
import 'package:mainstreet/models/auth/access_token_model.dart';
import 'package:mainstreet/models/merchant_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(headers: {
    'Content-Type': 'application/json',
    'Square-Version': '2024-03-20',
  }));

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await appPreferences.getAccessTokenModel();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer ${token.accessToken}';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  Future<AccessTokenModel?> getAccessTokenFromCode({
    required String code,
  }) async {
    AccessTokenModel? accessTokenModel;
    try {
      final Response response = await _dio.post(
        SquareAPIUrls.getUserToken,
        data: {
          'client_secret': Constants.clientSecret,
          'client_id': Constants.clientId,
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': Constants.authRedirectUrl,
          'short_lived': true,
        },
      );

      if (response.statusCode == 200 && response.data['access_token'] != null) {
        accessTokenModel = AccessTokenModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return accessTokenModel;
  }

  Future<MerchantModel?> getMerchantData({required String merchantId}) async {
    MerchantModel? merchantModel;
    try {
      print(merchantId);
      final Response response = await _dio.get(
        '${SquareAPIUrls.getMerchantData}/$merchantId',
      );
      print(response.data);
      if (response.statusCode == 200 && response.data['merchant'] != null) {
        merchantModel = MerchantModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return merchantModel;
  }
}
