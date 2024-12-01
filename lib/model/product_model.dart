// models/product_model.dart
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  // Fungsi untuk mengonversi JSON menjadi objek ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }
}
