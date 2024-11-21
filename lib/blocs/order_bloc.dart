import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/order_model.dart';
import '../services/order_service.dart';

class OrderState {
  final List<OrderModel> orders;
  OrderState(this.orders);
}

class OrderEvent {}

class PlaceOrder extends OrderEvent {
  final List<CartItem> cartItems;
  final double totalAmount;
  final String fullName;
  final String adress;
  final String phoneNumber;
  PlaceOrder({
    required this.cartItems,
    required this.totalAmount,
    required this.fullName,
    required this.adress,
    required this.phoneNumber,
  });
}

class FetchOrders extends OrderEvent {}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderService _orderService = OrderService();

  OrderBloc() : super(OrderState([])) {
    on<PlaceOrder>((event, emit) async {
      try {
        await _orderService.placeOrder(event.cartItems, event.totalAmount,
            event.fullName, event.adress, event.phoneNumber);

        final orders = await _orderService.fetchOrders();
        emit(OrderState(orders));
      } catch (e) {
        print("Error placing order: $e");
      }
    });

    on<FetchOrders>((event, emit) async {
      try {
        final orders = await _orderService.fetchOrders();
        emit(OrderState(orders));
      } catch (e) {
        print("Error fetching orders: $e");
        emit(OrderState([]));
      }
    });
  }
}
