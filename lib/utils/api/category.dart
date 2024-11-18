part of 'api_library.dart';

Future<List<Category>?> getCategories() async {
  String apiUrl = '${dotenv.get('API_URL')}/categories/';
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

      List<Category> list = [];
      for (var el in responseData) {
        Category category = Category.fromJson(el);

        list.add(category);
      }
      return list;
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<Category?> getCategoryById(int id) async {
  String apiUrl = '${dotenv.get('API_URL')}/categories/$id';
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
      final responseData = Map<String, dynamic>.from(json.decode(decodedBody));
      Category category = Category.fromJson(responseData);
      return category;
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}
