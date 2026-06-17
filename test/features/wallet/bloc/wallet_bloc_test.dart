import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_plus/core/errors/failures.dart';
import 'package:shop_plus/core/models/loading_status.dart';
import 'package:shop_plus/features/wallet/bloc/wallet_bloc.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';

import '../../../helpers/wallet_test_helpers.dart';

void main() {
  late MockWalletRepo repo;
  final balance = buildBalance();
  final counts = buildCounts();

  setUpAll(registerWalletFallbacks);
  setUp(() => repo = MockWalletRepo());

  test('initial state is an idle WalletState', () {
    final bloc = WalletBloc(repo);
    expect(bloc.state, const WalletState());
    expect(bloc.state.status.isIdle, isTrue);
    addTearDown(bloc.close);
  });

  group('LoadBalance', () {
    blocTest<WalletBloc, WalletState>(
      'emits [InProgress, Success(balance)]',
      build: () {
        when(() => repo.getBalance()).thenAnswer((_) async => Right(balance));
        when(
          () => repo.getTransactionCounts(),
        ).thenAnswer((_) async => Right(counts));
        return WalletBloc(repo);
      },
      act: (b) => b.add(const LoadBalance()),
      expect: () => [
        const WalletState().copyWith(
          status: const InProgressStatus(),
          clearBalance: true,
        ),
        const WalletState().copyWith(
          status: const SuccessStatus(),
          balance: balance,
          counts: counts,
        ),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'emits [InProgress, Failed] when repository fails',
      build: () {
        when(
          () => repo.getBalance(),
        ).thenAnswer((_) async => Left(RegularFailure('boom')));
        when(
          () => repo.getTransactionCounts(),
        ).thenAnswer((_) async => Right(counts));
        return WalletBloc(repo);
      },
      act: (b) => b.add(const LoadBalance()),
      expect: () => [
        const WalletState().copyWith(
          status: const InProgressStatus(),
          clearBalance: true,
        ),
        const WalletState().copyWith(
          status: const FailedStatus(error: 'boom'),
          errorMessage: 'boom',
        ),
      ],
    );
  });

  group('LoadTransactions', () {
    final txns = [buildTransaction(id: 'a', type: TransactionType.earn)];

    blocTest<WalletBloc, WalletState>(
      'clears list then emits Success with the page',
      build: () {
        when(
          () => repo.getTransactions(
            filter: any(named: 'filter'),
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
          ),
        ).thenAnswer((_) async => Right(buildPage(txns, hasMore: false)));
        return WalletBloc(repo);
      },
      act: (b) => b.add(const LoadTransactions(TransactionFilter.all)),
      expect: () => [
        const WalletState().copyWith(status: const InProgressStatus()),
        const WalletState().copyWith(
          status: const SuccessStatus(),
          transactions: txns,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<WalletBloc, WalletState>(
      'emits Failed when repository throws',
      build: () {
        when(
          () => repo.getTransactions(
            filter: any(named: 'filter'),
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
          ),
        ).thenAnswer((_) async => Left(RegularFailure('net')));
        return WalletBloc(repo);
      },
      act: (b) => b.add(const LoadTransactions(TransactionFilter.all)),
      expect: () => [
        const WalletState().copyWith(status: const InProgressStatus()),
        const WalletState().copyWith(
          status: const FailedStatus(error: 'net'),
          errorMessage: 'net',
        ),
      ],
    );
  });

  test('filtering returns the subset and switching back to all restores '
      'the full data', () async {
    final earnTxns = [buildTransaction(id: 'e', type: TransactionType.earn)];
    final allTxns = [
      buildTransaction(id: 'e', type: TransactionType.earn),
      buildTransaction(id: 'r', type: TransactionType.redeem),
    ];
    when(
      () => repo.getTransactions(
        filter: any(named: 'filter'),
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer((inv) async {
      final f = inv.namedArguments[#filter] as TransactionFilter;
      return Right(
        buildPage(f == TransactionFilter.earn ? earnTxns : allTxns),
      );
    });
    final bloc = WalletBloc(repo);
    addTearDown(bloc.close);

    bloc.add(const LoadTransactions(TransactionFilter.earn));
    await bloc.stream.firstWhere(
      (s) => s.status.isSuccess && s.filter == TransactionFilter.earn,
    );
    expect(bloc.state.transactions, earnTxns);

    bloc.add(const LoadTransactions(TransactionFilter.all));
    await bloc.stream.firstWhere(
      (s) => s.status.isSuccess && s.filter == TransactionFilter.all,
    );
    expect(bloc.state.transactions, allTxns);
  });

  test('refresh re-requests balance and transactions', () async {
    when(() => repo.getBalance()).thenAnswer((_) async => Right(balance));
    when(
      () => repo.getTransactionCounts(),
    ).thenAnswer((_) async => Right(counts));
    when(
      () => repo.getTransactions(
        filter: any(named: 'filter'),
        page: any(named: 'page'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer(
      (_) async => Right(buildPage([buildTransaction()], hasMore: false)),
    );
    final bloc = WalletBloc(repo);
    addTearDown(bloc.close);

    bloc.add(const LoadBalance());
    bloc.add(const LoadTransactions(TransactionFilter.all));
    await bloc.stream.firstWhere(
      (s) => s.status.isSuccess && s.balance != null,
    );

    bloc.add(const LoadBalance());
    bloc.add(const LoadTransactions(TransactionFilter.all));
    await bloc.stream.firstWhere((s) => s.status.isSuccess);

    verify(() => repo.getBalance()).called(2);
    verify(
      () => repo.getTransactions(
        filter: TransactionFilter.all,
        page: 1,
        pageSize: any(named: 'pageSize'),
      ),
    ).called(2);
  });

  blocTest<WalletBloc, WalletState>(
    'LoadMoreTransactions appends the next page and sets hasReachedMax',
    build: () {
      when(
        () => repo.getTransactions(
          filter: any(named: 'filter'),
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer(
        (_) async =>
            Right(buildPage([buildTransaction(id: 't2')], hasMore: false)),
      );
      return WalletBloc(repo);
    },
    seed: () => const WalletState().copyWith(
      status: const SuccessStatus(),
      transactions: [],
      page: 1,
      hasReachedMax: false,
    ).copyWith(transactions: [buildTransaction(id: 't1')]),
    act: (b) => b.add(const LoadMoreTransactions()),
    expect: () => [
      const WalletState().copyWith(
        status: const SuccessStatus(),
        page: 2,
        hasReachedMax: true,
        transactions: [
          buildTransaction(id: 't1'),
          buildTransaction(id: 't2'),
        ],
      ),
    ],
  );
}
