import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/cart_bloc.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/screens/order_form_screen.dart';
import 'package:shopping_app/services/product_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return FutureBuilder<List<CartItem>>(
            future: state.cartItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error loading cart items."));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Your cart is empty."));
              } else {
                final cartItems = snapshot.data!;
                double totalCartPrice = cartItems.fold(
                  0,
                  (total, item) => total + item.price * item.quantity,
                );

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading: FutureBuilder<String>(
                                future: productService
                                    .getImageUrl(cartItem.productId),
                                builder: (context, imageSnapshot) {
                                  if (imageSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (imageSnapshot.hasError ||
                                      !imageSnapshot.hasData) {
                                    return const Icon(Icons.image);
                                  } else {
                                    return Image.network(
                                      imageSnapshot.data!,
                                      fit: BoxFit.cover,
                                    );
                                  }
                                },
                              ),
                              title: Text(cartItem.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price: \$${cartItem.price}"),
                                  Text(
                                      "Total: \$${cartItem.price * cartItem.quantity}"),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (cartItem.quantity > 1) {
                                        BlocProvider.of<CartBloc>(context).add(
                                          UpdateItemQuantity(
                                            productId: cartItem.productId,
                                            userId: cartItem.userId,
                                            quantity: cartItem.quantity - 1,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Text(cartItem.quantity.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context).add(
                                        UpdateItemQuantity(
                                          productId: cartItem.productId,
                                          userId: cartItem.userId,
                                          quantity: cartItem.quantity + 1,
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // Xóa sản phẩm khỏi giỏ hàng
                                      BlocProvider.of<CartBloc>(context).add(
                                        RemoveItemFromCart(
                                          productId: cartItem.productId,
                                          userId: cartItem.userId,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${totalCartPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderFormScreen(
                                      cartItems: cartItems,
                                      totalAmount: totalCartPrice,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: const Text(
                                "Proceed to Checkout",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
