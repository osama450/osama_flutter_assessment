part of './m_button.dart';

class _TextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData? icon;
  final bool isBlocked;
  final double? iconSize;
  final bool showIconRight;

  const _TextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isBlocked = false,
    this.iconSize,
    this.showIconRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _resolveTextPalette(context, isBlocked: isBlocked);

    Widget buttonText() => Text(
      text,
      style: AppTypography.textSM(
        color: palette.foregroundColor,
        weight: AppFontWeight.semibold,
      ),
    );

    Widget buttonIcon() =>
        Icon(icon!, color: palette.foregroundColor, size: iconSize);

    return _ButtonBase(
      isBlocked: isBlocked,
      builder: (context) {
        if (icon != null) {
          return TextButton.icon(
            style: _textButtonStyle(palette),
            onPressed: onPressed,
            icon: showIconRight ? buttonText() : buttonIcon(),
            label: showIconRight ? buttonIcon() : buttonText(),
          );
        }
        return SizedBox(
          height: 40,
          child: TextButton(
            style: _textButtonStyle(palette),
            onPressed: onPressed,
            child: buttonText(),
          ),
        );
      },
    );
  }
}
