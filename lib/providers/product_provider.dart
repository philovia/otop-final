import 'package:flutter/foundation.dart';
import 'package:otop_front/models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  String _username = '';
  String _role = '';

  List<Product> get products => _products;

  String get username => _username;
  String get role => _role;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners(); // Notify listeners that the product list has changed
  }

  void setUser(String username, String role) {
    _username = username;
    _role = role;
    notifyListeners(); // Notify listeners that the user information has changed
  }
}
