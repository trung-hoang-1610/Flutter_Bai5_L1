import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import '../services/cart_service.dart';

class CartState {
  final Future<List<CartItem>> cartItems;
  CartState(this.cartItems);
}

class CartEvent {}

class AddItemToCart extends CartEvent {
  final CartItem cartItem;
  AddItemToCart({required this.cartItem});
}

class UpdateItemQuantity extends CartEvent {
  final String productId;
  final String userId;
  final int quantity;

  UpdateItemQuantity({
    required this.productId,
    required this.userId,
    required this.quantity,
  });
}

class RemoveItemFromCart extends CartEvent {
  final String productId;
  final String userId;
  RemoveItemFromCart({required this.productId, required this.userId});
}

class ClearCart extends CartEvent {
  final String userId;
  ClearCart({required this.userId});
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService = CartService();

  CartBloc() : super(CartState(Future.value([]))) {
    on<AddItemToCart>((event, emit) async {
      await _cartService.addItemToCart(event.cartItem, event.cartItem.quantity);

      emit(CartState(_cartService.getCartItems(event.cartItem.userId)));
    });

    on<RemoveItemFromCart>((event, emit) async {
      await _cartService.removeItemFromCart(event.productId, event.userId);

      emit(CartState(_cartService.getCartItems(event.userId)));
    });

    on<ClearCart>((event, emit) async {
      await _cartService.clearCart(event.userId);

      emit(CartState(Future.value([])));
    });
    on<UpdateItemQuantity>((event, emit) async {
      await _cartService.updateItemQuantity(
          event.productId, event.userId, event.quantity);
      emit(CartState(_cartService.getCartItems(event.userId)));
    });
  }
}
