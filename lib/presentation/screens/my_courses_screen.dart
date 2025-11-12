import 'package:flutter/material.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мои курсы')),
      body: const Center(
        child: Text(
          'Вы ещё не записаны ни на один курс 😅',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
