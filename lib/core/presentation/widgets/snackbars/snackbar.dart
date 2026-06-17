part of './show_snackbar.dart';

enum SnackbarType { success, warning, error }

class _Snackbar extends StatelessWidget {
  final IconData? icon;
  final String title;
  final SnackbarType type;
  final String? description;
  final List<SnackbarAction>? actions;
  final void Function() onClose;
  final bool showCloseButton;

  const _Snackbar({
    required this.icon,
    required this.title,
    required this.type,
    required this.onClose,
    this.description,
    this.actions,
    this.showCloseButton = true,
  }) : assert(actions == null || actions.length <= 2);

  Color get _iconCircleColor {
    switch (type) {
      case SnackbarType.success:
        return AppColors.brandGreen;
      case SnackbarType.warning:
        return AppColors.amber;
      case SnackbarType.error:
        return AppColors.error;
    }
  }

  IconData get _defaultIcon {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_rounded;
      case SnackbarType.warning:
        return Icons.priority_high_rounded;
      case SnackbarType.error:
        return Icons.close_rounded;
    }
  }

  double _getDescriptionWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * .65;
    return screenWidth;
  }

  List<Widget> _getActions() {
    return actions!
        .map(
          (action) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: _SnackbarAction(
              actionData: action,
              contentColor: AppColors.white,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.5),
              blurRadius: 40,
              spreadRadius: -12,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _iconCircleColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon ?? _defaultIcon,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                SizedBox(width: 9),
                ConstrainedBox(
                  constraints: BoxConstraints.loose(
                    Size(_getDescriptionWidth(context), double.infinity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.textSM(
                          weight: AppFontWeight.semibold,
                          color: AppColors.white,
                        ).copyWith(fontSize: 13.5, letterSpacing: -0.1),
                      ),
                      if (description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          description!,
                          style: AppTypography.textXS(
                            color: AppColors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
                if (showCloseButton)
                  GestureDetector(
                    onTap: onClose,
                    child: Icon(
                      Icons.close,
                      color: AppColors.white.withValues(alpha: 0.7),
                      size: 18,
                    ),
                  ),
              ],
            ),
            if (actions != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _getActions(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
