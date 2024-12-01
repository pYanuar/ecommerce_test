// view_models/product_view_model.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductViewModel {
  List<ProductModel> products = [];

  // Fungsi untuk memfetch data dari API
  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      // Jika respons sukses, konversi data JSON ke objek ProductModel
      final List<dynamic> data = json.decode(response.body);
      products = data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
