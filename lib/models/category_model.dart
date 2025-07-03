// CategoryModel: Chức năng quản lý danh mục sản phẩm (như Pizza, Đồ uống).
class CategoryModel {
  final int categoryId; // ID danh mục, khóa chính, tham chiếu trong Products.
  final String categoryName; // Tên danh mục, hiển thị trên giao diện.
  final DateTime createdDate; // Ngày tạo danh mục, theo dõi thời gian tạo.

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.createdDate,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['CategoryID'] as int,
      categoryName: json['CategoryName'] as String,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryID': categoryId,
      'CategoryName': categoryName,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}