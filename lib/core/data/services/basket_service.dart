import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/course.dart';
import '../models/user.dart';

class BasketService {
  final String baseUrl = 'https://skill-lab-backend.onrender.com';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user_data');
    if (userJson != null) {
      try {
        final user = User.fromJson(jsonDecode(userJson));
        return user.token;
      } catch (e) {
        print('Error parsing user token: $e');
      }
    }
    return null;
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<Course>> fetchBasket() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/basket'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки корзины: ${response.statusCode}');
    }
  }

  Future<void> addToBasket(int courseId) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/basket/add'),
      headers: headers,
      body: jsonEncode({'courseId': courseId}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        'Ошибка добавления в корзину: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user_data');

    // 1. Try to get from User object
    if (userJson != null) {
      try {
        final user = User.fromJson(jsonDecode(userJson));
        if (user.id != null) return user.id;

        // 2. If id missing, try to get from Token
        if (user.token.isNotEmpty) {
          return _getUserIdFromToken(user.token);
        }
      } catch (e) {
        print('Error parsing user id: $e');
      }
    }
    return null;
  }

  int? _getUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final Map<String, dynamic> data = jsonDecode(payload);

      // Check common claims for ID
      if (data['userId'] != null)
        return int.tryParse(data['userId'].toString());
      if (data['id'] != null) return int.tryParse(data['id'].toString());
      if (data['sub'] != null) return int.tryParse(data['sub'].toString());
      if (data['user_id'] != null)
        return int.tryParse(data['user_id'].toString());

      return null;
    } catch (e) {
      print('Error parsing token: $e');
      return null;
    }
  }

  Future<void> clearBasket() async {
    final headers = await _getHeaders();
    final userId = await _getUserId();

    if (userId == null) {
      throw Exception(
        'Ошибка: ID пользователя не найден. Попробуйте перезайти в аккаунт.',
      );
    }

    // Try query parameters again now that we have a valid ID.
    // DELETE requests often ignore the body.
    final uri = Uri.parse(
      '$baseUrl/basket/clear',
    ).replace(queryParameters: {'userId': userId.toString()});

    final response = await http.delete(uri, headers: headers);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Ошибка очистки корзины (${response.statusCode}): ${response.body}',
      );
    }
  }
}
