import 'package:flutter/material.dart';
import 'package:app_food_delivery/api/category_service.dart';
import 'package:app_food_delivery/api/sub_category_service.dart';
import 'package:app_food_delivery/api/product_service.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/models/category_model.dart';
import 'package:app_food_delivery/models/sub_category_model.dart';
import 'package:app_food_delivery/models/product_model.dart';
import 'package:app_food_delivery/screens/menu/categories_main.dart';
import 'package:app_food_delivery/screens/menu/categories_sub.dart';
import 'package:app_food_delivery/screens/menu/categories_list_product.dart';
import 'package:app_food_delivery/screens/cart/cart_sub.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _catSvc = CategoryService();
  final _subSvc = SubCategoryService();
  final _prodSvc = ProductService();

  late Future<void> _initFut;
  List<CategoryModel> _cats = [];
  List<SubCategoryModel> _subs = [];
  List<ProductModel> _allProds = [];

  int _selCat = 0;
  int _selSub = 0;
  int _selectedButton = 1;

  final List<String> _catIcons = [
    "assets/images/category_pizza.png",
    "assets/images/category_chicken.png",
    "assets/images/category_pasta.png",
    "assets/images/category_appetizer.png",
    "assets/images/category_desser.png",
    "assets/images/category_drink.png",
  ];

  @override
  void initState() {
    super.initState();
    _initFut = _loadAll();
  }

  Future<void> _loadAll() async {
    _cats = await _catSvc.getCategories();
    _subs = await _subSvc.getSubCategories();
    _allProds = await _prodSvc.getProducts();
  }

  void _onCatTap(int idx) {
    setState(() {
      _selCat = idx;
      _selSub = 0;
    });
  }

  void _onSubTap(int idx) {
    setState(() => _selSub = idx);
  }

  void _toggleButton(int idx) {
    setState(() => _selectedButton = idx);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<void>(
        future: _initFut,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_cats.isEmpty) {
            return const Center(child: Text('Không có danh mục'));
          }

          // Filter sub-categories and products
          final curCatId = _cats[_selCat].categoryId;
          final subsOfCat = _subs.where((s) => s.categoryId == curCatId).toList();

          // Nếu có sub-category thì clamp _selSub về 0..subsOfCat.length-1, ngược lại cho = 0
          final safeSub = subsOfCat.isNotEmpty
            ? (_selSub < 0
                ? 0
                : (_selSub >= subsOfCat.length
                    ? subsOfCat.length - 1
                    : _selSub))
            : 0;

          // Giờ safeSub chắc chắn là int trong khoảng 0..subsOfCat.length-1
          final curSubId = subsOfCat.isNotEmpty
              ? subsOfCat[safeSub].subCategoryId
              : null;

          // Cuối cùng filter product theo main và sub categories
          final filteredProds = _allProds.where((p) {
            return p.categoryId == curCatId &&
                (curSubId == null || p.subCategoryId == curSubId);
          }).toList();


          return Column(
            children: [
              // Delivery / Carry Out Toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            _selectedButton == 1
                                ? 'Choose Address'
                                : 'Please Select Store',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroudGreyBland,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          _buildToggle('Delivery', 1),
                          _buildToggle('Carry Out', 0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Categories Main
              CategoriesMain(
                categories: _cats,
                selectedIndex: _selCat,
                onTap: _onCatTap,
                icons: _catIcons,
              ),

              // Categories Sub
              CategoriesSub(
                subCategories: subsOfCat,
                selectedIndex: safeSub,
                onTap: _onSubTap,
              ),

              // Product List
              Expanded(
                child: filteredProds.isEmpty
                    ? const Center(child: Text('Không có sản phẩm'))
                    : CategoriesListProduct(products: filteredProds),
              ),

              // Cart Overlay
              //CartSub(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToggle(String label, int idx) {
    final isSel = _selectedButton == idx;
    return GestureDetector(
      onTap: () => _toggleButton(idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSel ? AppColors.buttonPrimary : AppColors.backgroudGreyBland,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSel ? Colors.white : AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}