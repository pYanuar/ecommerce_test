import 'dart:convert';
import 'package:ecommerce_test/model/cart.dart';
import 'package:ecommerce_test/model/cart_page_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPageViewModel extends ChangeNotifier {
  final CartPageModel cartPageModel;
  List<Cart> _cartList = [];

  CartPageViewModel({required this.cartPageModel});

  List<Cart> get cartList => _cartList;

  // Fetch cart data from API
  Future<void> fetchCartData() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/carts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _cartList = data.map((cartData) => Cart.fromJson(cartData)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load carts');
      }
    } catch (e) {
      print("Error fetching carts: $e");
    }
  }

  // Add a cart
  Future<void> addCart(Map<String, dynamic> newCartData) async {
    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/carts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newCartData),
      );

      if (response.statusCode == 200) {
        final newCart = json.decode(response.body);
        _cartList.add(Cart.fromJson(newCart));
        notifyListeners();
      } else {
        throw Exception('Failed to add cart');
      }
    } catch (e) {
      print("Error adding cart: $e");
    }
  }

  // Delete a cart by ID
  Future<void> deleteCart(int cartId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://fakestoreapi.com/carts/$cartId'),
      );

      if (response.statusCode == 200) {
        _cartList.removeWhere((cart) => cart.id == cartId);
        notifyListeners();
      } else {
        throw Exception('Failed to delete cart');
      }
    } catch (e) {
      print("Error deleting cart: $e");
    }
  }
}
