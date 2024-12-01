import 'package:flutter/material.dart';
import 'package:ecommerce_test/view_model/cart_pageviewmodel.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final CartPageViewModel cartPageViewModel;

  const CartPage({super.key, required this.cartPageViewModel});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final userIdController = TextEditingController();
  final dateController = TextEditingController();
  final productIdController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.cartPageViewModel.fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.cartPageViewModel.cartPageModel.cartPageTitle)),
      body: Column(
        children: [
          // Form to add a new cart
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add a new Cart',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(labelText: 'User ID'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: dateController,
                  decoration:
                      const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                ),
                TextField(
                  controller: productIdController,
                  decoration: const InputDecoration(labelText: 'Product ID'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (userIdController.text.isEmpty ||
                        dateController.text.isEmpty ||
                        productIdController.text.isEmpty ||
                        quantityController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill in all fields')));
                      return;
                    }

                    final userId = int.tryParse(userIdController.text);
                    final date = dateController.text;
                    final productId = int.tryParse(productIdController.text);
                    final quantity = int.tryParse(quantityController.text);

                    if (userId == null ||
                        productId == null ||
                        quantity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter valid numbers')));
                      return;
                    }

                    final newCartData = {
                      'userId': userId,
                      'date': date,
                      'products': [
                        {'productId': productId, 'quantity': quantity}
                      ],
                    };

                    widget.cartPageViewModel.addCart(newCartData);

                    userIdController.clear();
                    dateController.clear();
                    productIdController.clear();
                    quantityController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Cart added successfully')));
                  },
                  child: const Text('Add Cart'),
                ),
              ],
            ),
          ),
          // Display cart list after addCart
          Expanded(
            child: Consumer<CartPageViewModel>(
              builder: (context, viewModel, child) {
                final cartList = viewModel.cartList;
                return cartList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          final cart = cartList[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cart ID: ${cart.id}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('User ID: ${cart.userId}'),
                                  Text('Date: ${cart.date}'),
                                  const SizedBox(height: 10),
                                  const Text('Products:'),
                                  for (var product in cart.products)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                          'Product ID: ${product.productId}, Quantity: ${product.quantity}'),
                                    ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () async {
                                        await widget.cartPageViewModel
                                            .deleteCart(cart.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('Cart deleted')));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
