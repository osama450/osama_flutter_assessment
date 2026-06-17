import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_plus/core/environment/variables.dart';
import 'package:shop_plus/core/network/auth_interceptor.dart';
import 'package:shop_plus/core/network/token_storage.dart';

@lazySingleton
class DioHelper {
  DioHelper(this._tokenStorage) {
    _dio = _build();
  }

  final TokenStorage _tokenStorage;
  late final Dio _dio;

  Dio get client => _dio;

  Dio _build() {
    final options = BaseOptions(
      baseUrl: EnvironmentVariables.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveDataWhenStatusError: true,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final dio = Dio(options);
    final refreshClient = Dio(options);

    dio.interceptors.add(
      AuthInterceptor(
        retryClient: dio,
        refreshClient: refreshClient,
        tokenStorage: _tokenStorage,
        onSessionExpired: _onSessionExpired,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (Object o) => debugPrint(o.toString()),
        ),
      );
    }

    return dio;
  }

  Future<void> _onSessionExpired() async {
    // Tokens are already cleared by the interceptor. Hook here to broadcast a
    // logout / navigate to the login screen once an auth feature exists.
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
