// lib/utils/api/api_library.dart

part of 'api_library.dart';

/// Call API to add new [Address] to user's address list.
Future<int> addAddress(Address address) async {
  String apiUrl = '${dotenv.get('API_URL')}/address';

  final Map<String, String> reqData = address.toJson();

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

Future<void> deleteAddress(int addressId) async {
  String apiUrl = '${dotenv.get('API_URL')}/address/$addressId';

  final String? authToken = await AuthState.getAuthToken();
  await http.delete(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    },
  );
}

/// Call API to edit [Address].
Future<int> editAddress(Address address) async {
  String apiUrl = '${dotenv.get('API_URL')}/address';

  final Map<String, String> reqData = address.toJson();

  try {
    final String? authToken = await AuthState.getAuthToken();
    if (authToken == null) {
      // Token is not available, handle accordingly
      return 403;
    }
    final http.Response response = await http.put(
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

/// Fetch list of [Address] of user from API.
Future<List<Address>?> getAddresses() async {
  String apiUrl = '${dotenv.get('API_URL')}/address/';
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
    return null;
  }
}

/// Fetch list of all [City].
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
    return null;
  }
}
