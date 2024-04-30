import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainstreet/common/common_style.dart';
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
  @override
  Widget build(BuildContext context) {
    _merchantAuthProvider = Provider.of<MerchantAuthProvider>(
      context,
      listen: false,
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            const AssetImage('assets/images/signin_back.jpeg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.8),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * 0.38,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SafeArea(
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  'assets/images/square_icon.png',
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                'Connect your Square Account',
                                style: CommonStyle.getInterFont(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Connect your square merchant account to manage your business with Mainstreet.',
                                style: CommonStyle.getInterFont(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              buildButtonMerchant(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        height: 50,
        child: ElevatedButton(
          onPressed: _merchantAuthProvider.isLoading
              ? null
              : () {
                  Future.delayed(const Duration(milliseconds: 500), () {
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
                            authCodeUrl: (Uri? uri) {
                              if (uri != null && mounted) {
                                Navigator.of(context).pop();
                                _merchantAuthProvider.getAccessToken(
                                  code: uri.queryParameters['code']!,
                                );
                                setState(() {});
                              }
                            },
                          ),
                        );
                      },
                    );
                  });
                },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.black,
          ),
          child: _merchantAuthProvider.isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Row(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/square_icon.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Continue with Square',
                      style: CommonStyle.getInterFont(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
        ),
      ),
    );
  }
}
