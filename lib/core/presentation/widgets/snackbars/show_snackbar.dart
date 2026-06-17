import 'package:shop_plus/core/typography.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ui/app_colors.dart';

part './snackbar.dart';
part './snackbar_action.dart';

void showAppSnackbar(
  BuildContext context, {
  required String title,
  required SnackbarType type,
  IconData? icon,
  String? description,
  List<SnackbarAction>? actions,
  bool persistent = false,
  bool showCloseButton = true,
  Duration? displayDuration,
  SnackBarPosition position = SnackBarPosition.top,
}) {
  late final AnimationController? animController;
  showTopSnackBar(
    Overlay.of(context),
    _Snackbar(
      icon: icon,
      title: title,
      type: type,
      description: description,
      actions: actions,
      onClose: () => animController?.reverse(),
      showCloseButton: showCloseButton,
    ),
    dismissType: DismissType.onTap,
    displayDuration: displayDuration ?? const Duration(seconds: 2),
    onAnimationControllerInit: (controller) => animController = controller,
    persistent: persistent,
    snackBarPosition: position,
  );
}
