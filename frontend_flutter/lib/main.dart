import 'package:flutter/material.dart';

import 'pages/login/login_page.dart';

void main() {
  runApp(const CohortApp());
}

class CohortApp extends StatelessWidget {
  const CohortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohort',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF635BFF),
        ),
      ),
      home: const LoginPage(),
    );
  }
}