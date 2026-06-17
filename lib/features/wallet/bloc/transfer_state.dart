part of 'transfer_cubit.dart';

class TransferState extends Equatable {
  const TransferState({
    this.status = const IdleStatus(),
    this.recipient = '',
    this.amount = '',
    this.note = '',
    this.newBalance,
    this.errorType,
    this.errorMessage,
  });

  final String recipient;
  final String amount;
  final String note;

  final LoadingStatus status;
  final PointsBalance? newBalance;
  final String? errorType;
  final String? errorMessage;

  int get amountValue => int.tryParse(amount) ?? 0;

  TransferState copyWith({
    LoadingStatus? status,
    String? recipient,
    String? amount,
    String? note,
    PointsBalance? newBalance,
    String? errorType,
    String? errorMessage,
  }) => TransferState(
    status: status ?? this.status,
    recipient: recipient ?? this.recipient,
    amount: amount ?? this.amount,
    note: note ?? this.note,
    newBalance: newBalance ?? this.newBalance,
    errorType: errorType ?? this.errorType,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    status,
    recipient,
    amount,
    note,
    newBalance,
    errorType,
    errorMessage,
  ];
}
