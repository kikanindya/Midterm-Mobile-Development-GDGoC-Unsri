import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/pages/main_page.dart'; 

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DucklistApp());
}

class DucklistApp extends StatelessWidget {
  const DucklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFFFB86C),
              brightness: Brightness.light,
              surface: const Color(0xFFFFFDF9),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFFFB86C),
              brightness: Brightness.dark,
              surface: const Color(0xFF121212),
            ),
          ),
          themeMode: currentMode,
          // Sekarang aplikasi langsung menuju MainPage
          home: const MainPage(), 
        );
      },
    );
  }
}