import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final double horizontalPadding = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 4),
              // Big Course Banner
              _CourseBanner(
                title: 'Основы программирования\nна Python',
                progress: 0.4,
                lessonsText: '4/10 Уроков',
                buttonText: 'Продолжить курс',
                imageUrl:
                'https://images.pexels.com/photos/1181675/pexels-photo-1181675.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
              ),
              const SizedBox(height: 18),
              // "Популярные курсы" header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Популярные курсы',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Посмотреть все'),
                  )
                ],
              ),
              const SizedBox(height: 8),
              // Courses list
              Expanded(
                child: ListView.separated(
                  itemCount: sampleCourses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final course = sampleCourses[index];
                    return CourseCard(course: course);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseBanner extends StatelessWidget {
  final String title;
  final double progress;
  final String lessonsText;
  final String buttonText;
  final String imageUrl;

  const _CourseBanner({
    required this.title,
    required this.progress,
    required this.lessonsText,
    required this.buttonText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
          ),
        ),
        child: Stack(
          children: [
            // Top-left pill
            Positioned(
              left: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Прохожу',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            // Top-right avatar
            Positioned(
              right: 12,
              top: 8,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                ),
              ),
            ),
            // Title & progress area
            Positioned(
              left: 16,
              right: 16,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Progress + lessons count
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: Colors.white.withOpacity(0.4),
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.greenAccent.shade400),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        lessonsText,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Center(
                        child: Text(buttonText,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Course {
  final String category;
  final String title;
  final String subtitle;
  final String imageUrl;

  Course({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

final List<Course> sampleCourses = [
  Course(
    category: 'Frontend',
    title: 'Разработка интерактивных интерфейсов с использованием React',
    subtitle: 'Количество модулей: 5',
    imageUrl:
    'https://images.unsplash.com/photo-1523473827532-6c2b2c47c4b4?auto=format&fit=crop&w=400&q=60',
  ),
  Course(
    category: 'Mobile',
    title: 'Создание Android-приложений на Kotlin: от идеи до публикации',
    subtitle: 'Количество модулей: 5',
    imageUrl:
    'https://images.unsplash.com/photo-1530881045903-7b2d6f6f8a1f?auto=format&fit=crop&w=400&q=60',
  ),
  Course(
    category: 'Backend',
    title:
    'REST и GraphQL API: проектирование и интеграция серверной логики',
    subtitle: 'Количество модулей: 5',
    imageUrl:
    'https://images.unsplash.com/photo-1526378723331-cd4b5f7a5a6e?auto=format&fit=crop&w=400&q=60',
  ),
  Course(
    category: 'UI/UX Design',
    title:
    'Основы UX/UI-дизайна: принципы, композиция и пользовательский опыт',
    subtitle: 'Количество модулей: 5',
    imageUrl:
    'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=400&q=60',
  ),
  Course(
    category: 'Backend',
    title:
    'Работа с базами данных и SQL: проектирование и запросы на практике',
    subtitle: 'Количество модулей: 5',
    imageUrl:
    'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=400&q=60',
  ),
];

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // card container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          // image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              course.imageUrl,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // text area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Text(
                      course.category,
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



