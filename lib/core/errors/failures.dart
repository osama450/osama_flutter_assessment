// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:shop_plus/generated/l10n.dart';

/// A class to represent the different types of failures that can occur in the app.
class Failure implements Exception {
  /// Initializes the [Failure] class with the given [errMessage] and [errType].
  Failure(this.errMessage, this.errType);

  /// A factory method to create a [Failure] instance from a dynamic object.
  factory Failure.fromObject(dynamic e) {
    if (e is Exception) {
      return Failure.fromException(e);
    } else {
      return RegularFailure.fromException(Exception(e.toString()));
    }
  }

  /// A factory method to create a [Failure] instance from an [Exception] instance.
  factory Failure.fromException(Exception e) {
    if (e is DioException) {
      return DioFailure.fromDioError(e);
    }

    return RegularFailure.fromException(e);
  }

  /// The error message.
  final String errMessage;

  /// The error type.
  final String errType;

  @override
  String toString() {
    return 'Failure: $errMessage';
  }
}

/// A class to represent the different types of failures that can occur in the app.
class DioFailure extends Failure {
  /// Initializes the [DioFailure] class with the given [errMessage].
  DioFailure(String errMessage) : super(errMessage, 'Dio Exception');

  /// A factory method to create a [DioFailure] instance from a [DioException] instance.
  factory DioFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return DioFailure(S.current.connectionTimeoutWithApiServer);
      case DioExceptionType.sendTimeout:
        return DioFailure(S.current.sendTimeoutWithApiServer);
      case DioExceptionType.receiveTimeout:
        return DioFailure(S.current.receiveTimeoutWithApiServer);
      case DioExceptionType.badCertificate:
        return DioFailure(S.current.badCertificateWithApiServer);
      case DioExceptionType.badResponse:
        return DioFailure.fromResponse(
          e.response?.statusCode,
          e.response?.data,
        );
      case DioExceptionType.cancel:
        return DioFailure(S.current.requestToApiServerWasCanceled);
      case DioExceptionType.connectionError:
        if (e.message!.contains('SocketException')) {
          return DioFailure(S.current.noInternetConnection);
        }
        return DioFailure(S.current.unexpectedErrorPleaseTryAgain);

      case DioExceptionType.unknown:
        return DioFailure(S.current.unknownErrorWithApiServer);
    }
  }

  /// A factory method to create a [DioFailure] instance from a [statusCode] and [response].
  factory DioFailure.fromResponse(int? statusCode, dynamic response) {
    if ([400, 401, 403, 422, 404].contains(statusCode)) {
      final responseMap = response as Map<String, dynamic>;

      return DioFailure(
        (responseMap['message'] as String?) ??
            S.current.unexpectedErrorPleaseTryAgain,
      );
    } else if (statusCode == 500) {
      return DioFailure(S.current.internalServerErrorPleaseTryLater);
    } else {
      return DioFailure(S.current.opsThereWasAnErrorPleaseTryAgain);
    }
  }

  @override
  String toString() {
    return 'DioFailure: $errMessage';
  }
}

/// A class to represent the different types of failures that can occur in the app.
class RegularFailure extends Failure {
  /// Initializes the [RegularFailure] class with the given [errMessage].
  RegularFailure(String errMessage) : super(errMessage, 'Regular Exception');

  /// A factory method to create a [RegularFailure] instance from a [Exception] instance.
  factory RegularFailure.fromException(Exception e) {
    return RegularFailure(e.toString());
  }

  @override
  String toString() {
    return 'RegularFailure: $errMessage';
  }
}
