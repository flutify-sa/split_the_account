import 'package:flutter/material.dart';
import 'share_account_page.dart';

void main() => runApp(const ShareAccountApp());

class ShareAccountApp extends StatefulWidget {
  const ShareAccountApp({super.key});

  @override
  State<ShareAccountApp> createState() => _ShareAccountAppState();
}

class _ShareAccountAppState extends State<ShareAccountApp> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account Share',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.amber,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: ShareAccountPage(onThemeToggle: _toggleTheme),
    );
  }
}
