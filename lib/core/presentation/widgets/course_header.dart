import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/course.dart';

class CourseHeader extends StatelessWidget {
  final Course course;
  final String fallbackImage;

  const CourseHeader({super.key, required this.course, required this.fallbackImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: course.image ?? fallbackImage,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (c, url) => Container(
                height: 180,
                color: Colors.grey.shade100,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (c, url, err) => Container(
                height: 180,
                color: Colors.grey.shade200,
                child: const Center(child: Icon(Icons.broken_image, size: 48)),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // title centered
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            course.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),

        const SizedBox(height: 8),
        const Divider(height: 20, thickness: 1),
      ],
    );
  }
}
