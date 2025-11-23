import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/course.dart';
import '../widgets/course_header.dart';
import '../widgets/course_info_tab.dart';
import '../widgets/course_modules_tab.dart';

const String fallbackImage = 'sandbox:/mnt/data/Снимок экрана 2025-11-22 в 16.02.19.png';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  final int completedModules;

  const CourseDetailScreen({
    required this.course,
    this.completedModules = 0,
    super.key,
  });

  double get progressFraction {
    if (course.modulesCount <= 0) return 0.0;
    return (completedModules / course.modulesCount).clamp(0.0, 1.0);
  }

  void _openLink(BuildContext context) {
    // передай сюда реализацию url-launcher из своего проекта
    // либо оставь пустым, если не нужно
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: const BackButton(),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // header (image + title)
            CourseHeader(course: course, fallbackImage: fallbackImage),

            // Tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey.shade600,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: 'Инфо'),
                  Tab(text: 'Модули'),
                ],
              ),
            ),

            // Tab views — MUST be in Expanded
            Expanded(
              child: TabBarView(
                children: [
                  CourseInfoTab(
                    course: course,
                    progressFraction: progressFraction,
                    completedModules: completedModules,
                    onOpenLink: () => _openLink(context),
                  ),
                  CourseModulesTab(course: course),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
