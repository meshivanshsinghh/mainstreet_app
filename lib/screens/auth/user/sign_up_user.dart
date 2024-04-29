import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/common/common_style.dart';
import 'package:mainstreet/common/common_utils.dart';
import 'package:mainstreet/models/user_model.dart';
import 'package:mainstreet/providers/auth_provider.dart';
import 'package:mainstreet/screens/auth/user/sign_in_user.dart';
import 'package:provider/provider.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({super.key});

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  late AuthProviderCustom _authProvider;
  bool _togglePasswordVisibility = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProviderCustom>(context, listen: true);
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
                        'Create your \nAccount.',
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
                                  "Join our community to explore what's trending in your street. Already registered?",
                              style: CommonStyle.getInterFont(
                                color: CommonColors.whiteColor,
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' Login now',
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
                                      builder: (context) => const SignInUser(),
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
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          textFormField(
                            hintText: 'John Doe',
                            controller: _nameController,
                            icon: Icons.person,
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                              if (value != null && value.trim().isEmpty) {
                                return 'Please provide your full name';
                              }
                              return null;
                            },
                          ),
                          textFormField(
                            hintText: 'abc@example.com',
                            controller: _emailController,
                            icon: Icons.mail,
                            textInputType: TextInputType.emailAddress,
                            validator: (String? value) {
                              const pattern =
                                  r'^[a-zA-Z0-9.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+';
                              final regExp = RegExp(pattern);
                              if (value != null && value.trim().isEmpty) {
                                return 'Email address cannot be empty';
                              } else if (value != null &&
                                  !regExp.hasMatch(value)) {
                                return 'This is an invalid email address';
                              }
                              return null;
                            },
                          ),
                          textFormField(
                            hintText: '*********',
                            controller: _passwordController,
                            icon: _togglePasswordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: (String? value) {
                              if (value != null && value.trim().isEmpty) {
                                return 'Password cannot be empty';
                              }
                              return null;
                            },
                          ),
                          textFormField(
                            hintText: 'Enter your bio here...',
                            controller: _bioController,
                            icon: Icons.edit,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: (String? value) {
                              if (value != null && value.trim().isEmpty) {
                                return 'Bio cannot be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap:
                                _authProvider.isLoading ? null : completeSignUp,
                            child: Container(
                              decoration: BoxDecoration(
                                color: CommonColors.primaryColor,
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
                                          'Create Account',
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
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'By tapping “Continue” you agree to create an account with Travlog and to the ',
                                  style: CommonStyle.getInterFont(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms and Privacy Policy',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      CommonUtils().showSnackBar(
                                        context: context,
                                        content: 'not available',
                                      );
                                    },
                                  style: CommonStyle.getInterFont(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    color: CommonColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' set out on our website.',
                                  style: CommonStyle.getInterFont(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget textFormField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    TextInputType textInputType = TextInputType.name,
    TextInputAction textInputAction = TextInputAction.next,
    required String? Function(String?)? validator,
    int maxLines = 1,
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
        validator: validator,
        maxLines: maxLines,
        onChanged: (value) {
          setState(() {});
        },
        autovalidateMode: AutovalidateMode.disabled,
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
          errorStyle: CommonStyle.getInterFont(
            color: Colors.red,
            fontSize: 10,
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 50),
          hintText: hintText,
          hintStyle: CommonStyle.getInterFont(
            color: Colors.black45,
          ),
        ),
        style: CommonStyle.getInterFont(color: Colors.black87),
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

  Future<void> completeSignUp() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      await _authProvider.signUpUserWithEmailPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        onSuccess: () async {
          _authProvider.handleAfterAuth(
            userModel: UserModel(
              name: _nameController.text.trim(),
              createdAt: DateTime.now().millisecondsSinceEpoch,
              email: _emailController.text.trim(),
              isMerchant: false,
              bio: _bioController.text.trim(),
              profilePicture: '',
              fcmToken: '',
              lat: '',
              long: '',
            ),
          );
        },
      );
    }
  }
}
