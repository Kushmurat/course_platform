import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Язык приложения',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Русский'),
            trailing: const Icon(Icons.check, color: Colors.blue),
            onTap: () {},
          ),
          ListTile(title: const Text('English'), onTap: () {}),
        ],
      ),
    );
  }
}
