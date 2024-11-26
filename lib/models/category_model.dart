// models/category_model.dart

class CategoryModel {
  final String name;

  CategoryModel({required this.name});

  // Fungsi untuk membuat CategoryModel dari Map
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
    );
  }

  // Fungsi untuk mengubah CategoryModel ke dalam bentuk Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
