import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/scanner_service.dart';

class ApiScannerView extends ConsumerStatefulWidget {
  const ApiScannerView({super.key});

  @override
  ConsumerState<ApiScannerView> createState() => _ApiScannerViewState();
}

class _ApiScannerViewState extends ConsumerState<ApiScannerView> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  List<Map<String, dynamic>>? _results;

  Future<void> _startScan() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;

    setState(() {
      _isLoading = true;
      _results = null;
    });

    final scanner = ref.read(scannerServiceProvider);
    final results = await scanner.scanUrl(url);

    if (mounted) {
      setState(() {
        _isLoading = false;
        _results = results;
      });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
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
              const Icon(Icons.api, size: 64, color: Color(0xFF818CF8)),
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
                      controller: _urlController,
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
                        onPressed: _isLoading ? null : _startScan,
                        icon: _isLoading 
                          ? const SizedBox(
                              width: 20, 
                              height: 20, 
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                            )
                          : const Icon(Icons.radar),
                        label: Text(
                          _isLoading ? 'SCANNING...' : 'START SCAN',
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
                const Icon(Icons.analytics, color: Color(0xFF38BDF8)),
                const SizedBox(width: 8),
                Text(
                  'Scan Results',
                  style: GoogleFonts.firaCode(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF8FAFC),
                  ),
                ),
              ],
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
                  isSecure ? Icons.check_circle : Icons.warning_amber_rounded,
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
