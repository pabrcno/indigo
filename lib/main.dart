import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indigo/screens/patients_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Titles
          headlineMedium: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold), // Large text (e.g., BMI value)
          titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87), // Smaller titles
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),

          // Secondary body text
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.05),
        ),
      ),
      home: const PatientsScreen(),
    );
  }
}
