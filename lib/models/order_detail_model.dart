// OrderDetailModel: Chức năng quản lý chi tiết sản phẩm trong đơn hàng.
class OrderDetailModel {
  final int orderDetailId; // ID chi tiết đơn hàng, khóa chính.
  final int orderId; // ID đơn hàng, liên kết với Orders.
  final int productId; // ID sản phẩm, liên kết với Products.
  final int quantity; // Số lượng sản phẩm, dùng để tính giá.
  final String? size; // Kích thước sản phẩm (ví dụ: Nhỏ, Lớn).
  final String? crustType; // Loại đế (ví dụ: Dày, Mỏng).
  final double unitPrice; // Giá đơn vị sản phẩm, dùng để tính giá.
  final int? toppingId; // ID topping, liên kết với Toppings.
  final double toppingPrice; // Giá topping, dùng để tính giá.

  OrderDetailModel({
    required this.orderDetailId,
    required this.orderId,
    required this.productId,
    required this.quantity,
    this.size,
    this.crustType,
    required this.unitPrice,
    this.toppingId,
    required this.toppingPrice,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      orderDetailId: json['OrderDetailID'] as int,
      orderId: json['OrderID'] as int,
      productId: json['ProductID'] as int,
      quantity: json['Quantity'] as int,
      size: json['Size'] as String?,
      crustType: json['CrustType'] as String?,
      unitPrice: (json['UnitPrice'] as num).toDouble(),
      toppingId: json['ToppingID'] as int?,
      toppingPrice: (json['ToppingPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OrderDetailID': orderDetailId,
      'OrderID': orderId,
      'ProductID': productId,
      'Quantity': quantity,
      'Size': size,
      'CrustType': crustType,
      'UnitPrice': unitPrice,
      'ToppingID': toppingId,
      'ToppingPrice': toppingPrice,
    };
  }
}