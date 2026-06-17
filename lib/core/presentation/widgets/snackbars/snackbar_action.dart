part of './show_snackbar.dart';

enum SnackbarActionType { outline, text }

class SnackbarAction {
  final String title;
  final Function() onPressed;
  final SnackbarActionType type;

  const SnackbarAction({
    required this.title,
    required this.onPressed,
    this.type = SnackbarActionType.outline,
  });
}

class _SnackbarAction extends StatelessWidget {
  final SnackbarAction actionData;
  final Color contentColor;

  const _SnackbarAction({required this.actionData, required this.contentColor});

  @override
  Widget build(BuildContext context) {
    if (actionData.type == SnackbarActionType.outline) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(36, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          foregroundColor: contentColor,
          side: BorderSide(color: contentColor),
        ),
        onPressed: actionData.onPressed,
        child: Text(actionData.title),
      );
    }
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: contentColor,
        minimumSize: const Size(36, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: actionData.onPressed,
      child: Text(actionData.title),
    );
  }
}
