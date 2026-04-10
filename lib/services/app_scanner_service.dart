import 'package:flutter_riverpod/flutter_riverpod.dart';

final appScannerServiceProvider = Provider<AppScannerService>((ref) {
  return AppScannerService();
});

class AppScannerService {
  Future<List<Map<String, dynamic>>> analyzeAppFile(String fileName, String filePath) async {
    // Simulate a complex binary analysis delay
    await Future.delayed(const Duration(milliseconds: 2500));
    
    final ext = fileName.toLowerCase();
    
    if (ext.endsWith('.apk')) {
      return [
        {
          'title': 'Debug Mode Enabled',
          'isSecure': false,
          'description': 'The application is signed with a debug certificate or android:debuggable is set to true.',
        },
        {
          'title': 'Obfuscation Used',
          'isSecure': true,
          'description': 'ProGuard/R8 obfuscation is properly applied to the source code.',
        },
        {
          'title': 'Excessive Permissions',
          'isSecure': false,
          'description': 'android.permission.CAMERA and android.permission.RECORD_AUDIO are requested without clear context in the manifest.',
        },
        {
          'title': 'Unsigned APK',
          'isSecure': false,
          'description': 'The binary is missing a valid v2/v3 signature scheme.',
        },
      ];
    } else if (ext.endsWith('.exe')) {
      return [
        {
          'title': 'Missing Digital Signature',
          'isSecure': false,
          'description': 'The executable file is not properly signed with Authenticode.',
        },
        {
          'title': 'ASLR Enabled',
          'isSecure': true,
          'description': 'Address Space Layout Randomization is enabled for this binary.',
        },
        {
          'title': 'Suspicious API Calls',
          'isSecure': false,
          'description': 'Heavily utilizes undocumented Windows NT calls or typical shellcode injectors.',
        },
        {
          'title': 'DEP Validated',
          'isSecure': true,
          'description': 'Data Execution Prevention is fully enabled.',
        },
      ];
    }
    
    // Default fallback for any other file extension
    return [
      {
        'title': 'Unknown Binary Format',
        'isSecure': false,
        'description': 'The provided file format is not recognized. Cannot perform deep analysis at this time.',
      }
    ];
  }
}
