/// Endpoints for the API
class EndPoints {
  /// Base url for the API
  static String baseUrl = String.fromEnvironment('BASE_URL');

  static String balance = 'wallet/balance';
  static String transactions = 'wallet/transactions';
  static String transferPoints = 'wallet/transfer';
  static String refreshToken = 'api/auth/refresh';
}
