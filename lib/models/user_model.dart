// UserModel: Chức năng đăng nhập, đăng ký và quản lý thông tin người dùng.
class UserModel {
  final int userId; // ID người dùng, khóa chính, tham chiếu trong Orders, Addresses.
  final String username; // Tên người dùng, dùng để đăng nhập hoặc hiển thị.
  final String email; // Email, dùng để đăng nhập hoặc gửi thông báo.
  final String phone; // Số điện thoại, dùng để liên hệ hoặc xác thực.
  final String passwordHash; // Mật khẩu mã hóa, dùng để xác thực đăng nhập.
  final String? profilePicture; // URL ảnh đại diện, hiển thị trong hồ sơ.
  final DateTime createdDate; // Ngày tạo tài khoản, theo dõi thời gian tạo.

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.passwordHash,
    this.profilePicture,
    required this.createdDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['UserID'] as int,
      username: json['UserName'] as String,
      email: json['Email'] as String,
      phone: json['Phone'] as String,
      passwordHash: json['PasswordHash'] as String,
      profilePicture: json['ProfilePicture'] as String?,
      createdDate: DateTime.parse(json['CreatedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'Username': username,
      'Email': email,
      'Phone': phone,
      'PasswordHash': passwordHash,
      'ProfilePicture': profilePicture,
      'CreatedDate': createdDate.toIso8601String(),
    };
  }
}