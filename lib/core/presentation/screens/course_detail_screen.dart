import 'package:flutter/material.dart';
import '../../data/models/course.dart';
import '../../data/services/api_service.dart';
import '../widgets/course_header.dart';
import '../widgets/course_info_tab.dart';
import '../widgets/course_modules_tab.dart';

const String fallbackImage =
    'sandbox:/mnt/data/Снимок экрана 2025-11-22 в 16.02.19.png';

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

  void _openLink(BuildContext context) {}

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
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: CourseHeader(
                  course: course,
                  fallbackImage: fallbackImage,
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Инфо'),
                      Tab(text: 'Модули'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: FutureBuilder<Course>(
            future: ApiService(
              baseUrl: 'https://skill-lab-backend.onrender.com',
            ).fetchCourse(course.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Ошибка загрузки: ${snapshot.error}"),
                );
              }

              final fullCourse = snapshot.data!;

              return TabBarView(
                children: [
                  CourseInfoTab(
                    course: fullCourse,
                    progressFraction: progressFraction,
                    completedModules: completedModules,
                    onOpenLink: () => _openLink(context),
                  ),
                  CourseModulesTab(course: fullCourse),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
