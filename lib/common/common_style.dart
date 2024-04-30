import 'package:flutter/material.dart';

class CommonStyle {
  static TextStyle getInterFont(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration,
      double? height,
      double? letterSpacing}) {
    return TextStyle(
      fontFamily: "Inter",
      color: color,
      letterSpacing: letterSpacing ?? 0.3,
      decoration: decoration ?? TextDecoration.none,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle ?? FontStyle.normal,
      height: height,
    );
  }
}
