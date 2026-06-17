import 'package:equatable/equatable.dart';

sealed class LoadingStatus extends Equatable {
  const LoadingStatus();

  bool get isIdle => this is IdleStatus;
  bool get isInProgress => this is InProgressStatus;
  bool get isSuccess => this is SuccessStatus;
  bool get isFailed => this is FailedStatus;

  @override
  List<Object?> get props => const [];
}

class IdleStatus extends LoadingStatus {
  const IdleStatus();
}

class InProgressStatus extends LoadingStatus {
  const InProgressStatus();
}

class SuccessStatus extends LoadingStatus {
  const SuccessStatus();
}

class FailedStatus extends LoadingStatus {
  final dynamic error;

  const FailedStatus({this.error});

  @override
  List<Object?> get props => [error];
}
