part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  const WalletState({
    this.status = const IdleStatus(),
    this.balance,
    this.transactions = const [],
    this.filter = TransactionFilter.all,
    this.page = 1,
    this.hasReachedMax = false,
    this.errorMessage,
    this.counts = const {},
  });

  final LoadingStatus status;
  final PointsBalance? balance;
  final List<Transaction> transactions;
  final TransactionFilter filter;
  final int page;
  final bool hasReachedMax;
  final String? errorMessage;
  final Map<TransactionFilter, int> counts;

  WalletState copyWith({
    LoadingStatus? status,
    PointsBalance? balance,
    List<Transaction>? transactions,
    TransactionFilter? filter,
    int? page,
    bool? hasReachedMax,
    String? errorMessage,
    Map<TransactionFilter, int>? counts,
    bool clearBalance = false,
  }) => WalletState(
    status: status ?? this.status,
    balance: clearBalance ? null : (balance ?? this.balance),
    transactions: transactions ?? this.transactions,
    filter: filter ?? this.filter,
    page: page ?? this.page,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    errorMessage: errorMessage ?? this.errorMessage,
    counts: counts ?? this.counts,
  );

  @override
  List<Object?> get props => [
    status,
    balance,
    transactions,
    filter,
    page,
    hasReachedMax,
    errorMessage,
    counts,
  ];
}
