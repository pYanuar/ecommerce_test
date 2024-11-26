import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Sample data for order summary (replace with real data from cart)
  final List<Map<String, dynamic>> orderItems = [
    {"name": "Product 1", "price": 20.0, "quantity": 1},
    {"name": "Product 2", "price": 15.0, "quantity": 2},
    {"name": "Product 3", "price": 30.0, "quantity": 1},
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = orderItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary Section
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Qty: ${item['quantity']}'),
                    trailing: Text(
                        '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Shipping Information Section
              const Text(
                'Shipping Information',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _zipController,
                decoration: const InputDecoration(labelText: 'ZIP Code'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              // Payment Section
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Credit Card'),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: 'Credit Card',
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: const Text('PayPal'),
                leading: Radio<String>(
                  value: 'PayPal',
                  groupValue: 'PayPal',
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),

              // Total Price Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Centered Elevated Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle checkout action
                    // e.g., navigate to confirmation screen or payment gateway
                  },
                  child: const Text('Complete Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Button style for ElevatedButton
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue, // Material Design blue color
  padding: const EdgeInsets.symmetric(
      vertical: 16, horizontal: 32), // Vertically larger padding
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)), // Rounded corners
  ),
  textStyle:
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Text style
);
