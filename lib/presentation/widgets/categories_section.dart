import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/theme/app_colours.dart';
import 'package:noviindus/core/theme/app_text_style.dart';

class CategoriesSelector extends StatefulWidget {
  const CategoriesSelector({super.key});

  @override
  State<CategoriesSelector> createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector> {
  bool expanded = false;

  final categories = [
    "Physics",
    "Artificial Intelligence",
    "Mathematics",
    "Chemistry",
    "Micro Biology",
    "Astronomy",
    "Data Science",
    "Robotics",
    "Quantum Mechanics",
  ];

  final Set<String> selected = {};

  static const horizontalPadding = 14.0;
  static const spacing = 10.0;

  void toggle(String item) {
    setState(() {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        selected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final visible = expanded
            ? categories
            : _itemsForTwoRows(constraints.maxWidth, context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories This Project",
                  style: AppTextStyle.smallHeading,
                ),
                GestureDetector(
                  onTap: () => setState(() => expanded = !expanded),
                  child: Text(expanded ? "View less" : "View all"),
                ),
              ],
            ),

            SizedBox(height: 15.h),

            /// chips
            Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: visible.map(_chip).toList(),
            ),
          ],
        );
      },
    );
  }

  /// ⭐ EXACT 2 ROW DETECTION
  List<String> _itemsForTwoRows(double maxWidth, BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style;

    double currentWidth = 0;
    int row = 1;

    final result = <String>[];

    for (final item in categories) {
      final textWidth = _measureText(item, textStyle);
      final chipWidth = textWidth + (horizontalPadding * 2);

      if (currentWidth + chipWidth > maxWidth) {
        row++;
        currentWidth = 0;
      }

      if (row > 2) break;

      result.add(item);
      currentWidth += chipWidth + spacing;
    }

    return result;
  }

  double _measureText(String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return painter.width;
  }

  Widget _chip(String text) {
    final isSelected = selected.contains(text);

    return GestureDetector(
      onTap: () => toggle(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.buttonPrimary
                : Colors.white.withAlpha(50),
            width: 1.5,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
