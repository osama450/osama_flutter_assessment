import 'package:shop_plus/config/themes/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

extension ThemeContextX on BuildContext {
  AppThemeExtension get appTheme {
    return Theme.of(this).extension<AppThemeExtension>()!;
  }
}
