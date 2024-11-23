import 'package:shopping_app/models/cart_item_model.dart';

class OrderModel {
  final String? id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime dateTime;
  final String fullName;
  final String adress;
  final String phoneNumber;

  OrderModel({
    required this.fullName,
    required this.adress,
    required this.phoneNumber,
    this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'adress': adress,
      'phoneNumber': phoneNumber,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      adress: map['adress'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      items: List<CartItem>.from((map['items'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))),
      totalAmount: map['totalAmount'] ?? 0.0,
      dateTime:
          DateTime.parse(map['dateTime'] ?? DateTime.now().toIso8601String()),
    );
  }
}
