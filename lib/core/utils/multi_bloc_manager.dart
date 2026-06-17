import 'package:provider/single_child_widget.dart';
import 'package:shop_plus/core/di/injection_container.dart';
import 'package:shop_plus/features/shared/cubit/shared_cubit.dart';
import 'package:shop_plus/features/wallet/bloc/wallet_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocManager {
  static List<SingleChildWidget> multiBlocProviderList = [
    BlocProvider<SharedCubit>(create: (context) => getIt<SharedCubit>()),
    BlocProvider<WalletBloc>(create: (context) => getIt<WalletBloc>()),
  ];

  static List<SingleChildWidget> get multiBlocListenersList {
    return [
      BlocListener<SharedCubit, SharedState>(listener: (context, state) {}),
    ];
  }
}
