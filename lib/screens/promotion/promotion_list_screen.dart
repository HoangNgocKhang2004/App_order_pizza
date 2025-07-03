import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:flutter/material.dart';
import 'package:app_food_delivery/api/promotion_service.dart';
import 'package:app_food_delivery/models/promotion_model.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';

class PromotionListScreen extends StatefulWidget {
  const PromotionListScreen({super.key});

  @override
  State<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {
  final PromotionService _promotionService = PromotionService();
  late Future<List<PromotionModel>> _promotionsFuture;
  //Lấy khuyến mãi chính
  int idPromotionMain = 1;
  late Future<PromotionModel> _promotionTop = _promotionService.getPromotion(1);

  @override
  void initState() {
    super.initState();
    //Lấy toàn bộ khuyến mãi từ API
    _promotionsFuture = _promotionService.getPromotions();
    //Lây khuyến mãi chính từ API
    _promotionTop = _promotionService.getPromotion(idPromotionMain);
  }

  Future<void> _refreshPromotions() async {
    setState(() {
      _promotionsFuture = _promotionService.getPromotions();
      _promotionTop = _promotionService.getPromotion(idPromotionMain);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Khuyến mãi chính
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 2, color: AppColors.backgroudGreyBland),
            ),
            child: FutureBuilder<PromotionModel>(
              future: _promotionTop,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Lỗi tải khuyến mãi chính'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('Không tìm thấy khuyến mãi chính'));
                }

                final promotion = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          promotion.imageUrl != null && promotion.imageUrl!.isNotEmpty
                              ? "assets/image_promotion/${promotion.imageUrl}"
                              : "assets/image_promotion/error_promotion.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            "assets/image_promotion/error_promotion.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 16),
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Text(
                        promotion.promotionName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Danh sách khuyến mãi từ API
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: FutureBuilder<List<PromotionModel>>(
              future: _promotionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text('Lỗi: ${snapshot.error}'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _refreshPromotions,
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Không tìm thấy khuyến mãi'));
                }

                final promotions = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 2.5,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: promotions.length,
                  itemBuilder: (context, index) {
                    final promotion = promotions[index];
                    return Container(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 2,
                          color: AppColors.backgroudGreyBland,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Ảnh Khuyến Mãi
                          SizedBox(
                            width: double.infinity,
                            height: 110,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                "assets/image_promotion/${promotion.imageUrl}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          //Tên Khuyến Mãi
                          Container(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              promotion.promotionName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          //Thời gian khuyến mãi
                          Container(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              FormatUtils.formattedDateTime(promotion.startDate) + " - " + FormatUtils.formattedDateTime(promotion.endDate),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: AppColors.secondary
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Visibility(
                              visible: false,
                              child: Text(
                                "Giảm " + promotion.discountPercentage.toString() + "%",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.secondary
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}