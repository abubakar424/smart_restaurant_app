import 'package:flutter/material.dart';
import 'package:restaurant_app/src/model/food_list/food_list_model.dart';

class FoodListProvider extends ChangeNotifier {
  List<FoodListModel> _products = [];

  List<FoodListModel> get products => _products;

  // Set initial products list
  void setProducts(List<FoodListModel> products) {
    _products = products;
    notifyListeners();
  }

  // Update product details
  void updateProduct(int id, String name, String category, String price, String description) {
    final index = _products.indexWhere((product) => product.id == id);
    if (index != -1) {
      _products[index].name = name;
      _products[index].foodList = category;
      _products[index].price = price;
      _products[index].descr = description;
      notifyListeners();
    }
  }

  // Update product image
  void updateProductImage(int id, String imagePath) {
    final index = _products.indexWhere((product) => product.id == id);
    if (index != -1) {
      _products[index].image = imagePath;
      notifyListeners();
    }
  }

  // Get product by ID
  FoodListModel getProductById(int id) {
    return _products.firstWhere((product) => product.id == id);
  }

  // Add a new product
  void addProduct(FoodListModel product) {
    _products.add(product);
    notifyListeners();
  }

  // Remove a product by ID
  void removeProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
