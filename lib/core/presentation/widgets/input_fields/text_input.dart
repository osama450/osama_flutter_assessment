import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shop_plus/config/themes/extensions/app_theme_extension.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/language_helper.dart';
import 'package:shop_plus/core/presentation/ui/app_colors.dart';
import 'package:shop_plus/core/presentation/widgets/input_fields/default_input_decorator.dart';
import 'package:shop_plus/core/typography.dart';

enum TextInputSize { small, medium }

class TextInput extends StatefulWidget {
  final String name;
  final TextEditingController? controller;
  final TextInputSize size;
  final String? label;
  final bool required;
  final IconData? icon;
  final String? innerHint;
  final String? bottomHint;
  final String? helperText;
  final bool showHelp;
  final TextInputType inputType;
  final void Function(String?)? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final GlobalKey<FormBuilderFieldState>? fieldKey;
  final bool enabled;
  final Color? iconColor;
  final bool enableBorder;
  final Widget? suffixIcon;
  final Widget? prefix;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final bool autoFocus;
  final Iterable<String>? autofillHints;
  final TextInputAction textInputAction;

  const TextInput({
    super.key,
    required this.name,
    this.controller,
    this.size = TextInputSize.small,
    this.label,
    this.required = false,
    this.icon,
    this.innerHint,
    this.bottomHint,
    this.helperText,
    this.showHelp = false,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.textDirection,
    this.inputFormatters,
    this.fieldKey,
    this.enabled = true,
    this.iconColor,
    this.enableBorder = true,
    this.suffixIcon,
    this.prefix,
    this.onEditingComplete,
    this.focusNode,
    this.autoFocus = false,
    this.autofillHints,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _obscureText = widget.inputType == TextInputType.visiblePassword;

  @override
  Widget build(BuildContext context) {
    final t = context.appTheme;
    final effectiveMaxLines = _obscureText ? 1 : widget.maxLines ?? 1;
    OutlineInputBorder border({Color? color}) {
      if (!widget.enableBorder) {
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        );
      }
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color ?? t.hair, width: 1),
      );
    }

    return DefaultInputDecorator(
      label: widget.label,
      required: widget.required,
      bottomHint: widget.bottomHint,
      inputField: FormBuilderTextField(
        key: widget.fieldKey,
        enabled: widget.enabled,
        autofillHints: widget.autofillHints,
        name: widget.name,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        validator: widget.validator,
        keyboardType: widget.inputType,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: effectiveMaxLines,
        textDirection: widget.textDirection,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        style: AppTypography.textSM(color: t.ink),
        textInputAction: widget.textInputAction,
        textAlign:
            LanguageHelper.isArabic && widget.textDirection == TextDirection.ltr
            ? TextAlign.end
            : TextAlign.start,
        obscureText: _obscureText,
        autofocus: widget.autoFocus,
        cursorColor: AppColors.primary,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: t.card,
          contentPadding: _padding,
          hintText: widget.innerHint,
          hintTextDirection: widget.textDirection,
          hintStyle: AppTypography.textSM(color: AppColors.grayLight.shade400),
          counter: const SizedBox.shrink(),
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(color: AppColors.primary),
          disabledBorder: border(),
          errorBorder: border(color: AppColors.error.shade300),
          focusedErrorBorder: border(color: AppColors.error.shade500),
          prefixIcon:
              widget.prefix ??
              (widget.icon != null
                  ? Padding(
                      padding: EdgeInsetsDirectional.only(start: 12, end: 4),
                      child: Icon(
                        widget.icon!,
                        size: 18,
                        color: widget.iconColor ?? t.mute,
                      ),
                    )
                  : null),
          suffixIcon: _buildSuffix(t),
        ),
      ),
    );
  }

  Widget? _buildSuffix(AppThemeExtension t) {
    if (widget.showHelp) {
      return Tooltip(
        message: widget.helperText ?? widget.label,
        triggerMode: TooltipTriggerMode.tap,
        child: SizedBox(
          width: 18,
          height: 18,
          child: Center(
            child: Icon(Icons.info_outline, size: 16, color: t.mute),
          ),
        ),
      );
    }
    if (widget.suffixIcon != null) return widget.suffixIcon;
    if (widget.inputType == TextInputType.visiblePassword) {
      return GestureDetector(
        onTap: _onToggleObscure,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            size: 16,
            color: t.ink,
          ),
        ),
      );
    }
    return null;
  }

  EdgeInsetsGeometry get _padding {
    return switch (widget.size) {
      TextInputSize.small => EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      TextInputSize.medium => EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
    };
  }

  void _onToggleObscure() {
    setState(() => _obscureText = !_obscureText);
  }
}
