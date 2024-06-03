import 'package:flutter/material.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/entities/order.dart';

class ShoppingBasket extends ChangeNotifier {
  final List<Order> _orders = [];
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;
  List<Order> get orders => _orders;

  int createOrder(Butchery butchery, bool charity) {
    Order order = Order(butchery: butchery, charity: charity);

    _orders.add(order);
    return _orders.length - 1;
  }

  int getOrderIndex(Butchery butchery, bool charity) {
    return _orders.indexWhere((order) =>
        order.butchery.id == butchery.id && order.charity == charity);
  }

  void addItemByOrderIndex(MenuItem item, int orderIndex) {
    int j = findById(item.id, orderIndex);
    if (j == -1) {
      item.incrimentQuantity();
      _orders[orderIndex].items.add(item);
    } else {
      _orders[orderIndex].items[j].incrimentQuantity();
    }
    notifyListeners();
  }

  void addItem(MenuItem item, Butchery butchery, bool charity) {
    int index = getOrderIndex(butchery, charity);
    if (index == -1) {
      index = createOrder(butchery, charity);

      item.incrimentQuantity();
      _orders[index].items.add(item);
    } else {
      int j = findById(item.id, index);
      if (j == -1) {
        item.incrimentQuantity();
        _orders[index].items.add(item);
      } else {
        _orders[index].items[j].incrimentQuantity();
      }
    }
    notifyListeners();
  }

  // void addItem(MenuItem item) {
  //   int index = findById(item.id);
  //   if (index == -1) {
  //     item.incrimentQuantity();
  //     _items.add(item);
  //   } else {
  //     _items[index].incrimentQuantity();
  //   }
  //   notifyListeners();
  // }

  int findById(int id, int orderIndex) {
    return _orders[orderIndex].items.indexWhere((element) => element.id == id);
  }

  void removeItemByOrderIndex(int id, int orderIndex) {
    int j = findById(id, orderIndex);
    if (j == -1) {
      return;
    }
    _orders[orderIndex].items[j].decrementQuantity();
    if (_orders[orderIndex].items[j].quantity == 0) {
      _orders[orderIndex].items.removeWhere((element) => element.id == id);
      if (_orders[orderIndex].items.isEmpty) {
        _orders.removeAt(orderIndex);
      }
    }

    notifyListeners();
  }

  void removeItem(int id, Butchery butchery, bool charity) {
    int index = getOrderIndex(butchery, charity);
    if (index == -1) {
      return;
    }
    int j = findById(id, index);
    if (j == -1) {
      return;
    }
    _orders[index].items[j].decrementQuantity();
    if (_orders[index].items[j].quantity == 0) {
      _orders[index].items.removeWhere((element) => element.id == id);
      if (_orders[index].items.isEmpty) {
        _orders.removeAt(index);
      }
    }

    notifyListeners();
  }

  void deleteFromBasket(int menuItemId, Butchery butchery, bool charity) {
    int index = getOrderIndex(butchery, charity);
    if (index == -1) {
      return;
    }
    int j = findById(menuItemId, index);
    if (j == -1) {
      return;
    }
    _orders[index].items[j].quantity = 0;
    _orders[index].items.removeWhere((element) => element.id == menuItemId);
    if (_orders[index].items.isEmpty) {
      _orders.removeAt(index);
    }

    notifyListeners();
  }

  void deleteOrder(Butchery butchery, bool charity) {
    int index = getOrderIndex(butchery, charity);
    if (index == -1) {
      return;
    }
    _orders[index].items.clear();
    _orders.removeAt(index);
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
