// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hiba/entities/user.dart';
import 'package:hiba/utils/api/firebase_api.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthState extends ChangeNotifier {
  static const storage = FlutterSecureStorage();
  User? _user;
  User? get user => _user;

  bool _isCourier = false;
  bool get isCourier => _isCourier;

  bool _isClientUI = true;
  bool get isClientUI => _isClientUI;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<int> loginWithGoogle(String idToken) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/google';

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"idToken": idToken}),
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          loginToSystem(response.body);
          return 201;
        }
        return 200;
      } else {
        print(
            'Backend error on google login with status code ${response.statusCode}');
      }
      return response.statusCode;
    } catch (e) {
      print('Error: $e');
      return 500;
    }
  }

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

    String? isCourierString = await storage.read(key: 'isCourier');
    if (isCourierString == null || isCourierString == 'false') {
      _isCourier = false;
    } else {
      _isCourier = true;
    }

    String? uiString = await storage.read(key: 'ui');
    if (uiString == null || uiString == 'client') {
      _isClientUI = true;
    } else {
      _isClientUI = false;
    }

    notifyListeners();
    return _user;
  }

  // 192.168.68.101:8000

  void updateUserData(String token, dynamic user) {
    storeAuthData(token, user);
    _user = User.fromJson(user);
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    await storage.delete(key: 'authToken');
    await storage.delete(key: 'user');
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<int> confirmCode(String phone, String code) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/confirmCode';

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
          loginToSystem(response.body);
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

  void loginToSystem(data) async {
    final Map<String, dynamic> responseData = json.decode(data);
    if (responseData['role']['name'] == 'ROLE_COURIER') {
      _isCourier = true;
      _isClientUI = false;
      await storage.write(key: 'ui', value: 'courier');
    } else {
      _isCourier = false;
      _isClientUI = true;
      await storage.write(key: 'ui', value: 'client');
    }

    await storage.write(key: 'isCourier', value: _isCourier.toString());
    await storeAuthData(responseData['token'], responseData['user']);
    _user = User.fromJson(responseData['user']);
    notifyListeners();

    // STORE FCM TOKEN IN DB
    String apiUrl = '${dotenv.get('API_URL')}/user/saveFcmToken';
    String? fcmToken = await FirebaseApi().getToken();
    // print(fcmToken);

    if (fcmToken != null) {
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        String platform = '';
        String deviceId = '';
        if (Platform.isAndroid) {
          platform = 'android';
          var deviceBuild = await deviceInfo.androidInfo;
          deviceId = deviceBuild.id;
        } else if (Platform.isIOS) {
          platform = 'ios';
          var deviceBuild = await deviceInfo.iosInfo;
          deviceId = deviceBuild.identifierForVendor ?? 'unknown';
        }
        // print(platform);
        // print(deviceId);
        await http.post(
          Uri.parse(apiUrl),
          body: jsonEncode({
            "fcmToken": fcmToken,
            "userId": responseData['user']['id'],
            "platform": platform,
            "deviceId": deviceId
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${responseData['token']}',
          },
        );
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void changeUItoClient() async {
    _isClientUI = true;
    await storage.write(key: 'ui', value: 'client');
    notifyListeners();
  }

  void changeUItoCourier() async {
    _isClientUI = false;
    await storage.write(key: 'ui', value: 'courier');
    notifyListeners();
  }

  Future<int> completeRegistration(
      String phone, String name, File? photo) async {
    String apiUrl = '${dotenv.get('API_URL')}/auth/completeRegistration';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers['Content-Type'] = 'multipart/form-data; charset=UTF-8;';
      if (photo != null) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', photo.path));
      }
      request.fields['name'] = name;
      request.fields['phoneNumber'] = phone;

      final streamedResponse = await request.send();
      // streamedResponse.headers;
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final responseData =
            Map<String, dynamic>.from(json.decode(decodedBody));
        await storeAuthData(responseData['token'], responseData['user']);
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
        if (responseData['role'].name == 'ROLE_COURIER') {
          _isCourier = true;
        } else {
          _isCourier = false;
        }

        await storeAuthData(responseData['token'], responseData['user']);
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

        await storeAuthData(responseData['token'], responseData['user']);
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
