import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses/list'));
    print("RAW JSON: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки списка курсов');
    }
  }

  Future<Course> fetchCourse(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$id'));
    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка загрузки курса $id');
    }
  }
}
