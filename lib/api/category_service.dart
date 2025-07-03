import 'package:app_food_delivery/core/constants/api_route.dart';
import 'package:app_food_delivery/models/category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  String baseUrl = ApiRoute.getAllCategories; // Đường dẫn API để lấy danh sách sản phẩm
  // Lấy danh sách chương trình khuyến mãi
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Không tải được danh sách danh mục: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi nạp danh sách danh mục: $e');
    }
  }
  // Lấy danh mục theo ID
  Future<CategoryModel> getCategory(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Danh mục với $id không được tìm thấy');
      } else {
        throw Exception('Không tải được danh mục: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi nạp danh mục: $e');
    }
  }
}