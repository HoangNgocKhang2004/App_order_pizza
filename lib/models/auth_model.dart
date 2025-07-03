//# 👤 Thông tin người dùng (id, tên, email, số điện thoại)

class LoginRequest {
  final String email;
  final String password;
  LoginRequest({required this.email, required this.password});
  Map<String, dynamic> toJson() => {'Email': email, 'Password': password};
}

class LoginReponse {
  final String token;
  LoginReponse({required this.token});
  factory LoginReponse.fromJson(Map<String, dynamic> json) {
    return LoginReponse(token: json['token'] ?? '');
  }
}

class RegisterRequest {
  final String username;
  final String phone;
  final String email;
  final String password;

  RegisterRequest({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() => {
    'Username': username,
    'email': email,
    'phone': phone,
    'passwordHash': password,
  };
}

class RegisterReponse {
  final String token;
  RegisterReponse({required this.token});
  factory RegisterReponse.fromJson(Map<String, dynamic> json) {
    return RegisterReponse(token: json['token'] ?? '');
  }
}
