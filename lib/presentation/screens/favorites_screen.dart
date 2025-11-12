import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
              ),
            ),
            SizedBox(height: 16),
            Text('Иван Петров', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('student@example.com'),
          ],
        ),
      ),
    );
  }
}
