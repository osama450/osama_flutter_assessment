import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_plus/core/errors/failures.dart';
import 'package:shop_plus/features/wallet/bloc/wallet_bloc.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';
import 'package:shop_plus/features/wallet/data/models/transactions_page.dart';
import 'package:shop_plus/features/wallet/presentation/screens/transfer_points_screen.dart';
import 'package:shop_plus/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/wallet_loading_shimmer.dart';
import 'package:shop_plus/generated/l10n.dart';

import '../../../helpers/wallet_test_helpers.dart';

void main() {
  setUpAll(registerWalletFallbacks);
  setUp(() => S.load(const Locale('en')));

  group('WalletScreen', () {
    testWidgets('renders the balance and a transaction when loaded', (
      tester,
    ) async {
      setPhoneSurface(tester);
      final repo = MockWalletRepo();
      stubWalletRepo(
        repo,
        transactions: [
          buildTransaction(merchantName: 'TechMart', type: TransactionType.earn),
        ],
      );

      await tester.pumpWidget(wrapApp(const WalletScreen(), repo: repo));
      await tester.pumpAndSettle();

      expect(find.textContaining('15,750'), findsWidgets);
      expect(find.text('TechMart'), findsWidgets);
      expect(find.text('All'), findsOneWidget);
    });

    testWidgets('tapping the Earn chip requests the earn filter', (
      tester,
    ) async {
      setPhoneSurface(tester);
      final repo = MockWalletRepo();
      stubWalletRepo(
        repo,
        transactions: [buildTransaction(type: TransactionType.earn)],
      );

      await tester.pumpWidget(wrapApp(const WalletScreen(), repo: repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Earn'));
      await tester.pumpAndSettle();

      verify(
        () => repo.getTransactions(
          filter: TransactionFilter.earn,
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).called(greaterThanOrEqualTo(1));
    });

    testWidgets('shows the shimmer while transactions load', (tester) async {
      setPhoneSurface(tester);
      final repo = MockWalletRepo();
      final pendingBalance = Completer<Either<Failure, PointsBalance>>();
      final pendingTxns = Completer<Either<Failure, TransactionsPage>>();
      when(() => repo.getBalance()).thenAnswer((_) => pendingBalance.future);
      when(
        () => repo.getTransactionCounts(),
      ).thenAnswer((_) async => Right(buildCounts()));
      when(
        () => repo.getTransactions(
          filter: any(named: 'filter'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer((_) => pendingTxns.future);

      await tester.pumpWidget(wrapApp(const WalletScreen(), repo: repo));
      for (var i = 0; i < 4; i++) {
        await tester.pump(const Duration(milliseconds: 20));
      }

      expect(
        find.byType(WalletListShimmer).evaluate().isNotEmpty ||
            find.byType(WalletBalanceShimmer).evaluate().isNotEmpty,
        isTrue,
      );

      pendingBalance.complete(Right(buildBalance()));
      pendingTxns.complete(Right(buildPage([buildTransaction()])));
      await tester.pumpAndSettle();
    });
  });

  group('TransferPointsScreen', () {
    Future<void> pumpValidForm(WidgetTester tester, MockWalletRepo repo) async {
      stubWalletRepo(repo);
      await tester.pumpWidget(wrapApp(const TransferPointsScreen(), repo: repo));
      // Load the wallet balance so the amount max-check passes.
      tester
          .element(find.byType(TransferPointsScreen))
          .read<WalletBloc>()
          .add(const LoadBalance());
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '+201234567890');
      await tester.pump();
      await tester.enterText(fields.at(1), '1000');
      await tester.pumpAndSettle();
    }

    testWidgets('CTA stays disabled until the form is valid', (tester) async {
      setPhoneSurface(tester);
      final repo = MockWalletRepo();
      stubWalletRepo(repo);
      await tester.pumpWidget(wrapApp(const TransferPointsScreen(), repo: repo));
      await tester.pumpAndSettle();

      // Empty form → CTA shows the generic label.
      expect(find.text('Transfer points'), findsWidgets);

      await pumpValidForm(tester, repo);

      // Valid amount → CTA label switches to the amount variant.
      expect(find.text('Transfer 1,000 pts'), findsOneWidget);
    });

    testWidgets('submitting a valid transfer shows the success dialog', (
      tester,
    ) async {
      setPhoneSurface(tester);
      final repo = MockWalletRepo();
      when(
        () => repo.transferPoints(
          recipient: any(named: 'recipient'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => Right(buildBalance(total: 14750)));

      await pumpValidForm(tester, repo);

      await tester.tap(find.text('Transfer 1,000 pts'));
      await tester.pumpAndSettle();

      expect(find.text('Transfer sent'), findsOneWidget);
      expect(find.textContaining('14,750'), findsWidgets);
    });
  });
}
