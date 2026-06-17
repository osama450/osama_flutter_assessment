import 'dart:io';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_plus/core/utils/app_strings.dart';

enum DataBoxes { settings }

/// this class is used to manage the local database
@lazySingleton
class DatabaseManager {
  /// Documents directory for saving our database
  static Directory? documentsDirectory;

  /// Initialize [Hive]
  static Future<dynamic> initHive() async {
    await Hive.initFlutter();
    await Future.wait([Hive.openBox<dynamic>(DataBoxes.settings.name)]);
  }

  /// set the preferred language code in the database
  void setLanguage(String languageCode) {
    Hive.box<dynamic>(DataBoxes.settings.name).put('language', languageCode);
  }

  /// get the preferred language code from the database
  Future<String> getLanguage() async {
    final box = Hive.box<dynamic>(DataBoxes.settings.name);
    final langCode = box.get('language');
    return Future.value(
      (langCode as String?) == null ? Language.en.name : langCode,
    );
  }

  /// this method is used for debugging only
  /// it will clear all the data in the database
  static Future<void> clearData() async {
    await Hive.box<dynamic>(DataBoxes.settings.name).clear();
  }
}
