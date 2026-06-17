part of './m_button.dart';

@immutable
class _ButtonPalette {
  const _ButtonPalette({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.overlayColor,
    this.borderColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color overlayColor;
  final Color? borderColor;
}

_ButtonPalette _resolvePrimaryPalette(
  BuildContext context, {
  required bool isBlocked,
  Color? buttonColor,
  Color? textColor,
}) {
  final appTheme = context.appTheme;
  final backgroundColor = isBlocked
      ? appTheme.border
      : buttonColor ?? AppColors.primary.shade900;

  return _ButtonPalette(
    backgroundColor: backgroundColor,
    foregroundColor: textColor ?? _resolveForegroundColor(backgroundColor),
    overlayColor: appTheme.surfaceVariant,
  );
}

_ButtonPalette _resolveTextPalette(
  BuildContext context, {
  required bool isBlocked,
}) {
  final appTheme = context.appTheme;

  return _ButtonPalette(
    backgroundColor: Colors.transparent,
    foregroundColor: isBlocked
        ? appTheme.textSecondary
        : appTheme.textSecondary,
    overlayColor: appTheme.surfaceVariant,
  );
}

_ButtonPalette _resolveIconPalette(
  BuildContext context, {
  required bool isBlocked,
}) {
  final appTheme = context.appTheme;

  return _ButtonPalette(
    backgroundColor: isBlocked ? appTheme.surfaceVariant : appTheme.surface,
    foregroundColor: isBlocked ? appTheme.textSecondary : appTheme.textPrimary,
    overlayColor: appTheme.surfaceVariant,
    borderColor: appTheme.border,
  );
}

Color _resolveForegroundColor(Color backgroundColor) {
  return backgroundColor.computeLuminance() > 0.45
      ? Colors.black
      : Colors.white;
}

ButtonStyle _filledButtonStyle(
  _ButtonPalette palette, {
  double borderRadius = 12,
}) {
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    overlayColor: palette.overlayColor,
    elevation: 0,
    backgroundColor: palette.backgroundColor,
    foregroundColor: palette.foregroundColor,
  );
}

ButtonStyle _outlinedButtonStyle(
  _ButtonPalette palette, {
  double borderRadius = 8,
}) {
  return OutlinedButton.styleFrom(
    overlayColor: palette.overlayColor,
    side: BorderSide(
      color: palette.borderColor ?? palette.foregroundColor,
      width: 0.8,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    foregroundColor: palette.foregroundColor,
  );
}

ButtonStyle _textButtonStyle(_ButtonPalette palette) {
  return TextButton.styleFrom(
    foregroundColor: palette.foregroundColor,
    overlayColor: palette.overlayColor,
  );
}

Widget _buildAnimatedButtonChild({
  required bool isLoading,
  required Color loadingColor,
  required Widget child,
}) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) => ScaleTransition(
      scale: animation,
      child: FadeTransition(opacity: animation, child: child),
    ),
    child: isLoading ? _ButtonLoadingIndicator(color: loadingColor) : child,
  );
}
