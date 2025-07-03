import 'dart:convert';
import 'package:app_food_delivery/core/constants/api_route.dart';
import 'package:http/http.dart' as http;
import '../models/promotion_model.dart';

class PromotionService {


  static const String baseUrl = ApiRoute.getAllPromotions;

  // Lấy danh sách chương trình khuyến mãi
  Future<List<PromotionModel>> getPromotions() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => PromotionModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Không tải được chương trình khuyến mãi: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Lỗi nạp khuyến mãi: $e');
    }
  }

  // Lấy chương trình khuyến mãi theo ID
  Future<PromotionModel> getPromotion(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return PromotionModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Khuyến mãi với $id không được tìm thấy');
      } else {
        throw Exception(
          'Không tải được chương trình khuyến mãi: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Lỗi nạp khuyến mãi: $e');
    }
  }
}
