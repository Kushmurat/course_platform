import 'package:flutter/material.dart';
import '../../data/models/course.dart';
import 'course_chip.dart';

class CourseInfoTab extends StatelessWidget {
  final Course course;
  final double progressFraction;
  final int completedModules;
  final VoidCallback onOpenLink;

  const CourseInfoTab({
    super.key,
    required this.course,
    required this.progressFraction,
    required this.completedModules,
    required this.onOpenLink,
  });

  @override
  Widget build(BuildContext context) {
    final results = course.result ?? [];
    final modules = course.modules ?? [];
    final totalModules = course.modulesCount ?? modules.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Категория (если есть)
          if (course.category != null) ...[
            Text(
              "Категория: ${course.category}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],

          // Количество модулей
          Text(
            "Количество модулей: $totalModules",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Прогресс
          const Text(
            "Ваш прогресс:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: progressFraction,
            minHeight: 10,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 8),

          Text("$completedModules / $totalModules"),

          const SizedBox(height: 24),

          const Text(
            "Описание курса:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(
            course.description ?? "Нет описания",
            style: const TextStyle(fontSize: 15),
          ),

          const SizedBox(height: 24),

          // Результаты
          const Text(
            "Результат:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          ...results.map(
                (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, size: 20, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(child: Text(item)),
              ],
            ),
          ),
          const SizedBox(height: 32),

          ...modules.map(
                (m) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.title ?? "",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),

                  ...m.children.map(
                        (child) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 8),
                          const SizedBox(width: 8),
                          Expanded(child: Text(child)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
