// PromotionModel: Chức năng quản lý chương trình khuyến mãi.
class PromotionModel {
  final int promotionId; // ID khuyến mãi, khóa chính, tham chiếu trong Orders.
  final String promotionName; // Tên khuyến mãi, hiển thị trên giao diện.
  final String? description; // Mô tả khuyến mãi, hiển thị chi tiết.
  final double? discountPercentage; // Phần trăm giảm giá, dùng để tính giá trị đơn hàng.
  final String? imageUrl; // URL ảnh khuyến mãi, hiển thị trên giao diện.
  final DateTime startDate; // Ngày bắt đầu khuyến mãi, kiểm tra thời gian áp dụng.
  final DateTime endDate; // Ngày kết thúc khuyến mãi, kiểm tra thời gian áp dụng.
  final DateTime createdDate; // Ngày tạo khuyến mãi, theo dõi thời gian tạo.

  PromotionModel({
    required this.promotionId,
    required this.promotionName,
    this.description,
    this.discountPercentage,
    this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.createdDate,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      promotionId: json['PromotionID'] as int,
      promotionName: json['PromotionName'] as String,
      description: json['Description'] as String?,
      discountPercentage: (json['DiscountPercentage'] as num?)?.toDouble(),
      imageUrl: json['ImageURL'] as String?,
      startDate: DateTime.parse(json['StartDate'] as String),
      endDate: DateTime.parse(json['EndDate'] as String),
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PromotionID': promotionId,
      'PromotionName': promotionName,
      'Description': description,
      'DiscountPercentage': discountPercentage,
      'ImageURL': imageUrl,
      'StartDate': startDate.toIso8601String(),
      'EndDate': endDate.toIso8601String(),
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}