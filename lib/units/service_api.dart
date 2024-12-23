import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://world.openfoodfacts.org/cgi/search.pl';

 static Future<List<Product>> searchProducts(String query) async {
    try {
      final url = Uri.parse(
          '$baseUrl?search_terms=$query&search_simple=1&json=1&fields=product_name,product_name_en,image_url,nutriments,ingredients_text,ingredients_text_en,allergens,allergens_en');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['products'] != null && data['products'] is List) {
          return (data['products'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception(
            'Failed to load products, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
