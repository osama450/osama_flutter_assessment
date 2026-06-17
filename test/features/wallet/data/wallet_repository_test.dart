import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_plus/core/errors/failures.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';
import 'package:shop_plus/features/wallet/data/models/transactions_page.dart';
import 'package:shop_plus/features/wallet/data/repositories/wallet_repository.dart';

void main() {
  late MockWalletRepository repository;

  setUp(() => repository = MockWalletRepository());

  group('getBalance', () {
    test('returns the points balance', () async {
      final result = await repository.getBalance();

      expect(result.isRight(), isTrue);
      final balance = result.getOrElse(() => throw Exception());
      expect(balance, isA<PointsBalance>());
      expect(balance.totalPoints, 15750);
    });
  });

  group('getTransactions pagination', () {
    test('first page returns 10 items with hasMore', () async {
      final result = await repository.getTransactions(page: 1, pageSize: 10);

      final page = result.getOrElse(() => throw Exception());
      expect(page.items.length, 10);
      expect(page.page, 1);
      expect(page.totalCount, 30);
      expect(page.hasMore, isTrue);
    });

    test('last page has no more, beyond-range page is empty', () async {
      final last = (await repository.getTransactions(page: 3, pageSize: 10))
          .getOrElse(() => throw Exception());
      expect(last.items.length, 10);
      expect(last.hasMore, isFalse);

      final beyond = (await repository.getTransactions(page: 4, pageSize: 10))
          .getOrElse(() => throw Exception());
      expect(beyond.items, isEmpty);
    });
  });

  group('getTransactions filtering', () {
    test('filter earn returns only earn transactions', () async {
      final page = (await repository.getTransactions(
        filter: TransactionFilter.earn,
      )).getOrElse(() => throw Exception());

      expect(page.totalCount, 6);
      expect(
        page.items.every((t) => t.type == TransactionType.earn),
        isTrue,
      );
    });

    test('filter transfer groups TRANSFER_IN + TRANSFER_OUT', () async {
      final page = (await repository.getTransactions(
        filter: TransactionFilter.transfer,
        pageSize: 100,
      )).getOrElse(() => throw Exception());

      expect(page.totalCount, 12);
      expect(
        page.items.every(
          (t) =>
              t.type == TransactionType.transferIn ||
              t.type == TransactionType.transferOut,
        ),
        isTrue,
      );
    });
  });

  group('transferPoints', () {
    test('success returns the updated balance', () async {
      final result = await repository.transferPoints(
        recipient: '+201234567890',
        amount: 1000,
      );

      expect(result.isRight(), isTrue);
      final balance = result.getOrElse(() => throw Exception());
      expect(balance.totalPoints, 15750 - 1000);
    });

    test('insufficient balance returns INSUFFICIENT_BALANCE failure', () async {
      final result = await repository.transferPoints(
        recipient: '+201234567890',
        amount: 999999,
      );

      expect(result.isLeft(), isTrue);
      final failure = result.swap().getOrElse(() => throw Exception());
      expect(failure, isA<Failure>());
      expect(failure.errType, 'INSUFFICIENT_BALANCE');
    });

    test('unknown recipient returns RECIPIENT_NOT_FOUND failure', () async {
      final result = await repository.transferPoints(
        recipient: '+20000000000',
        amount: 100,
      );

      expect(result.isLeft(), isTrue);
      final failure = result.swap().getOrElse(() => throw Exception());
      expect(failure.errType, 'RECIPIENT_NOT_FOUND');
    });
  });
}
