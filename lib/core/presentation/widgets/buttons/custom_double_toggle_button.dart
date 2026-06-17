import 'package:flutter/material.dart';

class CustomDoubleToggleButton extends StatelessWidget {
  final bool isGridView;
  final Function(bool) onToggle;
  final Widget firstWidget;
  final Widget secondWidget;

  const CustomDoubleToggleButton({
    super.key,
    required this.isGridView,
    required this.onToggle,
    required this.firstWidget,
    required this.secondWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF4ECE1),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => onToggle(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isGridView ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: firstWidget,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onToggle(false),
              child: Container(
                decoration: BoxDecoration(
                  color: isGridView ? Colors.transparent : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: secondWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
