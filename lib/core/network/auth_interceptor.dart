import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shop_plus/core/network/endpoints.dart';
import 'package:shop_plus/core/network/token_storage.dart';

const String _retriedFlag = 'auth_retried';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio retryClient,
    required Dio refreshClient,
    required TokenStorage tokenStorage,
    required Future<void> Function() onSessionExpired,
  }) : _retryClient = retryClient,
       _refreshClient = refreshClient,
       _tokenStorage = tokenStorage,
       _onSessionExpired = onSessionExpired;

  final Dio _retryClient;
  final Dio _refreshClient;
  final TokenStorage _tokenStorage;
  final Future<void> Function() _onSessionExpired;

  Completer<String?>? _refresh;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['lang'] = Intl.getCurrentLocale();
    final token = await _tokenStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final isRetry = options.extra[_retriedFlag] == true;

    if (err.response?.statusCode != 401 || isRetry) {
      return handler.next(err);
    }

    final newToken = await _refreshToken();
    if (newToken == null) {
      await _expireSession();
      return handler.next(err);
    }

    try {
      options.extra[_retriedFlag] = true;
      options.headers['Authorization'] = 'Bearer $newToken';
      final response = await _retryClient.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  Future<String?> _refreshToken() {
    final pending = _refresh;
    if (pending != null) return pending.future;

    final completer = Completer<String?>();
    _refresh = completer;

    _performRefresh()
        .then(completer.complete)
        .catchError((Object _) => completer.complete(null))
        .whenComplete(() => _refresh = null);

    return completer.future;
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    final response = await _refreshClient.post<dynamic>(
      EndPoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) return null;

    final accessToken = data['access_token'] as String?;
    if (accessToken == null || accessToken.isEmpty) return null;

    final nextRefresh = (data['refresh_token'] as String?) ?? refreshToken;
    await _tokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: nextRefresh,
    );
    return accessToken;
  }

  Future<void> _expireSession() async {
    await _tokenStorage.clear();
    await _onSessionExpired();
  }
}
