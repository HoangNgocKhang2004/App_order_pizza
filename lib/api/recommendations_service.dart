import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_food_delivery/core/constants/api_route.dart';
import 'package:app_food_delivery/models/product_model.dart';

class RecommendationsService {
  static const String baseUrl = ApiRoute.getRecommendations;

  /// Lấy danh sách gợi ý cho productId
  Future<List<ProductModel>> getRecommendations(int productId) async {
    final uri = Uri.parse('$baseUrl/$productId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Không tải được gợi ý (status: ${response.statusCode})');
    }
  }
}
