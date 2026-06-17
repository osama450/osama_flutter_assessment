import 'package:shop_plus/core/typography.dart';
import 'package:flutter/material.dart';
import '../../ui/app_colors.dart';

class CustomDoubleToggleButtons extends StatefulWidget {
  const CustomDoubleToggleButtons({
    super.key,
    required this.options,
    required this.onSelected,
    this.initialSelected,
    this.title,
    this.weight,
    this.padding,
  });

  final String? title;
  final List<String> options;
  final String? initialSelected;
  final Function(String) onSelected;
  final double? weight;
  final EdgeInsetsGeometry? padding;

  @override
  State<CustomDoubleToggleButtons> createState() =>
      _CustomDoubleToggleButtonsState();
}

class _CustomDoubleToggleButtonsState extends State<CustomDoubleToggleButtons> {
  int selectedIndex = 0;

  @override
  void initState() {
    if (widget.initialSelected != null) {
      selectedIndex = widget.options.indexOf(widget.initialSelected!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title ?? '',
            style: AppTypography.textSM(
              color: AppColors.appGray.shade700,
              weight: AppFontWeight.medium,
            ),
          ),
          SizedBox(height: 8),
        ],
        Container(
          width: widget.weight ?? double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Wrap content to its size
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int index = 0; index < widget.options.length; index++)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onSelected(widget.options[index]);
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding:
                          widget.padding ??
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: selectedIndex == index
                            ? BorderRadius.circular(8)
                            : null,
                      ),
                      child: Text(
                        widget.options[index],
                        style: AppTypography.textMD(),
                        maxLines: 1, // Ensure single line text
                        overflow:
                            TextOverflow.ellipsis, // Avoid overflow issues
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
