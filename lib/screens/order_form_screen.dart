import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/order_bloc.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/screens/order_history_screen.dart';

class OrderFormScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const OrderFormScreen(
      {super.key, required this.cartItems, required this.totalAmount});

  @override
  // ignore: library_private_types_in_public_api
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumber = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      BlocProvider.of<OrderBloc>(context).add(
        PlaceOrder(
          fullName: _nameController.text,
          adress: _addressController.text,
          phoneNumber: _phoneNumber.text,
          cartItems: widget.cartItems,
          totalAmount: widget.totalAmount,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderHistoryScreen(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Form"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phoneNumber';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
