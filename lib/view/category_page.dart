// pages/category_page.dart

import 'package:ecommerce_test/view_model/category_pageviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_test/model/category_model.dart';

class CategoryPage extends StatefulWidget {
  final CategoryPageViewModel categoryPageViewModel;

  const CategoryPage({super.key, required this.categoryPageViewModel});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi fetchCategories() saat halaman pertama kali ditampilkan
    _categoriesFuture = widget.categoryPageViewModel.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.categoryPageViewModel.getCategoryPageName()),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found'));
          }

          // Menampilkan daftar kategori dalam ListView
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              CategoryModel category = snapshot.data![index];

              return Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    category.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Menambahkan aksi saat kategori dipilih
                    // Misalnya, navigasi ke halaman produk berdasarkan kategori
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
