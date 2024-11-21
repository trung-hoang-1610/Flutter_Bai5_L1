import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/blocs/order_bloc.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Gọi FetchOrders khi vào màn hình OrderHistory
    context.read<OrderBloc>().add(FetchOrders());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.orders.isEmpty) {
            return const Center(child: Text("No orders yet"));
          }
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text("Order ID: ${order.id}"),
                  subtitle: Text("Total: \$${order.totalAmount}"),
                  trailing: Text(order.dateTime.toLocal().toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
