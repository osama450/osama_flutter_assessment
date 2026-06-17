import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:responsive_wrapper/responsive_wrapper.dart';
import 'package:shop_plus/config/themes/app_theme.dart';
import 'package:shop_plus/features/shared/cubit/shared_cubit.dart';
import 'package:shop_plus/features/wallet/bloc/transfer_cubit.dart';
import 'package:shop_plus/features/wallet/bloc/wallet_bloc.dart';
import 'package:shop_plus/features/wallet/data/models/merchant_balance.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';
import 'package:shop_plus/features/wallet/data/models/transactions_page.dart';
import 'package:shop_plus/features/wallet/data/repositories/wallet_repository.dart';
import 'package:shop_plus/generated/l10n.dart';

class MockWalletRepo extends Mock implements WalletRepository {}

class MockSharedCubit extends MockCubit<SharedState> implements SharedCubit {}

void registerWalletFallbacks() {
  registerFallbackValue(TransactionFilter.all);
}

/// Pin a phone-sized surface so the wallet renders its single-column layout
/// (avoids two-pane overflow in the default 800x600 test viewport).
void setPhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(590, 1000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

PointsBalance buildBalance({int total = 15750}) => PointsBalance(
  totalPoints: total,
  pendingPoints: 500,
  expiringPoints: 1200,
  expiringDate: DateTime(2026, 1, 1),
  lastUpdated: DateTime(2026, 1, 1),
  balancesByMerchant: const [
    MerchantBalance(
      merchantId: 'm1',
      merchantName: 'TechMart',
      merchantLogo: '',
      points: 8500,
      tier: 'Gold',
    ),
  ],
);

Transaction buildTransaction({
  String id = 'txn_1',
  TransactionType type = TransactionType.earn,
  int points = 500,
  String description = 'Test transaction',
  String? merchantName = 'TechMart',
}) => Transaction(
  id: id,
  type: type,
  points: points,
  description: description,
  merchantName: merchantName,
  merchantLogo: null,
  createdAt: DateTime(2026, 1, 1, 12),
  status: TransactionStatus.completed,
);

TransactionsPage buildPage(
  List<Transaction> items, {
  bool hasMore = false,
  int page = 1,
}) => TransactionsPage(
  items: items,
  page: page,
  pageSize: 10,
  totalCount: items.length,
  hasMore: hasMore,
);

Map<TransactionFilter, int> buildCounts() => const {
  TransactionFilter.all: 30,
  TransactionFilter.earn: 6,
  TransactionFilter.redeem: 6,
  TransactionFilter.transfer: 12,
};

void stubWalletRepo(
  MockWalletRepo repo, {
  PointsBalance? balance,
  List<Transaction>? transactions,
  bool hasMore = false,
}) {
  when(
    () => repo.getBalance(),
  ).thenAnswer((_) async => Right(balance ?? buildBalance()));
  when(
    () => repo.getTransactionCounts(),
  ).thenAnswer((_) async => Right(buildCounts()));
  when(
    () => repo.getTransactions(
      filter: any(named: 'filter'),
      page: any(named: 'page'),
      pageSize: any(named: 'pageSize'),
    ),
  ).thenAnswer(
    (_) async =>
        Right(buildPage(transactions ?? [buildTransaction()], hasMore: hasMore)),
  );
}

Widget wrapApp(Widget screen, {required WalletRepository repo}) {
  return MaterialApp(
    locale: const Locale('en'),
    theme: AppTheme.theme(lang: 'en'),
    debugShowCheckedModeBanner: false,
    supportedLocales: S.delegate.supportedLocales,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    builder: (context, child) => ResponsiveWrapper(
      useShortestSide: false,
      builder: (context, info) => child!,
    ),
    home: MultiBlocProvider(
      providers: [
        BlocProvider<WalletBloc>(create: (_) => WalletBloc(repo)),
        BlocProvider<TransferCubit>(create: (_) => TransferCubit(repo)),
        BlocProvider<SharedCubit>.value(value: MockSharedCubit()),
      ],
      child: screen,
    ),
  );
}
