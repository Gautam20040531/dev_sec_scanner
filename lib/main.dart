import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: DevSecScannerApp()));
}

class DevSecScannerApp extends StatelessWidget {
  const DevSecScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevSec Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
        primaryColor: const Color(0xFF38BDF8), // Light Blue 400
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          secondary: Color(0xFF818CF8), // Indigo 400
          surface: Color(0xFF1E293B), // Slate 800
        ),
        textTheme: GoogleFonts.firaCodeTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: const Color(0xFFF8FAFC), // Slate 50
          displayColor: const Color(0xFFF8FAFC),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0F172A),
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF38BDF8)),
          titleTextStyle: GoogleFonts.firaCode(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF8FAFC),
            letterSpacing: 1.2,
          ),
        ),
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevSec Scanner'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF1E293B), // Subtle border
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.security,
              size: 64,
              color: Color(0xFF38BDF8),
            ),
            const SizedBox(height: 24),
            Text(
              'System Ready.\nAwaiting Targets.',
              textAlign: TextAlign.center,
              style: GoogleFonts.firaCode(
                fontSize: 18,
                color: const Color(0xFF94A3B8), // Slate 400
              ),
            ),
          ],
        ),
      ),
    );
  }
}