import 'package:flutter/material.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/models/category_model.dart';

class CategoriesMain extends StatefulWidget {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<String> icons;

  const CategoriesMain({
    Key? key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
    required this.icons,
  }) : super(key: key);

  @override
  State<CategoriesMain> createState() => _CategoriesMainState();
}

class _CategoriesMainState extends State<CategoriesMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.background,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: widget.categories.length,
        itemBuilder: (ctx, index) {
          final cat = widget.categories[index];
          final isSelected = index == widget.selectedIndex;
          return GestureDetector(
            onTap: () => widget.onTap(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Image.asset(
                    widget.icons[index],
                    width: 30,
                    height: 30,
                    color: isSelected ? AppColors.textRed : AppColors.textSecondary,
                  ),
                  SizedBox(height: 6),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      cat.categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.textRed : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
