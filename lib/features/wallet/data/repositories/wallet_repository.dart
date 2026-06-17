import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_plus/core/errors/failures.dart';

import '../datasources/wallet_fake_data.dart';
import '../models/points_balance.dart';
import '../models/transaction.dart';
import '../models/transaction_type.dart';
import '../models/transactions_page.dart';

abstract interface class WalletRepository {
  Future<Either<Failure, PointsBalance>> getBalance();

  Future<Either<Failure, TransactionsPage>> getTransactions({
    TransactionFilter filter = TransactionFilter.all,
    int page = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, Map<TransactionFilter, int>>> getTransactionCounts();

  Future<Either<Failure, PointsBalance>> transferPoints({
    required String recipient,
    required int amount,
    String? note,
  });
}

@LazySingleton(as: WalletRepository)
class MockWalletRepository implements WalletRepository {
  final Random _random = Random();

  PointsBalance _balance = WalletFakeData.balance;

  @override
  Future<Either<Failure, PointsBalance>> getBalance() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      return Right(_balance);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, TransactionsPage>> getTransactions({
    TransactionFilter filter = TransactionFilter.all,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      await Future<void>.delayed(
        Duration(milliseconds: 600 + _random.nextInt(600)),
      );

      final List<Transaction> filtered = filter == TransactionFilter.all
          ? WalletFakeData.transactions
          : WalletFakeData.transactions
                .where((t) => filter.matches(t.type))
                .toList();

      final start = (page - 1) * pageSize;
      final end = min(start + pageSize, filtered.length);
      final List<Transaction> items = start >= filtered.length
          ? const []
          : filtered.sublist(start, end);

      return Right(
        TransactionsPage(
          items: items,
          page: page,
          pageSize: pageSize,
          totalCount: filtered.length,
          hasMore: end < filtered.length,
        ),
      );
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, Map<TransactionFilter, int>>>
  getTransactionCounts() async {
    try {
      final txns = WalletFakeData.transactions;
      final counts = <TransactionFilter, int>{
        for (final f in TransactionFilter.values)
          f: txns.where((t) => f.matches(t.type)).length,
      };
      return Right(counts);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, PointsBalance>> transferPoints({
    required String recipient,
    required int amount,
    String? note,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 900));

      final r = recipient.trim().toLowerCase();
      if (r == '+20000000000' || r.contains('notfound')) {
        return Left(Failure('Recipient not found', 'RECIPIENT_NOT_FOUND'));
      }

      if (amount > _balance.totalPoints) {
        return Left(Failure('Insufficient balance', 'INSUFFICIENT_BALANCE'));
      }

      _balance = _balance.copyWith(
        totalPoints: _balance.totalPoints - amount,
        lastUpdated: DateTime.now(),
      );
      return Right(_balance);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }
}
