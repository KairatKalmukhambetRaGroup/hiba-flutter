import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hiba/entities/promotion.dart';
import 'package:hiba/utils/api/auth.dart';
import 'package:http/http.dart' as http;

/// Fetch list of [Promotion] from API.
Future<List<Promotion>?> getPromotions() async {
  String apiUrl = '${dotenv.get('API_URL')}/promotion/';

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

      List<Promotion> list = [];
      for (var el in responseData) {
        Promotion promotion = Promotion.fromJson(el);
        list.add(promotion);
      }

      return list;
    }
    return null;
  } catch (e) {
    return null;
  }
}
