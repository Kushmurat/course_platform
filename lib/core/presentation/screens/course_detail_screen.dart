import 'package:flutter/material.dart';
import '../../data/models/course.dart';
import '../../data/services/api_service.dart';
import '../../data/services/favorites_service.dart';
import '../../data/services/basket_service.dart';
import '../widgets/course_info_tab.dart';
import '../widgets/course_modules_tab.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  final int completedModules;

  const CourseDetailScreen({
    required this.course,
    this.completedModules = 0,
    super.key,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late Future<Course> _courseFuture;
  final FavoritesService _favoritesService = FavoritesService();
  final BasketService _basketService = BasketService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _courseFuture = ApiService(
      baseUrl: 'https://skill-lab-backend.onrender.com',
    ).fetchCourse(widget.course.id);
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFav = await _favoritesService.isFavorite(widget.course.id);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    await _favoritesService.toggleFavorite(widget.course.id);
    await _checkFavoriteStatus();
  }

  double get progressFraction {
    if (widget.course.modulesCount <= 0) return 0.0;
    return (widget.completedModules / widget.course.modulesCount).clamp(
      0.0,
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // 1. AppBar with Back and Favorite buttons
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: BackButton(color: Colors.black),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 2. Course Image and Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Course Image Card
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: widget.course.image != null
                              ? DecorationImage(
                                  image: NetworkImage(widget.course.image!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.blueAccent, // Fallback color
                        ),
                        child: widget.course.image == null
                            ? const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Course Title
                      Text(
                        widget.course.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // 3. Pinned TabBar
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverTabBarDelegate(
                  const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: "Инфо"),
                      Tab(text: "Модули"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder<Course>(
            future: _courseFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Нет данных'));
              }

              final fullCourse = snapshot.data!;

              return TabBarView(
                children: [
                  CourseInfoTab(
                    course: fullCourse,
                    progressFraction: progressFraction,
                    completedModules: widget.completedModules,
                    onOpenLink: () {},
                  ),
                  CourseModulesTab(course: fullCourse),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<Course>(
              future: _courseFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                final course = snapshot.data!;

                return Row(
                  children: [
                    if (course.price != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          course.price!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E73FF),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await _basketService.addToBasket(course.id);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Курс добавлен в корзину'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Ошибка: $e')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E73FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'В корзину',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
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
