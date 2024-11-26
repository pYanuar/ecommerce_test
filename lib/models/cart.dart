class Cart {
  final int id;
  final int userId;
  final String date;
  final List<Product> products;

  Cart(
      {required this.id,
      required this.userId,
      required this.date,
      required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Product> productsList = list.map((i) => Product.fromJson(i)).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: productsList,
    );
  }
}

class Product {
  final int productId;
  final int quantity;

  Product({required this.productId, required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
