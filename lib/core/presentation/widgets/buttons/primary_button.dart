part of './m_button.dart';

class _PrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isBlocked;
  final double? iconSize;
  final Color? buttonColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final IconAlignment? iconAlignment;
  final Widget? prefixWidget;

  const _PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isBlocked = false,
    this.iconSize,
    this.buttonColor,
    this.textColor,
    this.textStyle,
    this.iconAlignment,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _resolvePrimaryPalette(
      context,
      isBlocked: isBlocked,
      buttonColor: buttonColor,
      textColor: textColor,
    );
    final buttonStyle = _filledButtonStyle(palette);
    final defaultTextStyle =
        textStyle ??
        AppTypography.textMD(
          color: palette.foregroundColor,
          weight: AppFontWeight.bold,
        );

    return _ButtonBase(
      isBlocked: isBlocked,
      builder: (context) {
        if (prefixWidget != null || icon != null) {
          return SizedBox(
            height: 45,
            child: ElevatedButton.icon(
              iconAlignment: iconAlignment ?? IconAlignment.end,
              onPressed: !isLoading ? onPressed : null,
              style: buttonStyle,
              icon:
                  prefixWidget ??
                  Icon(
                    icon!,
                    color: palette.foregroundColor,
                    size: !isLoading ? iconSize : 0,
                  ),
              label: _buildAnimatedButtonChild(
                isLoading: isLoading,
                loadingColor: palette.foregroundColor,
                child: Text(text, style: defaultTextStyle),
              ),
            ),
          );
        }
        return SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: _buildAnimatedButtonChild(
              isLoading: isLoading,
              loadingColor: palette.foregroundColor,
              child: Text(text, style: defaultTextStyle),
            ),
          ),
        );
      },
    );
  }
}
