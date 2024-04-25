import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:http/http.dart' as http;

Future<int> addAddress(Address address) async {
  String apiUrl = '${dotenv.get('API_URL')}/address/addMyNewAddress';

  final Map<String, String> reqData = address.toJson();

  print(reqData);

  try {
    final String? authToken = await AuthState.getAuthToken();
    print(authToken);
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

    print(response.statusCode);

    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> responseData = json.decode(response.body);

    //   storeAuthData(responseData['token'], responseData['user']);
    // } else {
    //   print('Error on post');
    // }
    return response.statusCode;
  } catch (e) {
    print('Error: $e');
    return 500;
  }
}

Future<List<Address>?> getAddresses() async {
  String apiUrl = '${dotenv.get('API_URL')}/address/getAllMyAddresses';
  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return null;
    }

    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      // print(decodedBody);
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(decodedBody));

      List<Address> list = List.empty(growable: true);
      for (var el in responseData) {
        Address c = Address.fromJson(el);
        list.add(c);
      }
      return list;
    }
    return null;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<List<City>?> getCities() async {
  String apiUrl = '${dotenv.get('API_URL')}/location/getAllCities';

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
      final responseData =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      List<City> list = List.empty(growable: true);
      for (var el in responseData) {
        City c = City.fromJson(el);
        list.add(c);
      }
      return list;
    }
    return null;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
