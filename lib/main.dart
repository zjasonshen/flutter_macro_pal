import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macro_ai/src/features/authentication/presentation/login_page.dart';
import 'package:macro_ai/src/features/tracker/presentation/daily_tracker_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/login', // Set the initial route to login
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/daily-tracker',
      builder: (context, state) => const DailyTrackerPage(),
    ),
  ],
);

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

ThemeData customTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.teal),
    ),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MacroAI',
      theme: customTheme,
      routerConfig: _router,
    );
  }
}
