// import 'dart:convert';
// import 'package:app_food_delivery/models/auth_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:app_food_delivery/core/constants/api_route.dart';

// class ApiService {
//   Future<LoginReponse> login(String email, String password) async {
//     final url = Uri.parse(ApiRoute.login);
//     final request = LoginRequest(email: email, password: password);

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(request.toJson()),
//     );
//     // print('Status: ${response.statusCode}, Body: ${response.body}');
//     if (response.statusCode == 200) {
//       print('Đăng nhập thành công');
//       return LoginReponse.fromJson(jsonDecode(response.body));
//     } else {
//       final error = jsonDecode(response.body)['message'];
//       throw Exception(error);
//     }
//   }

//   Future<RegisterReponse> register(
//     String username,
//     String phone,
//     String email,
//     String password,
//   ) async {
//     final url = Uri.parse(ApiRoute.register);
//     final request = RegisterRequest(
//       username: username,
//       phone: phone,
//       email: email,
//       password: password,
//     );

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(request.toJson()),
//     );
//     print('Status Code: ${response.statusCode}');
//     print('Response Body: ${response.body}');
//     if (response.statusCode == 200) {
//       print('Đăng ký thành công');
//       return RegisterReponse.fromJson(jsonDecode(response.body));
//     } else {
//       final error = jsonDecode(response.body)['message'];
//       throw Exception(error);
//     }
//   }
// }
