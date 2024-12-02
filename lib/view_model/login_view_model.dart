import 'dart:convert';
import 'package:ecommerce_test/model/login_response.dart';
import 'package:http/http.dart' as http;

class LoginViewModel {
  Future<LoginResponse?> login(String username, String password) async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return LoginResponse.fromJson(responseData);
    } else {
      // Tangani error atau status code yang berbeda
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}
