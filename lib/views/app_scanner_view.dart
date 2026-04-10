import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppScannerView extends StatelessWidget {
  const AppScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_zip, size: 64, color: Color(0xFF38BDF8)), // Light Blue
            const SizedBox(height: 24),
            Text(
              'Binary App Scanner',
              style: GoogleFonts.firaCode(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF8FAFC),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze APK, IPA, or EXE files for insecure configurations.',
              textAlign: TextAlign.center,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: const Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 48),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF38BDF8).withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Color(0xFF94A3B8),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Drag & Drop File Here',
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'or click to browse',
                    style: GoogleFonts.firaCode(
                      fontSize: 14,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF38BDF8),
                      side: const BorderSide(color: Color(0xFF38BDF8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.upload),
                    label: Text(
                      'SELECT FILE',
                      style: GoogleFonts.firaCode(fontWeight: FontWeight.w600),
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
