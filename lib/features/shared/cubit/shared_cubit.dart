import 'dart:async';

import 'package:shop_plus/core/language_helper.dart';
import 'package:shop_plus/core/utils/app_strings.dart';
import 'package:shop_plus/features/shared/data/repositories/shared_repo_impl.dart';
import 'package:shop_plus/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'shared_state.dart';

@lazySingleton
class SharedCubit extends Cubit<SharedState> {
  SharedCubit(this._sharedRepoImpl) : super(SharedInitial());

  final SharedRepoImpl _sharedRepoImpl;

  /// the current language code
  String currentLangCode = Language.en.name;

  bool get isArabic => currentLangCode == Language.en.name;

  Future<void> getSavedLang() async {
    final response = await _sharedRepoImpl.getSavedLang();
    response.fold((failure) => currentLangCode = LanguageHelper.language, (
      value,
    ) {
      currentLangCode = value;
      emit(SharedGetLocaleState());
    });
  }

  Future<void> changeLang({Locale? locale}) async {
    const enLocale = Locale('en');
    const arLocale = Locale('ar');
    final Locale language;

    if (locale != null) {
      language = locale;
    } else {
      if (currentLangCode != enLocale.languageCode) {
        language = enLocale;
      } else {
        language = arLocale;
      }
    }

    final response = await _sharedRepoImpl.changeLang(
      langCode: language.languageCode,
    );
    response.fold((failure) => currentLangCode = LanguageHelper.language, (
      value,
    ) {
      currentLangCode = language.languageCode;
      S.load(language);
      emit(ChangeLocaleState());
    });
  }
}
