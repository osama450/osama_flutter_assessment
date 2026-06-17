part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class LoadBalance extends WalletEvent {
  const LoadBalance();
}

class LoadTransactions extends WalletEvent {
  const LoadTransactions(this.filter);

  final TransactionFilter filter;

  @override
  List<Object?> get props => [filter];
}

class LoadMoreTransactions extends WalletEvent {
  const LoadMoreTransactions();
}
