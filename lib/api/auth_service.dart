import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_food_delivery/models/auth_model.dart';
import 'package:app_food_delivery/core/constants/api_route.dart';

class AuthService {
  Future<LoginReponse> login(String email, String password) async {
    final url = Uri.parse(ApiRoute.login);
    final request = LoginRequest(email: email, password: password);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    // print('Status: ${response.statusCode}, Body: ${response.body}');
    if (response.statusCode == 200) {
      print('Đăng nhập thành công');
      return LoginReponse.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body)['message'];
      print(error);
      throw Exception(error);
    }
  }

  Future<RegisterReponse> register(
    String username,
    String phone,
    String email,
    String password,
  ) async {
    final url = Uri.parse(ApiRoute.register);
    final request = RegisterRequest(
      username: username,
      phone: phone,
      email: email,
      password: password,
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      print('Đăng ký thành công');
      return RegisterReponse.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body)['message'];
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> getCurrentUser(String token) async {
    final url = Uri.parse('${ApiRoute.baseUrl}/api/Auth/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('GetCurrentUser status: ${response.statusCode}');
    print('GetCurrentUser body: ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Không thể lấy thông tin người dùng');
    }
  }
}
