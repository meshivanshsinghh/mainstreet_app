import 'package:flutter/material.dart';
import 'package:mainstreet/providers/auth/user_auth_provider.dart';
import 'package:provider/provider.dart';

class BottomNavbarMerchant extends StatefulWidget {
  final int currentIndex;
  const BottomNavbarMerchant({
    super.key,
    required this.currentIndex,
  });

  @override
  State<BottomNavbarMerchant> createState() => _BottomNavbarMerchantState();
}

class _BottomNavbarMerchantState extends State<BottomNavbarMerchant> {
  late UserAuthProvider userAuthProvider;
  @override
  Widget build(BuildContext context) {
    userAuthProvider = Provider.of<UserAuthProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            userAuthProvider.userSignOut();
          },
          child: Text('logout merchant'),
        ),
      ),
    );
  }
}
