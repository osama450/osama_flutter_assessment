import '../models/merchant_balance.dart';
import '../models/points_balance.dart';
import '../models/transaction.dart';

abstract class WalletFakeData {
  static final PointsBalance balance = PointsBalance(
    totalPoints: 15750,
    pendingPoints: 500,
    expiringPoints: 1200,
    expiringDate: DateTime.parse('2024-03-31T23:59:59Z'),
    lastUpdated: DateTime.parse('2024-02-15T10:30:00Z'),
    balancesByMerchant: const [
      MerchantBalance(
        merchantId: 'm_123',
        merchantName: 'TechMart',
        merchantLogo: 'https://picsum.photos/seed/techmart/100',
        points: 8500,
        tier: 'Gold',
      ),
      MerchantBalance(
        merchantId: 'm_456',
        merchantName: 'FoodMart',
        merchantLogo: 'https://picsum.photos/seed/foodmart/100',
        points: 4250,
        tier: 'Silver',
      ),
      MerchantBalance(
        merchantId: 'm_789',
        merchantName: 'StyleHub',
        merchantLogo: 'https://picsum.photos/seed/stylehub/100',
        points: 3000,
        tier: 'Bronze',
      ),
    ],
  );

  static final List<Transaction> transactions = List.unmodifiable([
    for (var i = 0; i < 30; i++) _transaction(i),
  ]);

  static const List<_Template> _templates = [
    _Template(
      type: TransactionType.earn,
      points: 500,
      description: 'Purchase at TechMart',
      merchantName: 'TechMart',
      merchantLogo: 'https://picsum.photos/seed/techmart/100',
      status: TransactionStatus.completed,
    ),
    _Template(
      type: TransactionType.redeem,
      points: -1000,
      description: 'Discount redemption',
      merchantName: 'FoodMart',
      merchantLogo: 'https://picsum.photos/seed/foodmart/100',
      status: TransactionStatus.completed,
    ),
    _Template(
      type: TransactionType.transferOut,
      points: -250,
      description: 'Transfer to Ahmed M.',
      merchantName: null,
      merchantLogo: null,
      status: TransactionStatus.completed,
    ),
    _Template(
      type: TransactionType.purchase,
      points: 750,
      description: 'Online order #ORD-2024-089',
      merchantName: 'StyleHub',
      merchantLogo: 'https://picsum.photos/seed/stylehub/100',
      status: TransactionStatus.completed,
    ),
    _Template(
      type: TransactionType.transferIn,
      points: 300,
      description: 'Received from Sara K.',
      merchantName: null,
      merchantLogo: null,
      status: TransactionStatus.pending,
    ),
  ];

  static Transaction _transaction(int i) {
    final t = _templates[i % _templates.length];
    final number = i + 1;
    final delta = (i ~/ _templates.length) * 25;
    final points = t.points >= 0 ? t.points + delta : t.points - delta;

    return Transaction(
      id: 'txn_${number.toString().padLeft(3, '0')}',
      type: t.type,
      points: points,
      description: i < _templates.length
          ? t.description
          : '${t.description} #$number',
      merchantName: t.merchantName,
      merchantLogo: t.merchantLogo,
      createdAt: DateTime(2024, 2, 15, 14, 30).subtract(Duration(days: i)),
      status: t.status,
    );
  }
}

class _Template {
  const _Template({
    required this.type,
    required this.points,
    required this.description,
    required this.merchantName,
    required this.merchantLogo,
    required this.status,
  });

  final TransactionType type;
  final int points;
  final String description;
  final String? merchantName;
  final String? merchantLogo;
  final TransactionStatus status;
}
