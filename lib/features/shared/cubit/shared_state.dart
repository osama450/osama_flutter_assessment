part of 'shared_cubit.dart';

sealed class SharedState {}

class SharedInitial extends SharedState {}

class SharedLoading extends SharedState {}

class GetSettingsState extends SharedState {}

class SharedGetLocaleState extends SharedState {}

class ChangeLocaleState extends SharedState {}

class SharedError extends SharedState {
  final String message;

  SharedError(this.message);
}
