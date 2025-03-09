import 'package:flutter/material.dart';

import '../../../dummy_data/order_status_list.dart';
import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  int _currentProductId = 0;
  List<ProductModel> get products => _products;

  // Set initial products list
  void setProducts(List<ProductModel> products) {
    _products = productData;
    notifyListeners();
  }

  int getNextProductId() {
    if (_products.isNotEmpty) {
      _currentProductId = _products.map((p) => p.productId).reduce((a, b) => a > b ? a : b) + 1;
    } else {
      _currentProductId = 7; // If no products, start from 7
    }
    return _currentProductId;
  }

  // Update product details
  void updateProduct(int id, String name, String category, String price, String description) {
    final index = _products.indexWhere((product) => product.productId == id);
    if (index != -1) {
      _products[index].productName = name;
      _products[index].productCategory = category;
      _products[index].productPrice = price;
      _products[index].productDescr = description;
      notifyListeners();
    }
  }

  // Update product image
  void updateProductImage(int id, String imagePath) {
    final index = _products.indexWhere((product) => product.productId == id);
    if (index != -1) {
      _products[index].productImage = imagePath;
      notifyListeners();
    }
  }

  // Get product by ID
  ProductModel getProductById(int id) {
    return _products.firstWhere((product) => product.productId == id);
  }

  // Add a new product
  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  // Remove a product by ID
  void removeProduct(int id) {
    _products.removeWhere((product) => product.productId == id);
    notifyListeners();
  }

  // Move product to "Stock"
  void moveToStack(int id) {
    final index = _products.indexWhere((product) => product.productId == id);
    if (index != -1) {
      // Save original category before moving to Stock
      _products[index].originalCategory = _products[index].productCategory;
      _products[index].productCategory = 'Stock'; // Move to Stock category
      notifyListeners();
    }
  }

  // Restore product to its original category based on its current properties
  void restoreProductCategory(int id) {
    final index = _products.indexWhere((product) => product.productId == id);
    if (index != -1) {
      // Restore to the original category if available
      if (_products[index].originalCategory != null) {
        _products[index].productCategory = _products[index].originalCategory!; // Restore original category
        _products[index].originalCategory = null; // Clear original category after restoring
        notifyListeners();
      }
    }
  }
}

