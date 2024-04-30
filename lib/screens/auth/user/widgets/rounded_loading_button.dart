import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainstreet/common/common_style.dart';
import 'package:mainstreet/providers/auth/user_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class RoundedButtonWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  const RoundedButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  State<RoundedButtonWidget> createState() => _RoundedButtonWidgetState();
}

class _RoundedButtonWidgetState extends State<RoundedButtonWidget> {
  final _controller = RoundedLoadingButtonController();
  late UserAuthProvider _userAuthProvider;

  @override
  void initState() {
    super.initState();
    _userAuthProvider = Provider.of<UserAuthProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: _controller,
      borderRadius: 10,
      elevation: 1,
      onPressed: socialSignIn,
      color: widget.color,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              widget.title,
              style: CommonStyle.getInterFont(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void socialSignIn() async {
    HapticFeedback.lightImpact();
    try {
      _controller.start();
      await _userAuthProvider.signUpWithGoogle();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _controller.stop();
    }
  }
}
