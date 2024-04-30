import 'package:flutter/material.dart';
import 'package:mainstreet/providers/auth/user_auth_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBarUser extends StatefulWidget {
  final int currentIndex;
  const BottomNavBarUser({
    super.key,
    required this.currentIndex,
  });

  @override
  State<BottomNavBarUser> createState() => _BottomNavBarUserState();
}

class _BottomNavBarUserState extends State<BottomNavBarUser> {
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
          child: Text('logout'),
        ),
      ),
    );
  }
}
