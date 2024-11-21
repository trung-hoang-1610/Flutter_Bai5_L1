import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/cart_item_model.dart';

class CartService {
  static const String cartKey = 'cart';

  Future<void> addItemToCart(CartItem cartItem, int quantity) async {
    final cartRef =
        FirebaseFirestore.instance.collection('carts').doc(cartItem.userId);

    final cartSnapshot = await cartRef.get();

    if (cartSnapshot.exists) {
      List<dynamic> cartList = cartSnapshot.data()!['items'];
      List<CartItem> cartItems = cartList
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList();

      int existingItemIndex =
          cartItems.indexWhere((item) => item.productId == cartItem.productId);

      if (existingItemIndex >= 0) {
        cartItems[existingItemIndex].quantity += cartItem.quantity;
      } else {
        cartItems.add(cartItem);
      }

      List<Map<String, dynamic>> updatedCartList =
          cartItems.map((item) => item.toMap()).toList();

      await cartRef.update({'items': updatedCartList});
    } else {
      await cartRef.set({
        'items': [cartItem.toMap()],
      });
    }
  }

  Future<List<CartItem>> getCartItems(String userId) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(userId);
    final cartSnapshot = await cartRef.get();

    if (cartSnapshot.exists) {
      List<dynamic> cartList = cartSnapshot.data()!['items'];
      List<CartItem> cartItems = cartList
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList();

      return cartItems;
    } else {
      return [];
    }
  }

  Future<void> updateItemQuantity(
      String productId, String userId, int quantity) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(userId);
    final cartSnapshot = await cartRef.get();

    if (cartSnapshot.exists) {
      List<dynamic> cartList = cartSnapshot.data()!['items'];
      List<Map<String, dynamic>> updatedCartList = cartList.map((item) {
        if (item['productId'] == productId) {
          item['quantity'] = quantity; // Cập nhật số lượng mới
        }
        return item as Map<String, dynamic>;
      }).toList();

      await cartRef.update({'items': updatedCartList});
    }
  }

  Future<void> removeItemFromCart(String productId, String userId) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(userId);

    // Lấy giỏ hàng hiện tại
    final cartSnapshot = await cartRef.get();
    if (cartSnapshot.exists) {
      List<dynamic> cartList = cartSnapshot.data()!['items'];
      List<CartItem> cartItems = cartList
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList();

      cartItems.removeWhere((item) => item.productId == productId);

      List<Map<String, dynamic>> updatedCartList =
          cartItems.map((item) => item.toMap()).toList();
      await cartRef.update({'items': updatedCartList});
    }
  }

  Future<void> clearCart(String userId) async {
    final cartRef = FirebaseFirestore.instance.collection('carts').doc(userId);
    await cartRef.delete();
  }
}
