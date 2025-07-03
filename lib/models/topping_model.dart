// ToppingModel: Chức năng quản lý topping cho sản phẩm (như Phô mai, Xúc xích).
class ToppingModel {
  final int toppingId; // ID topping, khóa chính, tham chiếu trong OrderDetails.
  final String toppingName; // Tên topping, hiển thị trên giao diện.
  final double price; // Giá topping, dùng để tính toán đơn giá.
  final int productId; // ID sản phẩm, liên kết với Products.
  final DateTime createdDate; // Ngày tạo topping, theo dõi thời gian tạo.

  ToppingModel({
    required this.toppingId,
    required this.toppingName,
    required this.price,
    required this.productId,
    required this.createdDate,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      toppingId: json['ToppingID'] as int,
      toppingName: json['ToppingName'] as String,
      price: (json['Price'] as num).toDouble(),
      productId: json['ProductID'] as int,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ToppingID': toppingId,
      'ToppingName': toppingName,
      'Price': price,
      'ProductID': productId,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}