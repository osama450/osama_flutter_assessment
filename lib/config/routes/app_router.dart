import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_plus/core/di/injection_container.dart';
import 'package:shop_plus/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:shop_plus/features/wallet/bloc/transfer_cubit.dart';
import 'package:shop_plus/features/wallet/presentation/screens/transfer_points_screen.dart';

import 'app_router_observer.dart';

abstract class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final navigatorObserver = AppRouterObserver();

  /// route paths
  static const String wallet = '/wallet';
  static const String transfer = '/transfer';

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    observers: [navigatorObserver],
    initialLocation: wallet,
    routes: [
      GoRoute(
        path: wallet,
        name: 'wallet',
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: transfer,
        name: 'transfer',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<TransferCubit>(),
          child: const TransferPointsScreen(),
        ),
      ),
    ],
  );
}
