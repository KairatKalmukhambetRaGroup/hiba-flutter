import 'package:flutter/material.dart';
import 'package:hiba/entities/menu_item.dart';

class ShoppingBasket extends ChangeNotifier {
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  void addItem(MenuItem item) {
    int index = findById(item.id);
    if (index == -1) {
      item.incrimentQuantity();
      _items.add(item);
      notifyListeners();
      return;
    }
    _items[index].incrimentQuantity();

    notifyListeners();
  }

  int findById(int id) {
    return _items.indexWhere((element) => element.id == id);
  }

  void removeItem(int id) {
    int index = findById(id);
    if (index == -1) {
      return;
    }
    _items[index].decrementQuantity();
    if (_items[index].quantity == 0) {
      _items.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  // void updateItem(int index, MenuItem newItem) {
  //   _items[index] = newItem;
  //   notifyListeners();
  // }
}

// class ShoppingItem {
//   final String name;
//   final double price;
//   int quantity;

//   ShoppingItem({required this.name, required this.price, this.quantity = 1});
// }
