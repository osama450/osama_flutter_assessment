// ignore: depend_on_referenced_packages
import 'package:shop_plus/core/utils/app_strings.dart';
import 'package:intl/intl.dart';

/// this class is used to manage the locale
class LocaleHelper {
  /// checks if the current locale is arabic
  static bool get isArabic => Intl.getCurrentLocale() == Language.ar.name;
}
