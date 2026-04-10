import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApiScannerView extends StatelessWidget {
  const ApiScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.api, size: 64, color: Color(0xFF818CF8)), // Indigo
            const SizedBox(height: 24),
            Text(
              'API Vulnerability Scanner',
              style: GoogleFonts.firaCode(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF8FAFC),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter a target URL to check for common misconfigurations.',
              textAlign: TextAlign.center,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 48),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF334155), width: 1),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    style: GoogleFonts.firaCode(color: const Color(0xFFF8FAFC)),
                    decoration: InputDecoration(
                      hintText: 'https://api.example.com/v1',
                      hintStyle: GoogleFonts.firaCode(color: const Color(0xFF475569)),
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
                      prefixIcon: const Icon(Icons.link, color: Color(0xFF818CF8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF334155)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF334155)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF818CF8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF818CF8),
                        foregroundColor: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.radar),
                      label: Text(
                        'START SCAN',
                        style: GoogleFonts.firaCode(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
