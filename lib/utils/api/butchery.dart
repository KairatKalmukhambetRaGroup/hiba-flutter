// lib/utils/api/api_library.dart

part of 'api_library.dart';

/// Fetch Butcheries from API.
Future<List<Map<String, dynamic>>?> getButcheries() async {
  String apiUrl = '${dotenv.get('API_URL')}/butcheries/getAllButcheries';
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
      return responseData;
    }
    return null;
  } catch (e) {
    return null;
  }
}

/// Fetch [Butchery] from API with [id] as parameter.
Future<Butchery?> getButcheryById(String? id) async {
  if (id == null) return null;

  String apiUrl = '${dotenv.get('API_URL')}/butcheries/$id';

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
      final responseData = Map<String, dynamic>.from(json.decode(decodedBody));
      Butchery butchery = Butchery.fromJson(responseData['butchery']);
      if (responseData['workingHours'] != null) {
        butchery.workingHours =
            WorkingHour.workingHourListFromJson(responseData["workingHours"]);
      }
      butchery.categories = (responseData["categories"] as List)
          .map((el) => ButcheryCategory.fromJson(el))
          .toList();
      return butchery;
    }
    return null;
  } catch (e) {
    return null;
  }
}
