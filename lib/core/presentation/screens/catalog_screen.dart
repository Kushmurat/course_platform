import 'package:flutter/material.dart';
import '../../data/models/course.dart';
import '../../data/services/api_service.dart';
import '../widgets/course_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ApiService _apiService = ApiService(
    baseUrl: 'https://skill-lab-backend.onrender.com',
  );
  late Future<List<Course>> _coursesFuture;
  String _searchQuery = '';
  String? _selectedCategory;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _coursesFuture = _apiService.fetchCourses();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        selectedCategory: _selectedCategory,
        onApply: (category) {
          setState(() {
            _selectedCategory = category;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Каталог',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search & Filter Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Поиск по курсам',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    // Sorting placeholder - implementing Filter button instead as per request
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.swap_vert, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _showFilterSheet,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: _selectedCategory != null
                          ? const Color(0xFF1E73FF).withOpacity(0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedCategory != null
                            ? const Color(0xFF1E73FF)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: _selectedCategory != null
                          ? const Color(0xFF1E73FF)
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Course List
          Expanded(
            child: FutureBuilder<List<Course>>(
              future: _coursesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Нет доступных курсов'));
                }

                final courses = snapshot.data!.where((course) {
                  final matchesSearch = course.title.toLowerCase().contains(
                    _searchQuery,
                  );
                  final matchesCategory =
                      _selectedCategory == null ||
                      (course.category != null &&
                          course.category!.toUpperCase() ==
                              _selectedCategory!.toUpperCase());

                  return matchesSearch && matchesCategory;
                }).toList();

                if (courses.isEmpty) {
                  return const Center(child: Text('Ничего не найдено'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CourseCard(course: course),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
