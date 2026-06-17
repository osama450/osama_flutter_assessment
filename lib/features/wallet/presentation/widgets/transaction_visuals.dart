import 'package:flutter/material.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/features/wallet/data/models/transaction.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';
import 'package:shop_plus/generated/l10n.dart';

extension TransactionTypeVisuals on TransactionType {
  IconData get icon => switch (this) {
    TransactionType.earn => Icons.south_west_rounded,
    TransactionType.redeem => Icons.north_east_rounded,
    TransactionType.transferIn => Icons.swap_horiz_rounded,
    TransactionType.transferOut => Icons.swap_horiz_rounded,
    TransactionType.purchase => Icons.shopping_bag_outlined,
  };

  Color chipFg(BuildContext context) => switch (this) {
    TransactionType.earn => context.appTheme.green,
    TransactionType.redeem => context.appTheme.primary,
    TransactionType.transferIn ||
    TransactionType.transferOut => AppColors.blueLight.shade500,
    TransactionType.purchase => context.appTheme.amber,
  };

  Color chipBg(BuildContext context) => chipFg(context).withValues(alpha: 0.14);
}

extension TransactionStatusVisuals on TransactionStatus {
  String label(BuildContext context) => switch (this) {
    TransactionStatus.pending => S.of(context).statusPending,
    TransactionStatus.completed => S.of(context).statusCompleted,
    TransactionStatus.failed => S.of(context).statusFailed,
  };

  Color color(BuildContext context) => switch (this) {
    TransactionStatus.pending => context.appTheme.amber,
    TransactionStatus.completed => context.appTheme.green,
    TransactionStatus.failed => context.appTheme.red,
  };
}

extension TransactionFilterLabel on TransactionFilter {
  String label(BuildContext context) => switch (this) {
    TransactionFilter.all => S.of(context).filterAll,
    TransactionFilter.earn => S.of(context).filterEarn,
    TransactionFilter.redeem => S.of(context).filterRedeem,
    TransactionFilter.transfer => S.of(context).filterTransfer,
  };
}
