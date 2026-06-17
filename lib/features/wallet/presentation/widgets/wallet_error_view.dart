import 'package:flutter/material.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/presentation/widgets/buttons/m_button.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/generated/l10n.dart';

class WalletErrorView extends StatelessWidget {
  const WalletErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, color: theme.red, size: 48),
            const SizedBox(height: 12),
            Text(
              message ?? S.of(context).somethingWentWrong,
              textAlign: TextAlign.center,
              style: AppTypography.textMD(color: theme.ink),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: MButton.primary(
                text: S.of(context).retry,
                onPressed: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
