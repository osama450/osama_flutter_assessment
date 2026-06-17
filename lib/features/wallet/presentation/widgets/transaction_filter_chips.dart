import 'package:flutter/material.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_visuals.dart';

class TransactionFilterChips extends StatelessWidget {
  const TransactionFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
    this.counts = const {},
  });

  final TransactionFilter selected;
  final ValueChanged<TransactionFilter> onSelected;
  final Map<TransactionFilter, int> counts;

  @override
  Widget build(BuildContext context) {
    const filters = TransactionFilter.values;
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selected;
          final theme = context.appTheme;
          final count = counts[filter];

          return GestureDetector(
            onTap: () => onSelected(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? theme.primary : theme.card,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected ? theme.primary : theme.hair,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: theme.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filter.label(context),
                    style: AppTypography.textSM(
                      weight: AppFontWeight.semibold,
                      color: isSelected ? theme.onPrimary : theme.subink,
                    ),
                  ),
                  if (count != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.onPrimary.withValues(alpha: 0.22)
                            : theme.surfaceMute,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$count',
                        style: AppTypography.textXS(
                          weight: AppFontWeight.bold,
                          color: isSelected ? theme.onPrimary : theme.mute,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
