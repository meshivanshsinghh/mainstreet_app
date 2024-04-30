import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/providers/auth/user_auth_provider.dart';
import 'package:mainstreet/screens/auth/sign_in_selection_screen.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar_merchant.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar_user.dart';
import 'package:mainstreet/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late UserAuthProvider _userAuthProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _userAuthProvider = Provider.of<UserAuthProvider>(
        context,
        listen: false,
      );
      Future.delayed(const Duration(milliseconds: 500), () => initData());
    });
  }

  void initData() async {
    precacheImage(
      const AssetImage('assets/images/signin_selection_screen.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/signin_back.jpeg'),
      context,
    );
    if (_userAuthProvider.onboardingCompleted) {
      if (_userAuthProvider.isSignedIn) {
        if (_userAuthProvider.currentAppUser == 'user') {
          _userAuthProvider.setUserModel();
          navigateToPage(page: const BottomNavBarUser(currentIndex: 0));
        } else {
          _userAuthProvider.setMerchantModel();
          navigateToPage(page: const BottomNavbarMerchant(currentIndex: 0));
        }
      } else {
        navigateToPage(page: const SignInSelectionScren());
      }
    } else {
      navigateToPage(page: const OnboardingScreen());
    }
  }

  navigateToPage({required Widget page}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: CommonColors.whiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/main_street_splash_icon.png',
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
