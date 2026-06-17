import 'dart:io';

import 'package:shop_plus/core/utils/app_strings.dart';
import 'package:intl/intl.dart';

/// Language Helper class to get and set language
class LanguageHelper {
  static bool get isArabic => Intl.getCurrentLocale() == Language.ar.name;

  /// language is a static variable that is used to get the language
  static String language = Platform.localeName.split('_').first;

  /// Available languages list for the app
  static List<AvailableLangModel> availableLanguages = [
    AvailableLangModel(langCode: 'ar', countryFlagCode: 'sa'),
    AvailableLangModel(langCode: 'en', countryFlagCode: 'us'),
  ];

  static void setLanguage(String code) {
    language = code;
  }
}

/// AvailableLangModel class to get the available languages
class AvailableLangModel {
  /// constructor
  AvailableLangModel({required this.langCode, required this.countryFlagCode});

  /// language code
  final String langCode;

  /// country flag
  final String countryFlagCode;
}
