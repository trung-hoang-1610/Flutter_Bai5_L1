import 'package:flutter/material.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/blocs/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(product: product),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Product'),
                    content: const Text(
                      'Are you sure you want to delete this product?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(DeleteProduct(productId: product.id));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${product.name} deleted")),
                          );
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),
            // ElevatedButton(
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text("${product.name} added to cart!")),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            //     textStyle: TextStyle(fontSize: 18),
            //   ),
            //   child: const Text("Add to Cart"),
            // ),
          ],
        ),
      ),
    );
  }
}
