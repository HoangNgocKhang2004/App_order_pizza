import 'package:app_food_delivery/core/constants/api_route.dart';
import 'package:app_food_delivery/models/sub_category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubCategoryService {
  String baseUrl = ApiRoute.getAllSubCategories; // Đường dẫn API để lấy danh sách sản phẩm phụ
  // Lấy danh sách sản phẩm phụ
  Future<List<SubCategoryModel>> getSubCategories() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => SubCategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Không tải được danh sách danh mục phụ: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi nạp danh sách danh mục phụ: $e');
    }
  }

  // Lấy danh mục phụ theo ID
  Future<SubCategoryModel> getSubCategory(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return SubCategoryModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Danh mục phụ với $id không được tìm thấy');
      } else {
        throw Exception('Không tải được danh mục phụ: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi nạp danh mục phụ: $e');
    }
  }
}