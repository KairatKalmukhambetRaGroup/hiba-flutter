// lib/utils/api/api_library.dart

part of 'api_library.dart';

/// Call API to create new [Order].
Future<int> createOrder(Order order) async {
  String apiUrl = '${dotenv.get('API_URL')}/order';
  final Map<String, dynamic> reqData = order.toJson();

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return 403;
    }
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(reqData),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    return response.statusCode;
  } catch (e) {
    return 500;
  }
}

/// Fetch list of user's [Order] from API.
Future<List<Order>?> getMyOrders() async {
  String apiUrl = '${dotenv.get('API_URL')}/order/getMyOrders';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
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
    return null;
  }
}

/// Fetch list of user's active [Order] from API.
Future<List<Order>?> getMyActiveOrders() async {
  // TO DO: change to getMyActiveOrders
  String apiUrl = '${dotenv.get('API_URL')}/order/getMyActiveOrders';

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
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
        Order order = Order.fromJson(el);

        list.add(order);
      }
      return list;
    }
    return null;
  } catch (e) {
    return null;
  }
}
