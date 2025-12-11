import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_project_files/models/food_item.dart';

class FoodService {
  // IMPORTANT: Your laptop WiFi IPv4 from ipconfig
  static const String baseUrl = "http://10.200.137.75:5000/api";

  /// Fetch drinks or any products by primary_category.
  static Future<FoodResponse> fetchFoods({
    String primaryCategory = "drinks",
    int page = 0,
    int limit = 24,
    String? q,
    String? nutriscore,
    int? novaGroup,
  }) async {
    final uri = Uri.parse("$baseUrl/food").replace(
      queryParameters: {
        "primary_category": primaryCategory,
        "page": page.toString(),
        "limit": limit.toString(),
        if (q != null && q.isNotEmpty) "q": q,
        if (nutriscore != null && nutriscore.isNotEmpty) "nutriscore": nutriscore,
        if (novaGroup != null) "nova_group": novaGroup.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch foods (${response.statusCode})");
    }

    final Map<String, dynamic> jsonData = json.decode(response.body);

    if (jsonData["ok"] != true) {
      throw Exception("API returned error: ${jsonData["error"]}");
    }

    final List<dynamic> data = jsonData["data"] ?? [];
    final meta = jsonData["meta"] ?? {};

    final foods = data.map((item) => FoodItem.fromJson(item)).toList();

    return FoodResponse(
      foods: foods,
      total: meta["total"] ?? foods.length,
      page: meta["page"] ?? 0,
      limit: meta["limit"] ?? limit,
    );
  }
}

/// Wrapper for paginated API results.
class FoodResponse {
  final List<FoodItem> foods;
  final int total;
  final int page;
  final int limit;

  bool get hasMore => (page + 1) * limit < total;

  FoodResponse({
    required this.foods,
    required this.total,
    required this.page,
    required this.limit,
  });
}
