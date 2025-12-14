import 'package:flutter/material.dart';
import '../../../data/models/demo_course.dart';
import '../../widgets/demo_course_item.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ваши курсы', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoCourses.length,
        itemBuilder: (context, index) {
          return DemoCourseItem(course: demoCourses[index]);
        },
      ),
    );
  }
}
