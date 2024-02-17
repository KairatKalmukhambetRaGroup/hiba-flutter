// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hiba/entities/user.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<void> storeAuthData(String token, dynamic userData) async {
  await storage.write(key: 'authToken', value: token);
  await storage.write(key: 'user', value: json.encode(userData));
  print(userData);
}

Future<String?> getAuthToken() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'authToken');
}

Future<User?> getUserData() async {
  String? userDataString = await storage.read(key: 'user');
  if (userDataString == null) return null;
  Map<String, dynamic> data = json.decode(userDataString);
  return User.fromJson(data);
}

Future<void> logout() async {
  await storage.delete(key: 'authToken');
  await storage.delete(key: 'user');
}

Future<int> loginUser(String phone) async {
  const String apiUrl = 'http://192.168.68.114:8000/auth/login';

  final Map<String, String> reqData = {
    'phone': phone,
  };

  try {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(reqData),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      storeAuthData(responseData['token'], responseData['user']);
    } else {
      print('Error on post');
    }
    return response.statusCode;
  } catch (e) {
    print('Error: $e');
    return 500;
  }
}

Future<int> registerUser(String username, String phone, String password) async {
  const String apiUrl = 'http://192.168.68.114:8000/auth/signup';

  final Map<String, String> reqData = {
    'username': username,
    'phone': phone,
    'password': password,
  };

  try {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(reqData),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      storeAuthData(responseData['token'], responseData['user']);
    } else {
      print('Error on post');
    }
    return response.statusCode;
  } catch (e) {
    print(e);
    return 500;
  }
}
