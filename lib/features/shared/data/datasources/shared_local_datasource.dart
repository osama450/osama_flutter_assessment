import 'package:shop_plus/core/di/injection_container.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_plus/core/utils/database_manager.dart';

/// this class is responsible for saving and getting the language code
abstract interface class SharedLocalDatasource {
  /// saves the language code in the database
  Future<bool> changeLang({required String langCode});

  /// get the saved language code
  Future<String> getSavedLang();
}

/// this class is responsible for saving and getting the language code
/// it implements [SharedLocalDatasource]
@LazySingleton(as: SharedLocalDatasource)
class SharedLocalDatasourceImpl implements SharedLocalDatasource {
  /// Constructor
  SharedLocalDatasourceImpl();

  @override
  Future<bool> changeLang({required String langCode}) async {
    try {
      getIt<DatabaseManager>().setLanguage(langCode);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getSavedLang() async {
    return getIt<DatabaseManager>().getLanguage();
  }
}
