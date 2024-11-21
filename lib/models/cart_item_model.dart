class CartItem {
  final String? id;
  final String productId;
  final String userId;
  final String name;
  int quantity;
  final double price;

  CartItem({
    this.id,
    required this.productId,
    required this.userId,
    required this.name,
    required this.quantity,
    required this.price,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      userId: map['userId'],
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0.0,
    );
  }
}
