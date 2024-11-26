import 'package:ecommerce_test/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_test/models/cart_page_model.dart';
import 'package:ecommerce_test/view_model/cart_pageviewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartPageViewModel(
        cartPageModel: CartPageModel(cartPageTitle: "Cart"),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable debug banner
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(), // Navigate to HomeScreen
      ),
    );
  }
}
