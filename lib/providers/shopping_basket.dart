import 'package:flutter/material.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/menu_item.dart';
import 'package:hiba/entities/order.dart';

/// A provider class for managing shopping basket functionality.
///
/// `ShoppingBasket` allows users to add, remove, and organize items within their orders.
/// The class maintains a list of orders and each order contains items specific to a particular
/// `Butchery`. The provider notifies listeners of any changes, enabling reactive updates in the UI.
///
/// Example usage:
/// ```dart
/// ShoppingBasket basket = ShoppingBasket();
/// basket.addItem(menuItem, butchery, charity: false);
/// ```
///
/// The class supports operations such as adding/removing items, creating orders,
/// and managing the quantities of items.

class ShoppingBasket extends ChangeNotifier {
  /// Internal list of orders.
  final List<Order> _orders = [];

  /// Exposes the list of orders in the basket.
  List<Order> get orders => _orders;

  /// Creates a new order for the specified `Butchery`.
  ///
  /// - [butchery]: The `Butchery` object for which the order is being created.
  /// - [charity]: Boolean indicating if the order is for charity.
  ///
  /// Returns the index of the newly created order.
  int createOrder(Butchery butchery, bool charity) {
    Order order = Order(butchery: butchery, charity: charity);

    _orders.add(order);
    return _orders.length - 1;
  }

  /// Retrieves the index of an order based on `Butchery` and `charity` flag.
  ///
  /// - [butchery]: The `Butchery` associated with the order.
  /// - [charity]: Boolean indicating if the order is for charity.
  ///
  /// Returns the index of the order if found, otherwise returns `-1`.
  int getOrderIndex(Butchery butchery, bool charity) {
    return _orders.indexWhere((order) =>
        order.butchery.id == butchery.id && order.charity == charity);
  }

  /// Adds an item to an existing order at a specified index.
  ///
  /// - [item]: The `MenuItem` to add to the order.
  /// - [orderIndex]: The index of the order to which the item will be added.
  ///
  /// If the item already exists in the order, its quantity is incremented.
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

  /// Adds an item to an order based on `Butchery` and `charity` flag.
  ///
  /// - [item]: The `MenuItem` to add.
  /// - [butchery]: The `Butchery` associated with the order.
  /// - [charity]: Boolean indicating if the order is for charity.
  ///
  /// If an order doesn't exist, a new order is created. If the item already exists
  /// in the order, its quantity is incremented.
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

  /// Finds an item in an order by its ID and returns the index if found.
  ///
  /// - [id]: The ID of the `MenuItem`.
  /// - [orderIndex]: The index of the order to search in.
  ///
  /// Returns the index of the item if found, otherwise `-1`.
  int findById(int id, int orderIndex) {
    return _orders[orderIndex].items.indexWhere((element) => element.id == id);
  }

  /// Removes an item from an order by its index and decrements its quantity.
  ///
  /// - [id]: The ID of the item to remove.
  /// - [orderIndex]: The index of the order to remove the item from.
  ///
  /// If the quantity reaches zero, the item is removed from the order, and if
  /// the order has no items, the order itself is removed.
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

  /// Removes an item from an order by `Butchery` and `charity` flag.
  ///
  /// - [id]: The ID of the item to remove.
  /// - [butchery]: The `Butchery` associated with the order.
  /// - [charity]: Boolean indicating if the order is for charity.
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

  /// Deletes a specific item from an order based on `Butchery` and `charity` flag.
  ///
  /// - [menuItemId]: The ID of the item to delete.
  /// - [butchery]: The `Butchery` associated with the order.
  /// - [charity]: Boolean indicating if the order is for charity.
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

  /// Deletes an entire order based on `Butchery` and `charity` flag.
  ///
  /// - [butchery]: The `Butchery` associated with the order.
  /// - [charity]: Boolean indicating if the order is for charity.
  void deleteOrder(Butchery butchery, bool charity) {
    int index = getOrderIndex(butchery, charity);
    if (index == -1) {
      return;
    }
    _orders[index].items.clear();
    _orders.removeAt(index);
  }
}
