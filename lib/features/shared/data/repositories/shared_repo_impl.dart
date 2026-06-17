import 'package:shop_plus/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../datasources/shared_local_datasource.dart';

abstract class SharedRepo {
  Future<Either<Failure, bool>> changeLang({required String langCode});
  Future<Either<Failure, String>> getSavedLang();
}

/// LangRepoImpl is the implementation of [SplashRepo]
@lazySingleton
class SharedRepoImpl implements SharedRepo {
  /// Constructor
  SharedRepoImpl({required this.sharedLocalDataSource});

  /// a [sharedLocalDataSource] object
  final SharedLocalDatasource sharedLocalDataSource;

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged = await sharedLocalDataSource.changeLang(
        langCode: langCode,
      );
      return Right(langIsChanged);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await sharedLocalDataSource.getSavedLang();
      return Right(langCode);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }
}
