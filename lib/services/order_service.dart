import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/models/cart_item_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder(List<CartItem> cartItems, double totalAmount,
      String fullName, String adress, String phoneNumber) async {
    try {
      final order = OrderModel(
        id: DateTime.now().toString(),
        fullName: fullName,
        adress: adress,
        phoneNumber: phoneNumber,
        items: cartItems,
        totalAmount: totalAmount,
        dateTime: DateTime.now(),
      );
      await _firestore.collection('orders').add(order.toMap());
    } catch (e) {
      throw Exception("Error placing order: $e");
    }
  }

  Future<List<OrderModel>> fetchOrders() async {
    try {
      final snapshot = await _firestore.collection('orders').get();
      return snapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Error fetching orders: $e");
    }
  }
}
