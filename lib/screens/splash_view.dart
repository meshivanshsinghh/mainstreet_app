import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/providers/auth_provider.dart';
import 'package:mainstreet/screens/auth/sign_in_selection_screen.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar.dart';
import 'package:mainstreet/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late AuthProviderCustom _authProviderCustom;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _authProviderCustom = Provider.of<AuthProviderCustom>(
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
    if (_authProviderCustom.onboardingCompleted) {
      if (_authProviderCustom.isSignedIn) {
        navigateToPage(page: const BottomNavBarCustom(currentIndex: 0));
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
