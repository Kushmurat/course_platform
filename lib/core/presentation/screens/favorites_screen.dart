import 'package:flutter/material.dart';
import '../../data/models/course.dart';
import '../../data/services/api_service.dart';
import '../../data/services/favorites_service.dart';
import '../widgets/course_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  final ApiService _apiService = ApiService(
    baseUrl: 'https://skill-lab-backend.onrender.com',
  );
  late Future<List<Course>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favoritesFuture = _fetchFavoriteCourses();
    });
  }

  Future<List<Course>> _fetchFavoriteCourses() async {
    final favoriteIds = await _favoritesService.getFavoriteIds();
    if (favoriteIds.isEmpty) return [];

    final List<Course> courses = [];
    for (final id in favoriteIds) {
      try {
        final course = await _apiService.fetchCourse(id);
        courses.add(course);
      } catch (e) {
        print('Error fetching course $id: $e');
      }
    }
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Избранное',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Course>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'У вас пока нет избранных курсов',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final courses = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CourseCard(course: courses[index]),
              );
            },
          );
        },
      ),
    );
  }
}
