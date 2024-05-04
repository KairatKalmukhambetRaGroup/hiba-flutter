// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hiba/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthState extends ChangeNotifier {
  static const storage = FlutterSecureStorage();
  User? _user;
  User? get user => _user;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> storeAuthData(String token, dynamic userData) async {
    await storage.write(key: 'authToken', value: token);
    await storage.write(key: 'user', value: json.encode(userData));
    _isLoggedIn = true;
  }

  static Future<String?> getAuthToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'authToken');
  }

  Future<User?> getUserData() async {
    String? userDataString = await storage.read(key: 'user');
    print('user string: $userDataString');
    if (userDataString == null) {
      logout();
      return null;
    }
    String? token = await storage.read(key: 'authToken');

    if (token == null) {
      logout();
      return null;
    }
    bool isTokenExpired = JwtDecoder.isExpired(token);
    if (isTokenExpired) {
      logout();
      return null;
    }
    Map<String, dynamic> data = json.decode(userDataString);
    _user = User.fromJson(data);
    _isLoggedIn = true;
    notifyListeners();
    return _user;
  }

  // 192.168.68.101:8000

  Future<void> logout() async {
    _user = null;
    await storage.delete(key: 'authToken');
    await storage.delete(key: 'user');
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<int> confirmCode(String phone, String code) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/confirm-code';

    final Map<String, String> reqData = {
      'phoneNumber': phone,
      'code': code,
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
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          print(responseData);
          await storeAuthData(responseData['token'], responseData['user']);
          _user = User.fromJson(responseData['user']);
          notifyListeners();
          return 201;
        }
        return 200;
      }
      return response.statusCode;
    } catch (e) {
      print('Error 2: $e');
      return 500;
    }
  }

  Future<int> completeRegistration(
      String phone, String name, File photo) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/complete-registration';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers['Content-Type'] = 'multipart/form-data; charset=UTF-8;';
      request.files.add(await http.MultipartFile.fromPath('photo', photo.path));
      request.fields['name'] = name;
      request.fields['phoneNumber'] = phone;

      final streamedResponse = await request.send();
      // streamedResponse.headers;
      final response = await http.Response.fromStream(streamedResponse);
      print(streamedResponse.statusCode);
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final responseData =
            Map<String, dynamic>.from(json.decode(decodedBody));
        storeAuthData(responseData['token'], responseData['user']);
        _user = User.fromJson(responseData['user']);
        notifyListeners();
        return 200;
      }
      return response.statusCode;
    } catch (e) {
      print('Error: $e');
      return 500;
    }
  }

  Future<int> loginUser(String phone) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/login';

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

  Future<int> registerUser(
      String username, String phone, String password) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/signup';

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
}
