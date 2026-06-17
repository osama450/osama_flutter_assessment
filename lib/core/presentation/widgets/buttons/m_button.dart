import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:flutter/material.dart';
part './primary_button.dart';
part './button_loading_indicator.dart';
part './button_theme.dart';
part './text_button.dart';
part './button_base.dart';
part './icon_text_button.dart';

enum ButtonType { primary, icon, text }

class MButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  final IconData? icon;
  final Widget? iconWidget;
  final ButtonType type;
  final bool isBlocked;
  final double? iconSize;
  final TextStyle? textStyle;
  final Widget widget;
  final bool showIconRight;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? textColor;
  final IconAlignment? iconAlignment;
  final Widget? prefixWidget;
  final Widget? child;

  const MButton._({
    super.key,
    required this.text,
    required this.onPressed,
    required this.type,
    this.widget = const SizedBox(),
    this.isLoading = false,
    this.isBlocked = false,
    this.icon,
    this.iconWidget,
    this.iconSize,
    this.textStyle,
    this.showIconRight = false,
    this.borderColor,
    this.buttonColor,
    this.textColor,
    this.iconAlignment,
    this.prefixWidget,
    this.child,
  });

  factory MButton.primary({
    Key? key,
    required String text,
    required void Function() onPressed,
    bool isLoading = false,
    IconData? icon,
    bool isBlocked = false,
    double? iconSize,
    TextStyle? textStyle,
    Color? buttonColor,
    Color? textColor,
    IconAlignment? iconAlignment,
    Widget? prefixWidget,
  }) => MButton._(
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    type: ButtonType.primary,
    key: key,
    icon: icon,
    isBlocked: isBlocked,
    iconSize: iconSize,
    textStyle: textStyle,
    buttonColor: buttonColor,
    textColor: textColor,
    iconAlignment: iconAlignment,
    prefixWidget: prefixWidget,
  );

  factory MButton.icon({
    Key? key,
    required String text,
    required void Function() onPressed,
    bool isLoading = false,
    Widget? icon,
    bool isBlocked = false,
    double? iconSize,
  }) => MButton._(
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    type: ButtonType.icon,
    key: key,
    iconWidget: icon,
    isBlocked: isBlocked,
    iconSize: iconSize,
  );

  factory MButton.text({
    Key? key,
    required String text,
    required void Function() onPressed,
    IconData? icon,
    bool isBlocked = false,
    double? iconSize,
    bool showIconRight = false,
  }) => MButton._(
    text: text,
    onPressed: onPressed,
    type: ButtonType.text,
    key: key,
    icon: icon,
    isBlocked: isBlocked,
    iconSize: iconSize,
    showIconRight: showIconRight,
  );

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return _PrimaryButton(
          key: key,
          text: text,
          onPressed: onPressed,
          isLoading: isLoading,
          icon: icon,
          isBlocked: isBlocked,
          iconSize: iconSize,
          buttonColor: buttonColor,
          textColor: textColor,
          textStyle: textStyle,
          iconAlignment: iconAlignment,
          prefixWidget: prefixWidget,
        );

      case ButtonType.text:
        return _TextButton(
          key: key,
          text: text,
          onPressed: onPressed,
          icon: icon,
          isBlocked: isBlocked,
          iconSize: iconSize,
          showIconRight: showIconRight,
        );

      case ButtonType.icon:
        return _IconTextButton(
          key: key,
          isLoading: isLoading,
          onPressed: onPressed,
          icon: iconWidget,
          isBlocked: isBlocked,
          iconSize: iconSize,
          text: text,
        );
    }
  }
}
