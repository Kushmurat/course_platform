import 'package:flutter/material.dart';

class CourseInfoScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseInfoScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final List results = course["result"] ?? [];
    final List modules = course["modules"] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(course["title"] ?? "Курс"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Количество модулей
            Text(
              "Количество модулей: ${course["modulesCount"] ?? modules.length}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Прогресс
            Text("Ваш прогресс:",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: 1 / (course["modulesCount"] ?? 10),
              minHeight: 10,
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 8),
            Text("1/${course["modulesCount"] ?? 10}"),

            const SizedBox(height: 24),

            // Описание
            const Text(
              "Описание курса:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              course["description"] ?? "Нет описания",
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 24),

            // Результаты
            const Text(
              "Результат:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...results.map((item) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, size: 20, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(child: Text(item)),
              ],
            )),
            const SizedBox(height: 32),

            // Модули
            const Text(
              "Модули курса:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...modules.map((m) {
              return Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m["title"] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    ...((m["children"] ?? []) as List).map((c) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 8),
                          const SizedBox(width: 8),
                          Expanded(child: Text(c)),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
