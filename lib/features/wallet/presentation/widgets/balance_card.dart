import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/generated/l10n.dart';

String _fmt(int n) => NumberFormat.decimalPattern().format(n);

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance});

  final PointsBalance balance;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final white = AppColors.white;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.balanceGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.34),
            blurRadius: 34,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -70,
            right: -50,
            child: _ring(220, 40, white.withValues(alpha: 0.06)),
          ),
          Positioned(
            bottom: -90,
            right: 40,
            child: _ring(160, 28, white.withValues(alpha: 0.05)),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 16,
                      color: white.withValues(alpha: 0.92),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l.totalPoints.toUpperCase(),
                      style: AppTypography.textXS(
                        weight: AppFontWeight.semibold,
                        color: white.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _fmt(balance.totalPoints),
                      style: AppTypography.textXL(
                        weight: AppFontWeight.bold,
                        color: white,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l.pointsUnit,
                      style: AppTypography.textLG(
                        color: white.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      _subStat(
                        Icons.schedule_rounded,
                        l.pendingPoints,
                        balance.pendingPoints,
                        l.pointsUnit,
                        white,
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: white.withValues(alpha: 0.18),
                      ),
                      _subStat(
                        Icons.hourglass_bottom_rounded,
                        l.expiringPoints,
                        balance.expiringPoints,
                        l.pointsUnit,
                        white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ring(double size, double border, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: border),
      ),
    );
  }

  Widget _subStat(
    IconData icon,
    String label,
    int value,
    String unit,
    Color white,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: white.withValues(alpha: 0.9)),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.textXS(
                      weight: AppFontWeight.semibold,
                      color: white.withValues(alpha: 0.9),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  _fmt(value),
                  style: AppTypography.textLG(
                    weight: AppFontWeight.bold,
                    color: white,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTypography.textXS(
                    color: white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
