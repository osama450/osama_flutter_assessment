import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/loading_status.dart';
import '../data/models/points_balance.dart';
import '../data/models/transaction.dart';
import '../data/models/transaction_type.dart';
import '../data/repositories/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

@lazySingleton
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc(this._repository) : super(const WalletState()) {
    on<LoadBalance>(_onLoadBalance);
    on<LoadTransactions>(_onLoadTransactions, transformer: restartable());
    on<LoadMoreTransactions>(_onLoadMoreTransactions, transformer: droppable());
  }

  final WalletRepository _repository;

  Future<void> _onLoadBalance(
    LoadBalance event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(status: const InProgressStatus(), clearBalance: true));
    final result = await _repository.getBalance();
    final countsResult = await _repository.getTransactionCounts();
    final counts = countsResult.fold((_) => state.counts, (c) => c);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FailedStatus(error: failure.errMessage),
          errorMessage: failure.errMessage,
        ),
      ),
      (balance) => emit(
        state.copyWith(
          status: const SuccessStatus(),
          balance: balance,
          counts: counts,
        ),
      ),
    );
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<WalletState> emit,
  ) async {
    emit(
      state.copyWith(
        status: const InProgressStatus(),
        filter: event.filter,
        transactions: const [],
        page: 1,
        hasReachedMax: false,
      ),
    );
    final result = await _repository.getTransactions(
      filter: event.filter,
      page: 1,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FailedStatus(error: failure.errMessage),
          errorMessage: failure.errMessage,
        ),
      ),
      (pageData) => emit(
        state.copyWith(
          status: const SuccessStatus(),
          page: 1,
          filter: event.filter,
          transactions: pageData.items,
          hasReachedMax: !pageData.hasMore,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreTransactions(
    LoadMoreTransactions event,
    Emitter<WalletState> emit,
  ) async {
    if (state.hasReachedMax) return;
    final nextPage = state.page + 1;
    final result = await _repository.getTransactions(
      filter: state.filter,
      page: nextPage,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FailedStatus(error: failure.errMessage),
          errorMessage: failure.errMessage,
        ),
      ),
      (pageData) => emit(
        state.copyWith(
          status: const SuccessStatus(),
          page: nextPage,
          transactions: [...state.transactions, ...pageData.items],
          hasReachedMax: !pageData.hasMore,
        ),
      ),
    );
  }
}
