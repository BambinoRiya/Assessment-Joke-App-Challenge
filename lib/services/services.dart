import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeService {
  static const String baseUrl = 'https://v2.jokeapi.dev/joke/Any';

  Future<List<dynamic>> fetchJokes(
      {int amount = 20,
      String query = '',
      List<String> categories = const []}) async {
    try {
      String url = '$baseUrl?amount=$amount';

      if (query.isNotEmpty) {
        url += '&contains=$query';
      }

      if (categories.isNotEmpty) {
        String categoriesParam = categories.join(',');
        url += '&categories=$categoriesParam';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['jokes'];
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      throw Exception('Failed to load jokes: $e');
    }
  }
}
