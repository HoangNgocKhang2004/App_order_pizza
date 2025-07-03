import 'package:app_food_delivery/core/constants/api_route.dart';
import 'package:app_food_delivery/models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = ApiRoute.getAllProducts; // Đường dẫn API để lấy danh sách sản phẩm
  
   // Lấy danh sách sản phẩm
  Future<List<ProductModel>> getProducts() async {
    try {
      final respone = await http.get(Uri.parse(baseUrl));
        if(respone.statusCode == 200) {
          final List<dynamic> data = jsonDecode(respone.body);
          return data.map((json) => ProductModel.fromJson(json)).toList();
        } else {
          throw Exception('Không tải được sản phẩm: ${respone.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi nạp sản phẩm: $e');
    }
  }

  // Lấy sản phẩm theo ID
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Sản phẩm với $id không được tìm thấy');
      } else {
        throw Exception('Không tải được sản phẩm: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi nạp sản phẩm: $e');
    }
  }
}