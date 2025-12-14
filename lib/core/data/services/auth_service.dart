import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl;
  User? _currentUser;
  bool _isLoading = false;

  AuthService({required this.baseUrl}) {
    _loadUser();
  }

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user_data');
    if (userJson != null) {
      try {
        _currentUser = User.fromJson(jsonDecode(userJson));
        notifyListeners();
      } catch (e) {
        print('Error loading user: $e');
      }
    }
  }

  Future<void> login(String username, String password) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("LOGIN RESPONSE: ${response.body}");
        final data = jsonDecode(response.body);

        // Ensure username is set from input if missing in response
        if (data['username'] == null) {
          data['username'] = username;
        }

        _currentUser = User.fromJson(data);
        await _saveUser(_currentUser!);
        notifyListeners();
      } else {
        throw Exception('Ошибка входа: ${response.body}');
      }
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String email, String password, String name) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'username': name,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Ensure username is set from input if missing in response
        if (data['username'] == null) {
          data['username'] = name;
        }

        _currentUser = User.fromJson(data);
        await _saveUser(_currentUser!);
        notifyListeners();
      } else {
        throw Exception('Ошибка регистрации: ${response.body}');
      }
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    notifyListeners();
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
