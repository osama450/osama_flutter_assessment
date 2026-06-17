part of './m_button.dart';

class _IconTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  final Widget? icon;
  final bool isBlocked;
  final double? iconSize;

  const _IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isBlocked = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _resolveIconPalette(context, isBlocked: isBlocked);
    final buttonStyle = _filledButtonStyle(palette, borderRadius: 14).copyWith(
      side: WidgetStatePropertyAll(
        BorderSide(color: palette.borderColor ?? Colors.transparent),
      ),
    );

    return _ButtonBase(
      isBlocked: isBlocked,
      builder: (context) {
        if (icon != null) {
          return ElevatedButton.icon(
            onPressed: !isLoading ? onPressed : null,
            style: buttonStyle,
            label: icon!,
            icon: _buildAnimatedButtonChild(
              isLoading: isLoading,
              loadingColor: palette.foregroundColor,
              child: Text(
                text,
                style: AppTypography.textMD(
                  color: palette.foregroundColor,
                  weight: AppFontWeight.medium,
                ),
              ),
            ),
          );
        }
        return ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: _buildAnimatedButtonChild(
            isLoading: isLoading,
            loadingColor: palette.foregroundColor,
            child: Text(
              text,
              style: AppTypography.textMD(
                color: palette.foregroundColor,
                weight: AppFontWeight.medium,
              ),
            ),
          ),
        );
      },
    );
  }
}
