import 'package:app_food_delivery/api/product_service.dart';
import 'package:app_food_delivery/api/ranking_service.dart';
import 'package:app_food_delivery/api/recommendations_service.dart';
import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_padding.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:app_food_delivery/models/product_model.dart';
import 'package:app_food_delivery/models/ranking_model.dart';
import 'package:app_food_delivery/screens/cart/cart_screen.dart';
import 'package:app_food_delivery/screens/product/product_detail_screen.dart';
import 'package:app_food_delivery/screens/product/products_suggested.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatefulWidget {
  static const routeName = '/ranking';
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  // Khởi tạo service
  final RankingService _rankingService = RankingService();
  final ProductService _productService = ProductService();
  final RecommendationsService _recommendationsService = RecommendationsService();
  
  // Khởi tạo biến để lưu danh sách sản phẩm
  late Future<List<RankingModel>> _futureRankings;
  late Future<List<ProductModel>> _futureProducts;
  // filter 0 = Bán chạy, 1 = Theo tuần, 2 = Theo tháng
  int _selectedFilter = 1;
  // Danh sách các bộ lọc
  final _periods = ['Bestseller', 'Weekly', 'Monthly'];
  // Danh sách rating tương ứng với từng món ăn
  final List<double> _ratings = [];
  @override
  void initState() {
    super.initState();
    _loadRankings();
  }

   void _loadRankings() {
    final period = _periods[_selectedFilter];
    _futureRankings = _rankingService.fetchRankings(period: period);
    // Khi rankings về, dùng Future.then để khởi động fetch chi tiết sản phẩm
    _futureProducts = _futureRankings.then((rankings) {
      // Lấy mảng Future<ProductModel> rồi đợi hết
      return Future.wait(rankings.map((r) => _productService.getProductById(r.productId)));
    });
    // Lấy danh sách rating từ rankings
    _ratings.clear();
    _futureRankings.then((rankings) {
      for (var ranking in rankings) {
        _ratings.add(ranking.averageRating);
      }
    });
  }

  void _onFilterSelected(int idx) {
    setState(() {
      _selectedFilter = idx;
      _loadRankings();
    });
  }

  // Hàm lấy sản phẩm gợi ý theo id sản phẩm
  Future<List<ProductModel>> _getProductSuggestions(int productId) async {
    final recommendations = await _recommendationsService.getRecommendations(productId);
    return Future.wait(recommendations.map((r) => _productService.getProductById(r.productId)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Tiêu đề
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bảng Xếp Hạng',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.emoji_events, color: AppColors.warning),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Filter
          Container(
            height: 60,
            padding: EdgeInsets.only(left: 12, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _periods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: FilterChip(
                    selected: _selectedFilter == index,
                    label: Text(
                      _periods[index],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onSelected: (_) => _onFilterSelected(index),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.backgroudGreyBland,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    labelStyle: TextStyle(
                      color: _selectedFilter == index ? Colors.white : AppColors.textPrimary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                );
              },
            ),
          ),

          //Danh sách sản phẩm
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
              future: _futureProducts,
              builder: (ctx, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Lỗi: ${snap.error}'));
                }

                final products = snap.data!;
                if (products.isEmpty) {
                  return Center(child: Text('Chưa có dữ liệu'));
                }

                final top1 = products[0];
                final top2 = products[1];
                final top3 = products[2];
                // Lấy danh sách sản phẩm từ chỉ số 3 trở đi
                final others = products.sublist(3);

                // Xử lý dữ liệu và hiển thị danh sách sản phẩm
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top 1
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                        width: double.infinity,
                        height: 250, // Đặt chiều cao cụ thể
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage("assets/image_product/${top1.imageUrl}"),
                            fit: BoxFit.cover,
                            opacity: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            // Nội dung
                            GestureDetector(
                              onTap:() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(productId: top1.productId),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.warning,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        '#1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      top1.productName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      FormatUtils.formattedPriceDouble(top1.price) +AppStrings.tienTe,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context)=>CartScreen())
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text('Thêm vào giỏ'),
                                        ),
                                        SizedBox(width: 8,),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              MainApp.routeName,
                                              (Route<dynamic> route) => false,
                                              arguments: 2, // Tab Menu
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text('Menu'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      //Top 2 - 3
                      Container(
                        margin: AppPadding.paddingLe,
                        child: Row(
                          children: [
                            //Top 3
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 200,
                                // width: MediaQuery.of(context).size.width*0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: AssetImage("assets/image_product/${top3.imageUrl}"),
                                    fit: BoxFit.cover,
                                    opacity: 0.8,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    // Gradient overlay
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                    // Nội dung
                                    GestureDetector(
                                      onTap:() => Navigator.push(context, 
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailScreen(productId: top3.productId),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: AppColors.warning,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                '#3',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              top3.productName,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            // Text(
                                            //   FormatUtils.formattedPriceDouble(top2.price)+AppStrings.tienTe,
                                            //   style: TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 14,
                                            //     fontWeight: FontWeight.bold,
                                            //   ),
                                            // ),
                                            const SizedBox(height: 12),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context)=>CartScreen())
                                              );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.fromLTRB(10, 6, 4, 6),
                                                backgroundColor: AppColors.primary,
                                                foregroundColor: Colors.white,
                                                minimumSize: const Size(1, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                              icon: Image.asset(
                                                "assets/icons/add_cart.png",
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.cover,
                                                color: Colors.white,
                                              ),
                                              label: Text(""),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(width: 12,),
                            
                            //Top2
                            Expanded(
                              flex: 2,
                              child: Container(
                                  height: 250, // Đặt chiều cao cụ thể
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage("assets/image_product/${top2.imageUrl}"),
                                      fit: BoxFit.cover,
                                      opacity: 0.8,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 15,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // Gradient overlay
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                      // Nội dung
                                      GestureDetector(
                                        onTap:() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailScreen(productId: top2.productId),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: AppColors.warning,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: const Text(
                                                  '#2',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                top2.productName,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                FormatUtils.formattedPriceDouble(top2.price)+AppStrings.tienTe,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context)=>CartScreen())
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.fromLTRB(12, 6, 4, 6),
                                                      backgroundColor: AppColors.primary,
                                                      foregroundColor: Colors.white,
                                                      minimumSize: const Size(1, 1),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                    ),
                                                    icon: Image.asset(
                                                      "assets/icons/add_cart.png",
                                                      width: 22,
                                                      height: 22,
                                                      fit: BoxFit.cover,
                                                      color: Colors.white,
                                                    ),
                                                    label: Text(""),
                                                  ),
                                                  SizedBox(width: 8,),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.pushNamedAndRemoveUntil(
                                                        context,
                                                        MainApp.routeName,
                                                        (Route<dynamic> route) => false,
                                                        arguments: 2, // Tab Menu
                                                      );  
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.fromLTRB(12, 6, 4, 6),
                                                      backgroundColor: AppColors.primary,
                                                      foregroundColor: Colors.white,
                                                      minimumSize: const Size(1, 1),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                    ),
                                                    icon: Image.asset(
                                                      "assets/icons/menu_book.png",
                                                      width: 22,
                                                      height: 22,
                                                      fit: BoxFit.cover,
                                                      color: Colors.white,
                                                    ),
                                                    label: Text(""),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),

                      // Các món khác 
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: AppPadding.paddingLe,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Danh sách món ngon khác",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: others.length,
                                itemBuilder: (context, index){
                                  return _buildFoodCard(others[index], _ratings[index+3]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //"Món ăn gợi ý nổi bật
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: AppPadding.paddingLe,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Món ăn gợi ý nổi bật",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                             Container(
                              margin: EdgeInsets.only(bottom: 16, left: 12, right: 12),
                              child: FutureBuilder(
                                future: _getProductSuggestions(top1.productId), 
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(child: Text('Không có dữ liệu'));
                                  }
                                  final products = snapshot.data!;
                                  return ProductsSuggested(products: products);
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),            
        ],
      )
    );
  }
  Widget _buildFoodCard(ProductModel product, double rating) {
    return GestureDetector(
      onTap:() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(productId: product.productId),
        ),
      ),  
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Khoảng cách giữa các item
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150, // Chiều cao hình ảnh
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage("assets/image_product/${product.imageUrl}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: Text(
                              product.productName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            FormatUtils.formattedPriceDouble(product.price) + AppStrings.tienTe,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                          rating.toStringAsFixed(1).toString(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.6, // Button chiếm toàn chiều rộng của card
                        height: 30,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              MainApp.routeName,
                              (Route<dynamic> route) => false,
                              arguments: 2, // Tab Menu
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.zero, // Loại bỏ padding mặc định
                          ),
                          icon: Image.asset(
                            "assets/icons/pizza.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Mua ngay',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2, // Button chiếm toàn chiều rộng của card
                        height: 30,
                        child:  ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>CartScreen())
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(6, 2, 2, 2),
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(1, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: Image.asset(
                            "assets/icons/add_cart.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          label: Text(""),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
