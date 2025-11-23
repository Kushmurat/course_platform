import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses/list'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded.map((json) => Course.fromJson(json)).toList();
      }
      else if (decoded is Map<String, dynamic>) {
        // сервер вернул один объект
        return [Course.fromJson(decoded)];
      }
      else {
        throw Exception("Unknown JSON format");
      }
    } else {
      throw Exception('Failed to load courses');
    }
  }

}
