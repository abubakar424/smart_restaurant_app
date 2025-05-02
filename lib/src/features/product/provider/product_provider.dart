import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_restaurant_app/src/features/product/model/product_model.dart';
import 'package:smart_restaurant_app/src/features/product/services/product_firebase_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  int _currentProductId = 0;
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<ProductModel> get products => _products;

  ProductProvider() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        fetchProducts();
      } else {
        // Clear products when user logs out
        _products = [];
        _currentProductId = 0;
        notifyListeners();
      }
    });
  }

  // Fetch products from Firebase
  Future<void> fetchProducts() async {
    try {
      _products = await _firebaseService.fetchUserProducts();
      if (_products.isNotEmpty) {
        _currentProductId = _products
            .map((p) => p.productId)
            .reduce((a, b) => a > b ? a : b) +
            1;
      } else {
        _currentProductId = 7; // Start from 7 if no products
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  // Get next product ID
  int getNextProductId() {
    return _currentProductId;
  }

  // Add a new product to Firebase
  Future<void> addProduct(ProductModel product, File? imageFile) async {
    try {
      await _firebaseService.addProduct(product, imageFile);
      _products.add(product);
      _currentProductId++;
      notifyListeners();
    } catch (e) {
      print("Error adding product: $e");
      rethrow;
    }
  }

  // Update product in Firebase
  Future<void> updateProduct(
      int id, String name, String category, String price, String description,
      {File? imageFile}) async {
    try {
      final index = _products.indexWhere((product) => product.productId == id);
      if (index != -1) {
        String? imageUrl = _products[index].productImage;
        if (imageFile != null) {
          imageUrl = await _firebaseService.uploadImage(imageFile);
        }
        final data = {
          "productName": name,
          "productCategory": category,
          "productPrice": price,
          "productDescr": description,
          if (imageUrl != null) "productImage": imageUrl,
        };
        await _firebaseService.updateProduct(id, data);
        _products[index] = ProductModel(
          productId: id,
          productName: name,
          productCategory: category,
          productPrice: price,
          productDescr: description,
          productImage: imageUrl ?? _products[index].productImage,
          originalCategory: _products[index].originalCategory,
        );
        notifyListeners();
      }
    } catch (e) {
      print("Error updating product: $e");
      rethrow;
    }
  }

  // Update product image
  Future<void> updateProductImage(int id, File imageFile) async {
    try {
      final index = _products.indexWhere((product) => product.productId == id);
      if (index != -1) {
        final imageUrl = await _firebaseService.uploadImage(imageFile);
        await _firebaseService.updateProduct(id, {"productImage": imageUrl});
        _products[index].productImage = imageUrl;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating product image: $e");
      rethrow;
    }
  }

  // Get product by ID
  ProductModel getProductById(int id) {
    return _products.firstWhere((product) => product.productId == id);
  }

  // Remove a product from Firebase
  Future<void> removeProduct(int id) async {
    try {
      final index = _products.indexWhere((product) => product.productId == id);
      if (index != -1) {
        final product = _products[index];
        await _firebaseService.deleteProduct(id, product.productImage);
        _products.removeAt(index);
        notifyListeners();
      }
    } catch (e) {
      print("Error removing product: $e");
      rethrow;
    }
  }

  // Move product to "Stock"
  Future<void> moveToStack(int id) async {
    try {
      final index = _products.indexWhere((product) => product.productId == id);
      if (index != -1) {
        _products[index].originalCategory = _products[index].productCategory;
        _products[index].productCategory = 'Stock';
        await _firebaseService.updateProduct(id, {
          "productCategory": "Stock",
          "originalCategory": _products[index].originalCategory,
        });
        notifyListeners();
      }
    } catch (e) {
      print("Error moving to stock: $e");
      rethrow;
    }
  }

  // Restore product to its original category
  Future<void> restoreProductCategory(int id) async {
    try {
      final index = _products.indexWhere((product) => product.productId == id);
      if (index != -1 && _products[index].originalCategory != null) {
        _products[index].productCategory = _products[index].originalCategory!;
        await _firebaseService.updateProduct(id, {
          "productCategory": _products[index].originalCategory,
          "originalCategory": null,
        });
        _products[index].originalCategory = null;
        notifyListeners();
      }
    } catch (e) {
      print("Error restoring product category: $e");
      rethrow;
    }
  }
}