import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/config/themes/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme({required String lang}) {
    const appTheme = AppThemeExtension.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      surface: appTheme.card,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: lang == 'ar' ? 'Zain' : 'Rubik',
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      hintColor: appTheme.subink,
      disabledColor: AppColors.appGray,
      dividerColor: appTheme.hair,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      shadowColor: Colors.transparent,
      scaffoldBackgroundColor: appTheme.paper,
      brightness: Brightness.light,
      extensions: const <ThemeExtension<dynamic>>[AppThemeExtension.light],
      appBarTheme: AppBarTheme(
        backgroundColor: appTheme.paper,
        foregroundColor: appTheme.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.appGray.shade200,
        selectionHandleColor: appTheme.ink,
        cursorColor: appTheme.ink,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        focusColor: AppColors.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appTheme.card,
        surfaceTintColor: Colors.transparent,
      ),
      cardColor: appTheme.card,
      dividerTheme: DividerThemeData(color: appTheme.hair),
      inputDecorationTheme: InputDecorationTheme(
        helperStyle: AppTypography.textSM(color: appTheme.ink),
        filled: true,
        hintStyle: AppTypography.textSM(color: appTheme.subink),
        fillColor: appTheme.card,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appTheme.hair),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appTheme.hair),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorStyle: AppTypography.textSM(color: AppColors.error),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
