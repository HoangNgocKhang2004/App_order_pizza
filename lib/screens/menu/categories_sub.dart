import 'package:flutter/material.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/models/sub_category_model.dart';

typedef OnSubCategoryTap = void Function(int newIndex);

class CategoriesSub extends StatelessWidget {
  final List<SubCategoryModel> subCategories;
  final int selectedIndex;
  final OnSubCategoryTap onTap;

  const CategoriesSub({
    Key? key,
    required this.subCategories,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) return const SizedBox.shrink();
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subCategories.length,
        itemBuilder: (ctx, idx) {
          final sub = subCategories[idx];
          final isSel = idx == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(idx),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                sub.subCategoryName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSel ? AppColors.textRed : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
