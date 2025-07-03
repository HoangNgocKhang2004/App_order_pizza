import 'package:app_food_delivery/api/product_service.dart';
import 'package:app_food_delivery/api/recommendations_service.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_padding.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:app_food_delivery/models/product_model.dart';
import 'package:app_food_delivery/screens/cart/cart_screen.dart';
import 'package:app_food_delivery/screens/product/products_suggested.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = "/product_detail";

  /// Truyền đúng [productId] khi Navigator.pushNamed
  final int productId;
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Khởi tạo service
  final RecommendationsService _recommendationsService =RecommendationsService(); 
  final ProductService _productService = ProductService();

  /// Khởi tạo trong initState để có widget.productId
  late Future<ProductModel> _productFut;
  late Future<List<ProductModel>> _recommendationsFut;

  // Các state cho chọn size, crust, quantity...
  final List<int> sizes = [7, 9, 12];
  final List<int> prices = [85000, 155500, 225000];
  bool isTop = true;
  int selectedSize = 0;
  int selectedCrust = 0;
  int quantity = 1;
  int selectedPrice = 0;
  int maxRow = 2;

  @override
  void initState() {
    super.initState();
    // Lấy thông tin sản phẩm từ API
    _productFut = _productService.getProductById(widget.productId);
    // Lấy danh sách gợi ý sản phẩm từ API
    _recommendationsFut = _recommendationsService.getRecommendations(widget.productId);
    selectedPrice = prices[0];
  }

  void changeSizeActive(int index) {
    setState(() {
      selectedSize = index;
      selectedPrice = prices[index];
    });
  }

  void changeCrustActive(int index) {
    setState(() {
      selectedCrust = index;
    });
  }

  void changeMaxRow() {
    setState(() {
      maxRow = maxRow == 2 ? 10 : 2;
    });
  }

  Widget buildSizeAndPrice(bool isActive, int size, int price) {

    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: isActive ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icons/pizza_size.png",
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cỡ $size inch",
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 11)),
              Text(
                "${FormatUtils.formattedPrice(price)} ${AppStrings.tienTe}",
                style:
                    const TextStyle(color: AppColors.textSecondary, fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCrust(bool isActive, String crustName) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: isActive ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icons/crust.png",
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 4),
          Text(
            crustName,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildQuantityControl({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 24,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
            minimumSize: const Size(0, 0),
            padding: const EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(width: 1, color: AppColors.border))),
        icon: Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductModel>(
        future: _productFut,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Lỗi tải sản phẩm: ${snap.error}'));
          }
          final product = snap.data!;
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Ảnh: nếu có imageUrl thì xài network, ko thì fallback asset
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3333,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: product.imageUrl != null
                            ? Image.asset(
                                "assets/image_product/${product.imageUrl}",
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/pizza.png",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),

                    // Thông tin
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tên & top‐seller
                          Padding(
                            padding: AppPadding.paddingLe,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${product.productId}   -   ${product.productName}",
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                ),
                                if (isTop) ...[
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    "assets/icons/top_1st.png",
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ],
                            ),
                          ),


                          const SizedBox(height: 8),
                          // Mô tả
                          Padding(
                            padding: AppPadding.paddingLe,
                            child: Text(
                              product.description ?? '',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                              maxLines: maxRow,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: AppPadding.paddingLe,
                            child: GestureDetector(
                              onTap: changeMaxRow,
                              child: Text(
                                maxRow == 2 ? "Xem thêm" : "Ẩn đi",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          const Divider(),

                          // Chọn size
                          Padding(
                            padding: AppPadding.paddingLe,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Select Size",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 42,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sizes.length,
                                    itemBuilder: (context, index) {
                                      final isActive = index == selectedSize;
                                      return GestureDetector(
                                        onTap: () => changeSizeActive(index),
                                        child: buildSizeAndPrice(
                                          isActive,
                                          sizes[index],
                                          prices[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),
                          // Chọn đế bánh
                          Padding(
                            padding: AppPadding.paddingLe,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Chọn Đế Bánh",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 32,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      final crusts = ["Đế dày", "Đế vừa", "Đế mỏng"];
                                      final isActive = index == selectedCrust;
                                      return GestureDetector(
                                        onTap: () => changeCrustActive(index),
                                        child: buildCrust(isActive, crusts[index]),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),
                          // Sản phẩm gợi ý mua kèm
                          FutureBuilder<List<ProductModel>>(
                            future: _recommendationsFut,
                            builder: (ctx, snap) {
                              if (snap.connectionState != ConnectionState.done) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (snap.hasError) {
                                return Text('Lỗi tải gợi ý: ${snap.error}');
                              }
                              final recs = snap.data!;
                              if (recs.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Container(
                                width: double.infinity,
                                color: AppColors.backgroudGreyBland,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 106),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Sản phẩm mua kèm",
                                          style: TextStyle(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              const Text(
                                                "Xem thêm",
                                                style: TextStyle(
                                                  color: AppColors.textSecondary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              FaIcon(
                                                FontAwesomeIcons.angleRight,
                                                size: 14,
                                                color: AppColors.textPrimary,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    ProductsSuggested(
                                      products: recs,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Thanh thêm vào giỏ
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 106,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 1, color: AppColors.border),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              buildQuantityControl(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '$quantity',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary),
                              ),
                              const SizedBox(width: 10),
                              buildQuantityControl(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    if (quantity < 100) quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Row(
                              children: [
                                const Text("Tổng cộng: ",
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  "${FormatUtils.formattedPrice(selectedPrice * quantity)} ${AppStrings.tienTe}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.error),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CartScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text(
                            "Thêm vào giỏ hàng",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
      // Nút quay lại & giỏ hàng
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Close
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  "assets/icons/close.png",
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            ),

            // Cart
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  "assets/icons/cart.png",
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
