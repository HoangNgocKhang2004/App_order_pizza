class RankingModel {
  final int productId;
  final String productName;
  final double averageRating;
  final int rankPosition;
  final String period;
  final DateTime createdDate;

  RankingModel({
    required this.productId,
    required this.productName,
    required this.averageRating,
    required this.rankPosition,
    required this.period,
    required this.createdDate,
  });

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      rankPosition: json['rankPosition'] as int,
      period: json['period'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'averageRating': averageRating,
        'rankPosition': rankPosition,
        'period': period,
        'createdDate': createdDate.toIso8601String(),
      };
}
