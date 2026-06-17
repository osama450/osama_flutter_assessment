import 'dart:ui' as ui;

import 'package:shop_plus/core/utils/app_strings.dart';
import 'package:intl/intl.dart';

/// Language Helper class to get and set language
class LanguageHelper {
  static bool get isArabic => Intl.getCurrentLocale() == Language.en.name;

  /// language is a static variable that is used to get the language
  static String language = ui.PlatformDispatcher.instance.locale.languageCode;

  /// Available languages list for the app
  static List<AvailableLangModel> availableLanguages = [
    AvailableLangModel(langCode: Language.en.name, countryFlagCode: 'us'),
    AvailableLangModel(langCode: Language.ar.name, countryFlagCode: 'sa'),
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
