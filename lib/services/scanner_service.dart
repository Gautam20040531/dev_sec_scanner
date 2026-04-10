import 'package:flutter_riverpod/flutter_riverpod.dart';

final scannerServiceProvider = Provider<ScannerService>((ref) {
  return ScannerService();
});

class ScannerService {
  Future<List<Map<String, dynamic>>> scanUrl(String url) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate realistic result data
    return [
      {
        'title': 'SSL Certificate Valid',
        'isSecure': true,
        'description': 'The target is using a valid TLS certificate issued by a trusted CA.',
      },
      {
        'title': 'Missing HSTS Header',
        'isSecure': false,
        'description': 'Strict-Transport-Security header is missing. Vulnerable to MITM SSL Stripping.',
      },
      {
        'title': 'X-Frame-Options not set',
        'isSecure': false,
        'description': 'Clickjacking protection is missing on the target server.',
      },
      {
        'title': 'Content-Security-Policy',
        'isSecure': false,
        'description': 'CSP header is missing or improperly configured, allowing potential XSS vulnerabilities.',
      },
      {
        'title': 'Server Header Exposed',
        'isSecure': false,
        'description': 'Technology stack is exposed via headers (e.g., Server: nginx/1.18.0).',
      },
    ];
  }
}
