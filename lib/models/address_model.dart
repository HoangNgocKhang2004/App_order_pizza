// AddressModel: Chức năng quản lý địa chỉ giao hàng của người dùng.
class AddressModel {
  final int addressId; // ID địa chỉ, khóa chính, tham chiếu trong Orders.
  final int userId; // ID người dùng, liên kết với Users.
  final String addressName; // Tên địa chỉ, hiển thị khi chọn giao hàng.
  final bool isDefault; // Địa chỉ mặc định, ưu tiên khi đặt hàng.
  final DateTime createdDate; // Ngày tạo địa chỉ, theo dõi thời gian tạo.

  AddressModel({
    required this.addressId,
    required this.userId,
    required this.addressName,
    required this.isDefault,
    required this.createdDate,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressId: json['AddressID'] as int,
      userId: json['UserID'] as int,
      addressName: json['AddressName'] as String,
      isDefault: json['IsDefault'] == 1,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AddressID': addressId,
      'UserID': userId,
      'AddressName': addressName,
      'IsDefault': isDefault ? 1 : 0,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}