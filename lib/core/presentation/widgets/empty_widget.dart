import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String body;

  const EmptyWidget({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: AppTypography.textLG(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          body,
          textAlign: TextAlign.center,
          style: AppTypography.textSM(color: AppColors.appGray),
        ),
      ],
    );
  }
}
