import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_plus/core/errors/failures.dart';
import 'package:shop_plus/core/models/loading_status.dart';
import 'package:shop_plus/features/wallet/bloc/transfer_cubit.dart';

import '../../../helpers/wallet_test_helpers.dart';

void main() {
  late MockWalletRepo repo;
  final newBalance = buildBalance(total: 14750);

  setUpAll(registerWalletFallbacks);
  setUp(() => repo = MockWalletRepo());

  const seed = TransferState(recipient: '+201234567890', amount: '1000');

  test('initial state is an idle TransferState', () {
    final cubit = TransferCubit(repo);
    expect(cubit.state, const TransferState());
    expect(cubit.state.status.isIdle, isTrue);
    addTearDown(cubit.close);
  });

  blocTest<TransferCubit, TransferState>(
    'recipientChanged updates recipient and resets status to idle',
    build: () => TransferCubit(repo),
    act: (c) => c.recipientChanged('hello@mail.com'),
    expect: () => [
      const TransferState(recipient: 'hello@mail.com'),
    ],
  );

  blocTest<TransferCubit, TransferState>(
    'submit success emits [InProgress, Success(newBalance)]',
    build: () {
      when(
        () => repo.transferPoints(
          recipient: any(named: 'recipient'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => Right(newBalance));
      return TransferCubit(repo);
    },
    seed: () => seed,
    act: (c) => c.submit(),
    expect: () => [
      seed.copyWith(status: const InProgressStatus()),
      seed.copyWith(status: const SuccessStatus(), newBalance: newBalance),
    ],
  );

  blocTest<TransferCubit, TransferState>(
    'submit emits Failed with INSUFFICIENT_BALANCE',
    build: () {
      when(
        () => repo.transferPoints(
          recipient: any(named: 'recipient'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
        ),
      ).thenAnswer(
        (_) async =>
            Left(Failure('Insufficient balance', 'INSUFFICIENT_BALANCE')),
      );
      return TransferCubit(repo);
    },
    seed: () => seed,
    act: (c) => c.submit(),
    expect: () => [
      seed.copyWith(status: const InProgressStatus()),
      seed.copyWith(
        status: const FailedStatus(error: 'Insufficient balance'),
        errorType: 'INSUFFICIENT_BALANCE',
        errorMessage: 'Insufficient balance',
      ),
    ],
  );

  blocTest<TransferCubit, TransferState>(
    'submit emits Failed with RECIPIENT_NOT_FOUND',
    build: () {
      when(
        () => repo.transferPoints(
          recipient: any(named: 'recipient'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
        ),
      ).thenAnswer(
        (_) async => Left(Failure('Recipient not found', 'RECIPIENT_NOT_FOUND')),
      );
      return TransferCubit(repo);
    },
    seed: () => seed,
    act: (c) => c.submit(),
    expect: () => [
      seed.copyWith(status: const InProgressStatus()),
      seed.copyWith(
        status: const FailedStatus(error: 'Recipient not found'),
        errorType: 'RECIPIENT_NOT_FOUND',
        errorMessage: 'Recipient not found',
      ),
    ],
  );
}
