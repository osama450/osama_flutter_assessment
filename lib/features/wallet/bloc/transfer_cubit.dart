import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_plus/core/models/loading_status.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/features/wallet/data/repositories/wallet_repository.dart';

part 'transfer_state.dart';

@injectable
class TransferCubit extends Cubit<TransferState> {
  TransferCubit(this._repository) : super(const TransferState());

  final WalletRepository _repository;

  void recipientChanged(String value) =>
      emit(state.copyWith(recipient: value, status: const IdleStatus()));

  void amountChanged(String value) =>
      emit(state.copyWith(amount: value, status: const IdleStatus()));

  void noteChanged(String value) =>
      emit(state.copyWith(note: value, status: const IdleStatus()));

  Future<void> submit() async {
    emit(state.copyWith(status: const InProgressStatus()));
    final result = await _repository.transferPoints(
      recipient: state.recipient.trim(),
      amount: state.amountValue,
      note: state.note.trim().isEmpty ? null : state.note.trim(),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FailedStatus(error: failure.errMessage),
          errorType: failure.errType,
          errorMessage: failure.errMessage,
        ),
      ),
      (newBalance) => emit(
        state.copyWith(status: const SuccessStatus(), newBalance: newBalance),
      ),
    );
  }
}
