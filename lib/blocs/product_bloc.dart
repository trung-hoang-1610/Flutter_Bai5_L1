import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/product_model.dart';
import '../services/product_service.dart';

class ProductState {
  final List<Product> products;
  ProductState(this.products);
}

class ProductEvent {}

class FetchProducts extends ProductEvent {}

class CreateProduct extends ProductEvent {
  final Product product;
  CreateProduct({required this.product});
}

class UpdateProduct extends ProductEvent {
  final Product product;
  UpdateProduct({required this.product});
}

class DeleteProduct extends ProductEvent {
  final String? productId;
  DeleteProduct({required this.productId});
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService = ProductService();

  ProductBloc() : super(ProductState([])) {
    on<FetchProducts>((event, emit) async {
      try {
        final products = await _productService.fetchProducts();
        emit(ProductState(products));
      } catch (e) {
        print("Error fetching products: $e");
        emit(ProductState([]));
      }
    });

    on<CreateProduct>((event, emit) async {
      try {
        await _productService.createProduct(event.product);
        add(FetchProducts());
      } catch (e) {
        print("Error creating product: $e");
      }
    });

    on<UpdateProduct>((event, emit) async {
      try {
        await _productService.updateProduct(event.product);
        add(FetchProducts());
      } catch (e) {
        print("Error updating product: $e");
      }
    });

    on<DeleteProduct>((event, emit) async {
      try {
        await _productService.deleteProduct(event.productId!);
        add(FetchProducts());
      } catch (e) {
        print("Error deleting product: $e");
      }
    });
  }
}
