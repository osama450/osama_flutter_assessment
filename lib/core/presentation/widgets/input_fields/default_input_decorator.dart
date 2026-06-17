import 'package:flutter/material.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:separated_column/separated_column.dart';

class DefaultInputDecorator extends StatelessWidget {
  final Widget inputField;
  final String? label;
  final String? errorText;
  final String? bottomHint;
  final bool required;

  const DefaultInputDecorator({
    required this.inputField,
    super.key,
    this.label,
    this.errorText,
    this.bottomHint,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.appTheme;
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separatorBuilder: (_, _) => SizedBox(height: 6),
      children: [
        if (label != null)
          Row(
            spacing: 6,
            children: [
              Text.rich(
                TextSpan(
                  text: label,
                  style: AppTypography.textSM(
                    weight: AppFontWeight.semibold,
                    color: t.ink,
                  ).copyWith(fontSize: 13),
                  children: required
                      ? [
                          TextSpan(
                            text: ' *',
                            style: AppTypography.textSM(
                              weight: AppFontWeight.bold,
                              color: AppColors.brandGreen,
                            ).copyWith(fontSize: 13),
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputField,
            if (errorText != null)
              Padding(
                padding: EdgeInsetsDirectional.only(top: 4, start: 12),
                child: Text(
                  errorText!,
                  style: AppTypography.textXS(color: AppColors.error.shade600),
                ),
              ),
          ],
        ),
        if (bottomHint != null)
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              bottomHint!,
              style: AppTypography.textXS(color: t.mute, fontSize: 11.5),
            ),
          ),
      ],
    );
  }
}
