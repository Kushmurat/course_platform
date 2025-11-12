import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  const CourseCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Название курса',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'Короткое описание курса...',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
