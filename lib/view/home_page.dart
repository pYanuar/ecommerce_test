import 'package:ecommerce_test/view_model/product_viewmodel.dart';
import 'package:flutter/material.dart';
import '../model/product_model.dart';

class HomePage extends StatefulWidget {
  final ProductViewModel productViewModel;

  const HomePage({super.key, required this.productViewModel});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = widget.productViewModel.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung tinggi BottomNavigationBar agar bisa diberikan padding yang sesuai
    double bottomPadding = MediaQuery.of(context).viewInsets.bottom + 60.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Product'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<void>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom:
                      bottomPadding), // Menambahkan padding bawah untuk memberi ruang bagi BottomNavigationBar
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Menampilkan 2 item per baris
                  crossAxisSpacing: 8.0, // Jarak antar item
                  mainAxisSpacing: 8.0, // Jarak antar baris
                  childAspectRatio:
                      0.75, // Menyesuaikan rasio tinggi dan lebar item
                ),
                itemCount: widget.productViewModel.products.length,
                itemBuilder: (context, index) {
                  ProductModel product =
                      widget.productViewModel.products[index];

                  return Card(
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          product.image,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('\$${product.price}',
                                  style: const TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
