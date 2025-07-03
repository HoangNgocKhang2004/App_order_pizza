// PromotionProductModel: Chức năng liên kết sản phẩm với chương trình khuyến mãi.
class PromotionProductModel {
  final int promotionProductId; // ID liên kết, khóa chính.
  final int promotionId; // ID khuyến mãi, liên kết với Promotions.
  final int productId; // ID sản phẩm, liên kết với Products.

  PromotionProductModel({
    required this.promotionProductId,
    required this.promotionId,
    required this.productId,
  });

  factory PromotionProductModel.fromJson(Map<String, dynamic> json) {
    return PromotionProductModel(
      promotionProductId: json['PromotionProductID'] as int,
      promotionId: json['PromotionID'] as int,
      productId: json['ProductID'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PromotionProductID': promotionProductId,
      'PromotionID': promotionId,
      'ProductID': productId,
    };
  }
}