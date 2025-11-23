import 'package:flutter/material.dart';
import '../../data/models/course.dart';
import 'course_card.dart';

class CourseList extends StatelessWidget {
  final Future<List<Course>> future;

  const CourseList({required this.future, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Ошибка загрузки"));
        }

        final courses = snapshot.data ?? [];

        return ListView.separated(
          itemCount: courses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, index) {
            return CourseCard(course: courses[index]);
          },
        );
      },
    );
  }
}
