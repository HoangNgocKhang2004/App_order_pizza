// OrderModel: Chức năng quản lý đơn hàng của người dùng.
class OrderModel {
  final int orderId; // ID đơn hàng, khóa chính, tham chiếu trong OrderDetails.
  final int userId; // ID người dùng, liên kết với Users.
  final int? addressId; // ID địa chỉ giao hàng, liên kết với Addresses.
  final DateTime orderDate; // Ngày đặt hàng, theo dõi thời gian đặt.
  final double totalAmount; // Tổng giá trị đơn hàng, hiển thị trên giao diện.
  final String status; // Trạng thái đơn hàng (ví dụ: Đang xử lý, Đã giao).
  final String paymentMethod; // Phương thức thanh toán (ví dụ: Tiền mặt, Thẻ).
  final double shippingFee; // Phí vận chuyển, dùng để tính tổng giá trị.
  final int? promotionId; // ID khuyến mãi, liên kết với Promotions.
  final DateTime createdDate; // Ngày tạo đơn hàng, theo dõi thời gian tạo.

  OrderModel({
    required this.orderId,
    required this.userId,
    this.addressId,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.shippingFee,
    this.promotionId,
    required this.createdDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['OrderID'] as int,
      userId: json['UserID'] as int,
      addressId: json['AddressID'] as int?,
      orderDate: DateTime.parse(json['OrderDate'] as String),
      totalAmount: (json['TotalAmount'] as num).toDouble(),
      status: json['Status'] as String,
      paymentMethod: json['PaymentMethod'] as String,
      shippingFee: (json['ShippingFee'] as num).toDouble(),
      promotionId: json['PromotionID'] as int?,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OrderID': orderId,
      'UserID': userId,
      'AddressID': addressId,
      'OrderDate': orderDate.toIso8601String(),
      'TotalAmount': totalAmount,
      'Status': status,
      'PaymentMethod': paymentMethod,
      'ShippingFee': shippingFee,
      'PromotionID': promotionId,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}