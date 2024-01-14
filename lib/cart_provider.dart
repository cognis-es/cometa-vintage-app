import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(double price, int quantity, String category) {
    _items.add(
      CartItem(
        id:  DateTime.now().toString(), 
        category: category, 
        quantity: quantity, 
        price: price
      )
    );
    
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    
    notifyListeners();
  }

  void clear() {
    _items = [];

    notifyListeners();
  }
}