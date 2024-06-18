import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hiba/entities/butchery.dart';
import 'package:hiba/entities/butchery_category.dart';
import 'package:hiba/entities/working_hour.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:http/http.dart' as http;

const butcheriesPath = 'assets/butcheries.json';

// _butcheries = List<Map<String, dynamic>>.from(json.decode(jsonString));

Future<List<Map<String, dynamic>>?> getButcheries() async {
  String apiUrl = '${dotenv.get('API_URL')}/butcheries/getAllButcheries';

  // return await rootBundle.loadString(butcheriesPath).then((file) => file);

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
      if(responseData['workingHours'] != null){
        butchery.workingHours = WorkingHour.workingHourListFromJson(responseData["workingHours"]);
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
