import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/common/common_style.dart';
import 'package:mainstreet/common/common_utils.dart';
import 'package:mainstreet/providers/auth/user_auth_provider.dart';
import 'package:mainstreet/screens/auth/user/sign_up_user.dart';
import 'package:mainstreet/screens/auth/user/widgets/rounded_loading_button.dart';
import 'package:provider/provider.dart';

class SignInUser extends StatefulWidget {
  const SignInUser({super.key});

  @override
  State<SignInUser> createState() => _SignInUserState();
}

class _SignInUserState extends State<SignInUser> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserAuthProvider _authProvider;
  bool _togglePasswordVisibility = true;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<UserAuthProvider>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.70,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  left: 10,
                  right: 10,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: const AssetImage('assets/images/signin_back.jpeg'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.darken),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Continue to\nyour Account.',
                      style: CommonStyle.getInterFont(
                        color: CommonColors.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: const Divider(color: CommonColors.whiteColor),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "MainStreet is your connection to the heart of your city. New to MainStreet?",
                            style: CommonStyle.getInterFont(
                              color: CommonColors.whiteColor,
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' Register Here',
                            style: CommonStyle.getInterFont(
                              color: CommonColors.whiteColor,
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                HapticFeedback.lightImpact();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpUser(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              top: MediaQuery.of(context).size.height * 0.30,
              right: 0,
              child: Container(
                color: CommonColors.whiteColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      textFormField(
                        hintText: 'abc@example.com',
                        controller: _emailController,
                        icon: Icons.mail,
                      ),
                      textFormField(
                        hintText: '**********',
                        controller: _passwordController,
                        icon: _togglePasswordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _emailController.text.trim().isNotEmpty &&
                                _passwordController.text.trim().isNotEmpty &&
                                !_authProvider.isLoading
                            ? () {
                                HapticFeedback.lightImpact();
                                FocusManager.instance.primaryFocus?.unfocus();
                                _authProvider.signInUserWithEmailPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                              }
                            : () {
                                CommonUtils().showSnackBar(
                                  context: context,
                                  content:
                                      'Please fill all required fields to login.',
                                );
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: CommonColors.lightPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: _authProvider.isLoading
                              ? const CupertinoActivityIndicator(
                                  color: CommonColors.whiteColor,
                                )
                              : Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      'Login',
                                      style: CommonStyle.getInterFont(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      FontAwesomeIcons.arrowRight,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: Divider()),
                          const SizedBox(width: 20),
                          Text(
                            'Or',
                            style: CommonStyle.getInterFont(
                              color: Colors.black45,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const RoundedButtonWidget(
                        title: 'Continue with Google',
                        icon: FontAwesomeIcons.google,
                        color: Color(0xffDB4437),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleVisibility() {
    HapticFeedback.lightImpact();
    if (mounted) {
      setState(() {
        _togglePasswordVisibility = !_togglePasswordVisibility;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Widget textFormField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CommonColors.lightPrimaryColor.withOpacity(0.2),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          setState(() {});
        },
        keyboardType: controller == _emailController
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        textInputAction: textInputAction,
        obscureText: controller == _passwordController
            ? _togglePasswordVisibility
            : false,
        cursorColor: CommonColors.primaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: () {
              if (controller == _passwordController) {
                toggleVisibility();
              }
            },
            child: Icon(
              icon,
              color: Colors.black45,
              size: 20,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 50),
          hintText: hintText,
          hintStyle: CommonStyle.getInterFont(
            color: Colors.black45,
          ),
        ),
        style: CommonStyle.getInterFont(
          color: Colors.black87,
        ),
      ),
    );
  }
}
