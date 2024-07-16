import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/order.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

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

Future<List<Order>?> getCourierOrdersHistory(
    DateTime startDate, DateTime endData) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/history?start=$startDate&end=$endData';

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

Future<int> updateOrderStatus(int orderId, String orderStatus) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/orderStatus/${orderId}?status=${orderStatus}';
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

Future<int> checkConfirmCode(int orderId, String code) async {
  String apiUrl =
      '${dotenv.get('API_URL')}/courier/confirmOrder/${orderId}/${code}';

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
