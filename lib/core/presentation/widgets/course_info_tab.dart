import 'package:flutter/material.dart';
import '../../data/models/course.dart';

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
    final results = course.result;
    final totalModules = course.modulesCount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (course.category != null) ...[
            Text(
              "Категория: ${course.category}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
          ],

          // Status Row
          Row(
            children: [
              const Text(
                "Статус:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              _buildStatusChip(
                "Не начат",
                Colors.grey.shade300,
                Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              _buildStatusChip("В процессе", Colors.blue, Colors.white),
              const SizedBox(width: 6),
              _buildStatusChip("Пройден", Colors.green.shade400, Colors.white),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            "Количество модулей: $totalModules",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ваш прогресс:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                "$completedModules/$totalModules",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: progressFraction,
            minHeight: 6,
            backgroundColor: Colors.grey.shade100,
            color: const Color(0xFF2ECC71), // Bright green like in screenshot
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 24),

          const Text(
            "Описание курса:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(
            course.description ?? "Нет описания",
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
            softWrap: true,
          ),

          const SizedBox(height: 24),

          const Text(
            "Результат:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ...results.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, size: 20, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Modules list is in a separate tab usually, but here it was rendered?
          // Ah, the original code had modules at the bottom too?
          // Checking original code... yes, lines 81-107.
          // But the design screenshot shows "Инфо" and "Модули" tabs.
          // The original code had `...modules.map` at the bottom of Info tab?
          // Let's check the original file content again.
          // Step 11: Yes, it renders modules at the bottom.
          // BUT CourseDetailScreen has a TabBar with "Info" and "Modules".
          // CourseModulesTab likely renders modules.
          // Why did CourseInfoTab render modules too?
          // Maybe it was a mistake in the previous code or a "preview".
          // The screenshot shows the "Info" tab selected. It does NOT show modules list at the bottom of Info.
          // It shows "Результат" and then ends (or cuts off).
          // I will REMOVE the modules list from CourseInfoTab to match the "Info" tab concept.
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
