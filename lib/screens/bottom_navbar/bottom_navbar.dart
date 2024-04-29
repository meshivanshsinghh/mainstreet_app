import 'package:flutter/material.dart';
import 'package:mainstreet/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBarCustom extends StatefulWidget {
  final int currentIndex;
  const BottomNavBarCustom({
    super.key,
    required this.currentIndex,
  });

  @override
  State<BottomNavBarCustom> createState() => _BottomNavBarCustomState();
}

class _BottomNavBarCustomState extends State<BottomNavBarCustom> {
  late AuthProviderCustom authProviderCustom;
  @override
  Widget build(BuildContext context) {
    authProviderCustom =
        Provider.of<AuthProviderCustom>(context, listen: false);
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            authProviderCustom.userSignOut();
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
