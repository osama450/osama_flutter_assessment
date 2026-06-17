import 'package:shop_plus/core/typography.dart';
import 'package:flutter/material.dart';
import '../../ui/app_colors.dart';

class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({
    super.key,
    required this.options,
    required this.onSelected,
  });

  final List<String> options;
  final Function(String) onSelected;

  @override
  State<CustomToggleButtons> createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'packageOptions',
          style: AppTypography.textMD(color: AppColors.black),
        ),
        SizedBox(height: 16),
        Container(
          height: 50, // Remove .h for fixed height
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffF4ECE1),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Wrap content to its size
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.options.length, (index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  widget.onSelected(widget.options[index]);
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: IntrinsicWidth(
                  // Ensures the item takes only the width it needs
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: isSelected
                          ? BorderRadius.circular(36)
                          : null,
                    ),
                    child: Text(
                      widget.options[index],
                      style: const TextStyle(
                        color: AppColors.grayDark,
                        fontSize: 14, // Use fixed font size here
                      ),
                      maxLines: 1, // Ensure single line text
                      overflow: TextOverflow.ellipsis, // Avoid overflow issues
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
