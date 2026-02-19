import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/home_provider.dart';
import '../../presentation/providers/upload_provider.dart';
import '../../domain/entities/category.dart';
import '../../core/theme/app_colours.dart';
import '../../core/theme/app_text_style.dart';

class CategoriesSelector extends StatelessWidget {
  const CategoriesSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final upload = context.watch<UploadProvider>();

    final categories = home.categories;
    if (categories.isEmpty) return const SizedBox();

    final visible = upload.categoriesExpanded
        ? categories
        : categories.take(8).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories This Project", style: AppTextStyle.smallHeading),
            GestureDetector(
              onTap: upload.toggleExpanded,
              child: Text(upload.categoriesExpanded ? "View less" : "View all"),
            ),
          ],
        ),

        const SizedBox(height: 15),

        /// CHIPS
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: visible.map((c) => _chip(context, c)).toList(),
        ),
      ],
    );
  }

  Widget _chip(BuildContext context, Category c) {
    final upload = context.watch<UploadProvider>();
    final isSelected = upload.categoryIds.contains(c.id);

    return GestureDetector(
      onTap: () => context.read<UploadProvider>().toggleCategory(c.id),
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
        child: Text(c.name),
      ),
    );
  }
}
