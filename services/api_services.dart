import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_project_test/models/product_mode.dart';

class ApiService {
  static const baseUrl = 'https://fakestoreapi.com';


  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$baseUrl/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        return data.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
