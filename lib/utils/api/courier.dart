// ignore_for_file: avoid_print

import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

/// Fetch list of [Order] from API for Courier.
/// [active] determines if list should be of active orders or not.
Future<List<Order>?> getCourierOrders(bool active) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/${active ? 'activeOrders' : 'waitingOrders'}';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      return null;
    }
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));

      List<Order> list = [];
      for (var el in responseData) {
        Order order = Order.fromJsonOrderResponse(el);

        list.add(order);
      }
      return list;
    }

    return null;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

/// Fetch list of [Order] from API for Courier, by [butcheryId].
/// [active] determines if list should be of active orders or not.
Future<List<Order>?> getCourierOrdersByButcheryId(
    bool active, int butcheryId) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/${active ? 'activeOrders' : 'waitingOrders'}/byButchery/$butcheryId';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      return null;
    }
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));

      List<Order> list = [];
      for (var el in responseData) {
        Order order = Order.fromJsonOrderResponse(el);

        list.add(order);
      }
      return list;
    }

    return null;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

/// Fetch list of [Butchery] from API for Courier that has [Order].
/// [active] determines if list should be of active orders or not.
Future<List<Butchery>?> getCourierOrdersByButchery(bool active) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/${active ? 'activeOrders' : 'waitingOrders'}/byButchery';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      return null;
    }
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));
      List<Butchery> list = [];
      for (var el in responseData) {
        Butchery butchery = Butchery.fromJson(el['butchery']);
        butchery.ordersCount = el['activeOrders'];
        list.add(butchery);
      }
      return list;
    }

    return null;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

/// Fetch list of [Order] from API for Courier, filtered by [startDate] and [endDate] of order delivery dates.
Future<List<Order>?> getCourierOrdersHistory(
    DateTime startDate, DateTime endDate) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/history?start=$startDate&end=$endDate';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      return null;
    }
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));
      List<Order> list = [];
      for (var el in responseData) {
        Order order = Order.fromJsonOrderResponse(el);

        list.add(order);
      }
      return list;
    }

    return null;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

/// Call API to update [Order]'s status.
/// [orderId] - id of order to update.
/// [orderStatus] - new status of order.
Future<int> updateOrderStatus(int orderId, String orderStatus) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/order/updateOrderStatus/$orderId?status=$orderStatus';
  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      return 403;
    }
    final http.Response response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    return response.statusCode;
  } catch (e) {
    print('Error: $e');
    return 500;
  }
}

/// Call API to check confirmation [code] of [Order] by [orderId].
Future<int> checkConfirmCode(int orderId, String code) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/confirmationCode/$orderId?code=$code';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      return 403;
    }
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    return response.statusCode;
  } catch (e) {
    print('Error: $e');
    return 500;
  }
}
