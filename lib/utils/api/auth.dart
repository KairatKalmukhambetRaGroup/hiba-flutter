// ignore_for_file: avoid_print
// lib/utils/api/api_library.dart

part of 'api_library.dart';

// TODO: add loggin in with Apple account
/// State Management Class for User authentification
class AuthState extends ChangeNotifier {
  /// Secure storage to store user data in app.
  static const storage = FlutterSecureStorage();

  User? _user;

  /// Stored User data.
  User? get user => _user;

  bool _isCourier = false;

  /// Determines whether [user] is courier or not.
  bool get isCourier => _isCourier;

  bool _isClientUI = true;

  /// Determines whether current used UI is clien's UI or courier's UI.
  bool get isClientUI => _isClientUI;

  bool _isLoggedIn = false;

  /// Determines whether [user] is loggen to system in or not.
  bool get isLoggedIn => _isLoggedIn;

  /// Logs in [User] with Google account's [idToken] as parameter.
  /// Returns status of API call.
  Future<int> loginWithGoogle(String idToken) async {
    // url of API call
    String apiUrl = '${dotenv.get('API_URL')}/auth/google';
    try {
      // API call to find existsing user.
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"idToken": idToken}),
      );

      // checks if return status is successfull.
      if (response.statusCode == 200) {
        // Logs in existing user to system.
        if (response.body.isNotEmpty) {
          loginToSystem(response.body);
          return 201;
        }
        // Returns status 200, meaning User does not exists, and needs to register.
        return 200;
      } else {
        print(
            'Backend error on google login with status code ${response.statusCode}');
      }
      // Returns status code of response to handle errors.
      return response.statusCode;
    } catch (e) {
      print('Error: $e');
      return 500;
    }
  }

  /// Stores [User] to storage.
  Future<void> storeAuthData(String token, dynamic userData) async {
    await storage.write(key: 'authToken', value: token);
    await storage.write(key: 'user', value: json.encode(userData));
    _isLoggedIn = true;
  }

  /// Auth token of [user].
  static Future<String?> getAuthToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'authToken');
  }

  /// [User] from storage.
  Future<User?> getUserData() async {
    // User data from storage, may be null
    String? userDataString = await storage.read(key: 'user');
    // Logout if user is null
    if (userDataString == null) {
      logout();
      return null;
    }
    // Get token from storage
    String? token = await storage.read(key: 'authToken');

    // Logout if token is null or expired.
    if (token == null) {
      logout();
      return null;
    }
    bool isTokenExpired = JwtDecoder.isExpired(token);
    if (isTokenExpired) {
      logout();
      return null;
    }

    /// Inits _user and _isLoggedIn
    Map<String, dynamic> data = json.decode(userDataString);
    _user = User.fromJson(data);
    _isLoggedIn = true;

    /// Sets current user as courier depending of storage data.
    String? isCourierString = await storage.read(key: 'isCourier');
    _isCourier = !(isCourierString == null || isCourierString == 'false');

    /// Sets current UI depending of storage data.
    String? uiString = await storage.read(key: 'ui');
    _isClientUI = uiString == null || uiString == 'client';

    notifyListeners();
    return _user;
  }

  /// Rewrite stored [User] and [user]
  void updateUserData(String token, dynamic user) {
    storeAuthData(token, user);
    _user = User.fromJson(user);
    notifyListeners();
  }

  /// Log out [User] from system.
  Future<void> logout() async {
    _user = null;
    await storage.delete(key: 'authToken');
    await storage.delete(key: 'user');
    _isLoggedIn = false;
    notifyListeners();
  }

  /// Logs in User to system when code given from telegram bot confirmed on backend.
  Future<int> confirmCode(String phone, String code) async {
    // url of API call
    String apiUrl = '${dotenv.get('API_URL')}/auth/confirmCode';

    final Map<String, String> reqData = {
      'phoneNumber': phone,
      'code': code,
    };

    try {
      // API call to find existsing user.
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(reqData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      // checks if return status is successfull.
      if (response.statusCode == 200) {
        // Logs in existing user to system.
        if (response.body.isNotEmpty) {
          loginToSystem(response.body);
          return 201;
        }
        // Returns status 200, meaning User does not exists, and needs to register.
        return 200;
      }
      // Returns status code of response to handle errors.
      return response.statusCode;
    } catch (e) {
      print('Error: $e');
      return 500;
    }
  }

  /// Login [User] to system.
  void loginToSystem(data) async {
    // Decode json object received from api call.
    final Map<String, dynamic> responseData = json.decode(data);

    /// Determine if user registered as courier.
    if (responseData['role']['name'] == 'ROLE_COURIER') {
      _isCourier = true;
      _isClientUI = false;
      await storage.write(key: 'ui', value: 'courier');
    } else {
      _isCourier = false;
      _isClientUI = true;
      await storage.write(key: 'ui', value: 'client');
    }

    // Save user data in storage.
    await storage.write(key: 'isCourier', value: _isCourier.toString());
    await storeAuthData(responseData['token'], responseData['user']);
    _user = User.fromJson(responseData['user']);
    notifyListeners();

    // STORE FCM TOKEN IN DB
    String apiUrl = '${dotenv.get('API_URL')}/user/saveFcmToken';
    // Get FCM token
    String? fcmToken = await FirebaseApi().getToken();

    if (fcmToken != null) {
      try {
        // Get device data: platform, device ID
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

        // Send  device data and FCM token to backend to save to coresponding user,
        // for future firebase notifications.
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

  /// Register [User] in backend with parameters [phone], [name], and [photo] if given.
  /// Registration of `user` already started when [confirmCode] or [loginWithGoogle] where called with parameters of not existing user.
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

  /// Use [confirmCode] or [loginWithGoogle] to login, as logging in with other parameters is no longer acceptable.
  @Deprecated('Loggin in with phone in not acceptable')
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

  /// Registers [User] to system
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
