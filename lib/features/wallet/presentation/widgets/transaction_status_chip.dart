import 'package:flutter/material.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_visuals.dart';

class TransactionStatusChip extends StatelessWidget {
  const TransactionStatusChip({super.key, required this.status});

  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            status.label(context),
            style: AppTypography.textXS(
              weight: AppFontWeight.semibold,
              color: color,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
