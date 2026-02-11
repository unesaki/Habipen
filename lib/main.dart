import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Habit Penguin',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Hiragino Sans',
        // Color Palette
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5C6BC0), // Soft Indigo
          primary: const Color(0xFF5C6BC0),
          secondary: const Color(0xFF26C6DA), // Cyan accent
          surface: Colors.white,
          background: const Color(0xFFF5F7FA), // Ice Blue Grey
          surfaceTint: Colors.white, // Remove tint on cards
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        
        // Component Themes
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF2C3E50), 
            fontSize: 18, 
            fontWeight: FontWeight.bold, 
            fontFamily: 'Hiragino Sans'
          ),
          iconTheme: IconThemeData(color: Color(0xFF2C3E50)),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE0E0E0), width: 1), // Subtle border
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: const Color(0xFF5C6BC0),
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      routerConfig: router,
    );
  }
}
