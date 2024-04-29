import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/common/common_style.dart';
import 'package:mainstreet/screens/auth/merchant/sign_in_merchant.dart';
import 'package:mainstreet/screens/auth/user/sign_in_user.dart';
import 'package:mainstreet/screens/auth/widgets/frosted_button.dart';

class SignInSelectionScren extends StatefulWidget {
  static const routeName = '/welcome-page';
  const SignInSelectionScren({super.key});

  @override
  State<SignInSelectionScren> createState() => _SignInSelectionScrenState();
}

class _SignInSelectionScrenState extends State<SignInSelectionScren> {
  // TODO: add the logic to get the email as parameter inthis and logout the user.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/signin_selection_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Get Started',
                    style: CommonStyle.getInterFont(
                      color: CommonColors.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Are you a local business owner or a community member? Select your account type to enjoy the best MainStreet has to offer.',
                    style: CommonStyle.getInterFont(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  buildButtonMerchant(),
                  const SizedBox(height: 20),
                  buildButtonCustomer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonMerchant() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SignInUser(),
          ),
        );
      },
      child: FrostedGlassBox(
        theWidth: MediaQuery.of(context).size.width,
        theHeight: 50,
        theChild: Row(
          children: [
            const SizedBox(width: 20),
            Text(
              'Join as Customer',
              style: CommonStyle.getInterFont(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: CommonColors.primaryColor,
              ),
              height: 50,
              width: 60,
              child: const Icon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white70,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtonCustomer() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SignInMerchant(),
          ),
        );
      },
      child: FrostedGlassBox(
        theWidth: MediaQuery.of(context).size.width,
        theHeight: 50,
        theChild: Row(
          children: [
            const SizedBox(width: 20),
            Text(
              'Join as Merchant',
              style: CommonStyle.getInterFont(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: CommonColors.primaryColor,
              ),
              height: 50,
              width: 60,
              child: const Icon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white70,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
