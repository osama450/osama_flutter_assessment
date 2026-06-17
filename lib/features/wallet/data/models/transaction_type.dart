import 'transaction.dart';

enum TransactionFilter { all, earn, redeem, transfer }

extension TransactionFilterX on TransactionFilter {
  bool matches(TransactionType type) => switch (this) {
    TransactionFilter.all => true,
    TransactionFilter.earn => type == TransactionType.earn,
    TransactionFilter.redeem => type == TransactionType.redeem,
    TransactionFilter.transfer =>
      type == TransactionType.transferIn || type == TransactionType.transferOut,
  };
}
