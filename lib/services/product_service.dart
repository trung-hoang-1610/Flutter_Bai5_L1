import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        return Product.fromMap({
          'id': doc.id,
          ...doc.data(),
        });
      }).toList();
    } catch (e) {
      throw Exception("Error fetching productsggg: $e");
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('products').add(product.toMap());
      String id = docRef.id;
      await docRef.update({'id': id});
    } catch (e) {
      throw Exception("Error creating products: $e");
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
    } catch (e) {
      throw Exception("Error updating product: $e");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception("Error deleting product: $e");
    }
  }

  Future<String> getImageUrl(String productId) async {
    final docRef = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get();
    if (!docRef.exists) {
      return '';
    }
    return Product.fromMap(docRef.data()!).imageUrl;
  }
}
