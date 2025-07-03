// SuggestionModel: Chức năng gợi ý sản phẩm liên quan cho người dùng.
class SuggestionModel {
  final int suggestionId; // ID gợi ý, khóa chính.
  final int productId; // ID sản phẩm gốc, liên kết với Products.
  final int suggestedProductId; // ID sản phẩm gợi ý, liên kết với Products.
  final double confidence; // Độ tin cậy của gợi ý, từ 0-100.
  final DateTime createdDate; // Ngày tạo gợi ý, theo dõi thời gian.

  SuggestionModel({
    required this.suggestionId,
    required this.productId,
    required this.suggestedProductId,
    required this.confidence,
    required this.createdDate,
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      suggestionId: json['SuggestionID'] as int,
      productId: json['ProductID'] as int,
      suggestedProductId: json['SuggestedProductID'] as int,
      confidence: (json['Confidence'] as num).toDouble(),
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SuggestionID': suggestionId,
      'ProductID': productId,
      'SuggestedProductID': suggestedProductId,
      'Confidence': confidence,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}