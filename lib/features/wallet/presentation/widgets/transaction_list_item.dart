import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/extensions/date_time_extensions.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/core/presentation/widgets/custom_cached_image.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_status_chip.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_visuals.dart';
import 'package:shop_plus/generated/l10n.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final positive = transaction.points > 0;
    final amountColor = positive ? theme.green : theme.ink;
    final sign = positive
        ? '+'
        : transaction.points < 0
        ? '-'
        : '';
    final amount = NumberFormat.decimalPattern().format(
      transaction.points.abs(),
    );
    final title = transaction.merchantName ?? transaction.description;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          _leading(context),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.textSM(
                    weight: AppFontWeight.semibold,
                    color: theme.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction.createdAt.formatRelativeDayTime(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.textXS(color: theme.mute),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$sign$amount',
                    style: AppTypography.textMD(
                      weight: AppFontWeight.bold,
                      color: amountColor,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    S.of(context).pointsUnit,
                    style: AppTypography.textXS(color: theme.mute),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              TransactionStatusChip(status: transaction.status),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leading(BuildContext context) {
    final theme = context.appTheme;
    final fg = transaction.type.chipFg(context);
    final logo = transaction.merchantLogo;

    if (logo == null || logo.isEmpty) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: transaction.type.chipBg(context),
          shape: BoxShape.circle,
        ),
        child: Icon(transaction.type.icon, color: fg, size: 21),
      );
    }

    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomCachedImage(
            image: logo,
            width: 44,
            height: 44,
            borderRadius: BorderRadius.circular(22),
            errorWidgetIconScale: 0.5,
          ),
          PositionedDirectional(
            bottom: -2,
            end: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: fg,
                shape: BoxShape.circle,
                border: Border.all(color: theme.card, width: 1.5),
              ),
              child: Icon(transaction.type.icon, color: AppColors.white, size: 10),
            ),
          ),
        ],
      ),
    );
  }
}
