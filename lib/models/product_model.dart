// ProductModel: Chức năng quản lý thông tin sản phẩm (như Pizza, Đồ uống).
class ProductModel {
  final int productId; // ID sản phẩm, khóa chính, tham chiếu trong OrderDetails.
  final String productName; // Tên sản phẩm, hiển thị trên giao diện.
  final String? description; // Mô tả sản phẩm, hiển thị chi tiết sản phẩm.
  final double price; // Giá sản phẩm, dùng để tính toán đơn hàng.
  final int categoryId; // ID danh mục, liên kết với Categories.
  final int? subCategoryId; // ID danh mục con, liên kết với SubCategories.
  final String? imageUrl; // URL ảnh sản phẩm, hiển thị trên giao diện.
  final DateTime createdDate; // Ngày tạo sản phẩm, theo dõi thời gian tạo.

  ProductModel({
    required this.productId,
    required this.productName,
    this.description,
    required this.price,
    required this.categoryId,
    this.subCategoryId,
    this.imageUrl,
    required this.createdDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['ProductID'] as int,
      productName: json['ProductName'] as String,
      description: json['Description'] as String?,
      price: (json['Price'] as num).toDouble(),
      categoryId: json['CategoryID'] as int,
      subCategoryId: json['SubCategoryID'] as int?,
      imageUrl: json['ImageURL'] as String?,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductID': productId,
      'ProductName': productName,
      'Description': description,
      'Price': price,
      'CategoryID': categoryId,
      'SubCategoryID': subCategoryId,
      'ImageURL': imageUrl,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}