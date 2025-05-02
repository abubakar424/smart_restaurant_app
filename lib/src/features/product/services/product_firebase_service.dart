// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
//
// import '../../../dummy_data/order_status_list.dart';
// import '../model/product_model.dart';
//
// class ProductProvider extends ChangeNotifier {
//   List<ProductModel> _products = [];
//   int _currentProductId = 0;
//   bool _isLoading = false;
//
//   List<ProductModel> get products => _products;
//   bool get isLoading => _isLoading;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   // Initialize provider and load user's products
//   Future<void> initialize() async {
//     await fetchUserProducts();
//   }
//
//   // Fetch user's products from Firestore
//   Future<void> fetchUserProducts() async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) return;
//
//       final snapshot = await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .get();
//
//       _products = snapshot.docs.map((doc) {
//         final data = doc.data();
//         return ProductModel(
//           productId: int.parse(doc.id), // Using document ID as productId
//           productName: data['productName'] ?? '',
//           productPrice: data['productPrice'] ?? '',
//           productDescr: data['productDescr'] ?? '',
//           productImage: data['productImage'] ?? '',
//           productCategory: data['productCategory'] ?? '',
//           originalCategory: data['originalCategory'],
//         );
//       }).toList();
//
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Get next available product ID
//   int getNextProductId() {
//     if (_products.isNotEmpty) {
//       _currentProductId = _products.map((p) => p.productId).reduce((a, b) => a > b ? a : b) + 1;
//     } else {
//       _currentProductId = 1; // Start from 1 if no products
//     }
//     return _currentProductId;
//   }
//
//   // Add a new product to Firestore
//   Future<void> addProduct(ProductModel product, File? imageFile) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       // Upload image if provided
//       String? imageUrl;
//       if (imageFile != null) {
//         imageUrl = await _uploadImage(imageFile);
//       }
//
//       // Add product to Firestore
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .doc(product.productId.toString())
//           .set({
//         'productName': product.productName,
//         'productPrice': product.productPrice,
//         'productDescr': product.productDescr,
//         'productImage': imageUrl ?? product.productImage,
//         'productCategory': product.productCategory,
//         'originalCategory': product.originalCategory,
//       });
//
//       // Refresh local list
//       await fetchUserProducts();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Update product details in Firestore
//   Future<void> updateProduct(int id, String name, String category, String price, String description) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .doc(id.toString())
//           .update({
//         'productName': name,
//         'productPrice': price,
//         'productDescr': description,
//         'productCategory': category,
//       });
//
//       // Refresh local list
//       await fetchUserProducts();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Update product image in Firestore
//   Future<void> updateProductImage(int id, File imageFile) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       // Upload new image
//       final imageUrl = await _uploadImage(imageFile);
//
//       // Update product with new image URL
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .doc(id.toString())
//           .update({
//         'productImage': imageUrl,
//       });
//
//       // Refresh local list
//       await fetchUserProducts();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Remove a product from Firestore
//   Future<void> removeProduct(int id) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       // First delete the product image from storage if it exists
//       final product = getProductById(id);
//       if (product.productImage.isNotEmpty) {
//         await _deleteImage(product.productImage);
//       }
//
//       // Then delete the product document
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .doc(id.toString())
//           .delete();
//
//       // Refresh local list
//       await fetchUserProducts();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Move product to "Stock" category
//   Future<void> moveToStack(int id) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       final product = getProductById(id);
//
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .doc(id.toString())
//           .update({
//         'originalCategory': product.productCategory,
//         'productCategory': 'Stock',
//       });
//
//       // Refresh local list
//       await fetchUserProducts();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Restore product to its original category
//   Future<void> restoreProductCategory(int id) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       final product = getProductById(id);
//       if (product.originalCategory == null) return;
//
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('products')
//           .doc(id.toString())
//           .update({
//         'productCategory': product.originalCategory,
//         'originalCategory': null,
//       });
//
//       // Refresh local list
//       await fetchUserProducts();
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Get product by ID (from local list)
//   ProductModel getProductById(int id) {
//     return _products.firstWhere((product) => product.productId == id);
//   }
//
//   // Helper method to upload image to Firebase Storage
//   Future<String> _uploadImage(File imageFile) async {
//     try {
//       final userId = _auth.currentUser?.uid;
//       if (userId == null) throw Exception('User not logged in');
//
//       final fileName = 'products/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
//       final ref = _storage.ref().child(fileName);
//       await ref.putFile(imageFile);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       throw Exception('Failed to upload image: $e');
//     }
//   }
//
//   // Helper method to delete image from Firebase Storage
//   Future<void> _deleteImage(String imageUrl) async {
//     try {
//       final ref = _storage.refFromURL(imageUrl);
//       await ref.delete();
//     } catch (e) {
//       throw Exception('Failed to delete image: $e');
//     }
//   }
// }


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smart_restaurant_app/src/features/product/model/product_model.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  String? get userId => _auth.currentUser?.uid;

  Future<List<ProductModel>> fetchUserProducts() async {
    if (userId == null) throw Exception("User not logged in");

    final snapshot = await _firestore
        .collection("users")  // Note: Changed from "user" to "users"
        .doc(userId)
        .collection("products")
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ProductModel(
        productId: int.parse(doc.id),
        productName: data["productName"] ?? "",
        productPrice: data["productPrice"] ?? "",
        productDescr: data['productDescr'] ?? '',
        productImage: data['productImage'] ?? '',
        productCategory: data['productCategory'] ?? '',
        originalCategory: data['originalCategory'],
      );
    }).toList();
  }

  Future<void> addProduct(ProductModel product, File? imageFile) async {
    if (userId == null) throw Exception("User not logged in");

    String? imageUrl;

    if (imageFile != null) {
      imageUrl = await uploadImage(imageFile);
    }

    // Add createdAt timestamp
    await _firestore
        .collection('users')
        .doc(userId)
        .collection("products")
        .doc(product.productId.toString())
        .set({
      "productName": product.productName,
      "productPrice": product.productPrice,
      "productDescr": product.productDescr,
      "productImage": imageUrl ?? product.productImage,
      "productCategory": product.productCategory,
      "originalCategory": product.originalCategory,
      "createdAt": FieldValue.serverTimestamp(), // Add timestamp
      "userId": userId, // Store user ID with product
    });
  }

  Future<void> updateProduct(int id, Map<String, dynamic> data) async{
    if(userId == null) throw Exception("User not logged in");
    await _firestore.collection("users").doc(userId).collection("products").doc(id.toString()).update(data);
  }

  Future<void> deleteProduct(int id, String imageUrl) async {
    if (userId == null) throw Exception('User not logged in');
    if (imageUrl.isNotEmpty) await deleteImage(imageUrl);
    await _firestore.collection('users').doc(userId).collection('products').doc(id.toString()).delete();
  }

  Future<String> uploadImage(File imageFile) async{
    final fileName = "products/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg";
    final ref = _storage.ref().child(fileName);
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> deleteImage(String imageUrl) async {
    final ref = _storage.refFromURL(imageUrl);
    await ref.delete();
  }
}