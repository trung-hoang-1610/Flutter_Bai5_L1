import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch user details from Firestore
  Future<User> fetchUser(String userId) async {
    try {
      final docSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return User.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }

  // Create a new user
  Future<void> createUser(User user) async {
    try {
      await _firestore.collection('users').add(user.toMap());
    } catch (e) {
      throw Exception("Error creating user: $e");
    }
  }

  // Update user details
  Future<void> updateUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
    } catch (e) {
      throw Exception("Error updating user: $e");
    }
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception("Error deleting user: $e");
    }
  }
}
