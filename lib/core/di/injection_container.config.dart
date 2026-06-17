// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/shared/cubit/shared_cubit.dart' as _i483;
import '../../features/shared/data/datasources/shared_local_datasource.dart'
    as _i908;
import '../../features/shared/data/repositories/shared_repo_impl.dart' as _i217;
import '../../features/wallet/bloc/transfer_cubit.dart' as _i938;
import '../../features/wallet/bloc/wallet_bloc.dart' as _i530;
import '../../features/wallet/data/repositories/wallet_repository.dart'
    as _i1038;
import '../network/dio_helper.dart' as _i172;
import '../network/token_storage.dart' as _i964;
import '../utils/database_manager.dart' as _i958;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final secureStorageModule = _$SecureStorageModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.secureStorage,
    );
    gh.lazySingleton<_i958.DatabaseManager>(() => _i958.DatabaseManager());
    gh.lazySingleton<_i908.SharedLocalDatasource>(
      () => _i908.SharedLocalDatasourceImpl(),
    );
    gh.lazySingleton<_i1038.WalletRepository>(
      () => _i1038.MockWalletRepository(),
    );
    gh.lazySingleton<_i964.TokenStorage>(
      () => _i964.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i217.SharedRepoImpl>(
      () => _i217.SharedRepoImpl(
        sharedLocalDataSource: gh<_i908.SharedLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i530.WalletBloc>(
      () => _i530.WalletBloc(gh<_i1038.WalletRepository>()),
    );
    gh.factory<_i938.TransferCubit>(
      () => _i938.TransferCubit(gh<_i1038.WalletRepository>()),
    );
    gh.lazySingleton<_i172.DioHelper>(
      () => _i172.DioHelper(gh<_i964.TokenStorage>()),
    );
    gh.lazySingleton<_i483.SharedCubit>(
      () => _i483.SharedCubit(gh<_i217.SharedRepoImpl>()),
    );
    return this;
  }
}

class _$SecureStorageModule extends _i964.SecureStorageModule {}
