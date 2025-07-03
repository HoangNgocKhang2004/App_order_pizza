import 'dart:convert';
import 'package:app_food_delivery/models/ranking_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_food_delivery/core/constants/api_route.dart';

class RankingService {
  static const String baseUrl = ApiRoute.getRanking;

  Future<List<RankingModel>> fetchRankings({String period = 'Weekly'}) async {
    final uri = Uri.parse('$baseUrl/generate?period=$period');
    final resp = await http.post(uri);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(resp.body);
      final List<dynamic>? arr = body['rankings'] as List<dynamic>?;
      if (arr == null) {
        throw Exception('Không có dữ liệu thứ hạng');
      }
      return arr
          .map((e) => RankingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (resp.statusCode == 204) {
      return []; // No Content
    } else {
      throw Exception('Không thể load danh sách thứ hạng (${resp.statusCode})');
    }
  }
}
