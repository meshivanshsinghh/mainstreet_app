import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mainstreet/providers/auth/merchant_auth_provider.dart';
import 'package:mainstreet/screens/auth/merchant/sign_in_web_view.dart';
import 'package:provider/provider.dart';

class SignInMerchant extends StatefulWidget {
  const SignInMerchant({super.key});

  @override
  State<SignInMerchant> createState() => _SignInMerchantState();
}

class _SignInMerchantState extends State<SignInMerchant> {
  late MerchantAuthProvider _merchantAuthProvider;

  Future<void> _fetchAccessToken(Uri url) async {
    print(url.queryParameters['code']);
  }

  @override
  Widget build(BuildContext context) {
    _merchantAuthProvider = Provider.of<MerchantAuthProvider>(
      context,
      listen: true,
    );
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text('Sign in with square '),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: SignInWebView(
                  authCodeUrl: (Uri uri) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      _fetchAccessToken(uri);
                    });
                  },
                ),
              );
            },
          );
        },
      )),
    );
  }
}
