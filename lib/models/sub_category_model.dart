// SubCategoryModel: Chức năng quản lý danh mục con của sản phẩm (như Pizza Hải sản).
class SubCategoryModel {
  final int subCategoryId; // ID danh mục con, khóa chính, tham chiếu trong Products.
  final int categoryId; // ID danh mục cha, liên kết với Categories.
  final String subCategoryName; // Tên danh mục con, hiển thị trên giao diện.
  final DateTime createdDate; // Ngày tạo danh mục con, theo dõi thời gian tạo.

  SubCategoryModel({
    required this.subCategoryId,
    required this.categoryId,
    required this.subCategoryName,
    required this.createdDate,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      subCategoryId: json['SubCategoryID'] as int,
      categoryId: json['CategoryID'] as int,
      subCategoryName: json['SubCategoryName'] as String,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SubCategoryID': subCategoryId,
      'CategoryID': categoryId,
      'SubCategoryName': subCategoryName,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}