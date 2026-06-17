import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/balance_card.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_list_item.dart';

class WalletBalanceShimmer extends StatelessWidget {
  const WalletBalanceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: BalanceCard(balance: _fakeBalance));
  }
}

class WalletListShimmer extends StatelessWidget {
  const WalletListShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: List.generate(
          itemCount,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransactionListItem(transaction: _fakeTransaction),
          ),
        ),
      ),
    );
  }
}

final PointsBalance _fakeBalance = PointsBalance(
  totalPoints: 12345,
  pendingPoints: 678,
  expiringPoints: 900,
  expiringDate: DateTime(2026),
  lastUpdated: DateTime(2026),
  balancesByMerchant: const [],
);

final Transaction _fakeTransaction = Transaction(
  id: '0',
  type: TransactionType.earn,
  points: 100,
  description: 'Loading transaction',
  merchantName: 'Merchant name',
  merchantLogo: '',
  createdAt: DateTime(2026, 1, 1, 12, 30),
  status: TransactionStatus.completed,
);
