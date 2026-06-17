import 'package:flutter/material.dart';

enum AppFontWeight {
  /// FontWeight.w300
  light,

  /// FontWeight.w400
  regular,

  /// FontWeight.w500
  medium,

  /// FontWeight.w600
  semibold,

  /// FontWeight.w700
  bold,
}

class AppTypography {
  const AppTypography._();

  static const fontFamily = 'KOOkies';

  static TextStyle textXL({
    AppFontWeight weight = AppFontWeight.regular,
    Color? color,
    double fontSize = 24,
  }) {
    return _getTextStyle(fontSize: fontSize, weight: weight, color: color);
  }

  static TextStyle textLG({
    AppFontWeight weight = AppFontWeight.regular,
    Color? color,
    double fontSize = 18,
  }) {
    return _getTextStyle(fontSize: fontSize, weight: weight, color: color);
  }

  static TextStyle textMD({
    AppFontWeight weight = AppFontWeight.regular,
    Color? color,
  }) {
    return _getTextStyle(fontSize: 16, weight: weight, color: color);
  }

  static TextStyle textSM({
    AppFontWeight weight = AppFontWeight.regular,
    Color? color,
  }) {
    return _getTextStyle(fontSize: 14, weight: weight, color: color);
  }

  static TextStyle textXS({
    AppFontWeight weight = AppFontWeight.regular,
    Color? color,
    double fontSize = 12,
  }) {
    return _getTextStyle(fontSize: fontSize, weight: weight, color: color);
  }

  static TextStyle _getTextStyle({
    required double fontSize,
    required AppFontWeight weight,
    Color? color,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: _decodeFontWeight(weight),
    );
  }

  static FontWeight _decodeFontWeight(AppFontWeight weight) {
    return switch (weight) {
      AppFontWeight.light => FontWeight.w300,
      AppFontWeight.regular => FontWeight.w400,
      AppFontWeight.medium => FontWeight.w500,
      AppFontWeight.semibold => FontWeight.w600,
      AppFontWeight.bold => FontWeight.w700,
    };
  }
}
