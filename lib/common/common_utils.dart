import 'package:flutter/material.dart';
import 'package:mainstreet/common/common_colors.dart';

class CommonUtils {
  void showSnackBar({
    required BuildContext context,
    required String content,
    Color backgroundColor = CommonColors.primaryColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Text(
          content,
          style: TextStyle(
            color: backgroundColor == CommonColors.primaryColor
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
