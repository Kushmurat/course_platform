import 'package:flutter/material.dart';

class CourseChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final bool filled;

  const CourseChip({
    super.key,
    required this.label,
    required this.color,
    this.textColor = Colors.white,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? color : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: filled ? null : Border.all(color: color.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(color: filled ? textColor : color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
