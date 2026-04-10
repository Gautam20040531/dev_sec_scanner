import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

import '../services/app_scanner_service.dart';

class AppScannerView extends ConsumerStatefulWidget {
  const AppScannerView({super.key});

  @override
  ConsumerState<AppScannerView> createState() => _AppScannerViewState();
}

class _AppScannerViewState extends ConsumerState<AppScannerView> {
  bool _isLoading = false;
  String? _selectedFileName;
  List<Map<String, dynamic>>? _results;

  Future<void> _pickAndAnalyzeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk', 'exe', 'ipa'],
    );

    if (result != null && result.files.single.name.isNotEmpty) {
      final fileName = result.files.single.name;
      final filePath = result.files.single.path ?? 'Unknown Path';

      setState(() {
        _selectedFileName = fileName;
        _isLoading = true;
        _results = null;
      });

      final scanner = ref.read(appScannerServiceProvider);
      final results = await scanner.analyzeAppFile(fileName, filePath);

      if (mounted) {
        setState(() {
          _isLoading = false;
          _results = results;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.folder_zip, size: 64, color: Color(0xFF38BDF8)),
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
              
              if (_isLoading)
                _buildLoadingState()
              else
                _buildFilePickerArea(),
              
              if (_results != null) ...[
                const SizedBox(height: 32),
                _buildResultsSection(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePickerArea() {
    return GestureDetector(
      onTap: _pickAndAnalyzeFile,
      child: Container(
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
              'or click to browse (.apk, .exe)',
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
              onPressed: _pickAndAnalyzeFile,
              icon: const Icon(Icons.upload),
              label: Text(
                'SELECT FILE',
                style: GoogleFonts.firaCode(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
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
          const SizedBox(
            height: 64,
            width: 64,
            child: CircularProgressIndicator(
              color: Color(0xFF38BDF8),
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Analyzing Binary & Manifest...',
            style: GoogleFonts.firaCode(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFF8FAFC),
            ),
          ),
          if (_selectedFileName != null) ...[
            const SizedBox(height: 8),
            Text(
              _selectedFileName!,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.shield, color: Color(0xFF818CF8)),
                const SizedBox(width: 8),
                Text(
                  'Binary Analysis Report',
                  style: GoogleFonts.firaCode(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF8FAFC),
                  ),
                ),
              ],
            ),
          ),
          if (_selectedFileName != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Target: $_selectedFileName',
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: const Color(0xFF38BDF8),
                ),
              ),
            ),
          const Divider(height: 1, color: Color(0xFF334155)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _results!.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFF1E293B)),
            itemBuilder: (context, index) {
              final item = _results![index];
              final isSecure = item['isSecure'] as bool;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Icon(
                  isSecure ? Icons.verified_user : Icons.gpp_bad,
                  color: isSecure ? Colors.greenAccent : Colors.redAccent,
                  size: 28,
                ),
                title: Text(
                  item['title'],
                  style: GoogleFonts.firaCode(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    item['description'],
                    style: GoogleFonts.firaCode(
                      fontSize: 13,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
