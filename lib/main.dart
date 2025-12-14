import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/data/services/auth_service.dart';
import 'core/presentation/screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          AuthService(baseUrl: 'https://skill-lab-backend.onrender.com'),
      child: const CourseApp(),
    ),
  );
}

class CourseApp extends StatelessWidget {
  const CourseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueAccent),
      home: const SplashScreen(),
    );
  }
}
