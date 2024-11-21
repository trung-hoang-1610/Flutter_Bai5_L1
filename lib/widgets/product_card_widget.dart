import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/cart_bloc.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                product.description,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      _showQuantityDialog(context, product);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showQuantityDialog(BuildContext context, Product product) async {
  final quantityController = TextEditingController(text: '1');

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Chọn số lượng"),
        content: TextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Số lượng",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text) ?? 1;

              BlocProvider.of<CartBloc>(context).add(
                AddItemToCart(
                  cartItem: CartItem(
                    productId: product.id!,
                    name: product.name,
                    quantity: quantity,
                    price: product.price,
                    userId: '1',
                  ),
                ),
              );

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.name} đã được thêm vào giỏ hàng!"),
                ),
              );
            },
            child: const Text("Thêm vào giỏ"),
          ),
        ],
      );
    },
  );
}
