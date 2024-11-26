// view_models/category_page_view_model.dart

import 'dart:convert';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryPageViewModel {
  final String categoryPageName;

  CategoryPageViewModel({required this.categoryPageName});

  // Fungsi untuk mengambil kategori dari API
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => CategoryModel(name: category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  String getCategoryPageName() {
    return categoryPageName;
  }
}
