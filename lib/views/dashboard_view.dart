import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/nav_controller.dart';
import 'api_scanner_view.dart';
import 'app_scanner_view.dart';
import 'support_view.dart';

// StatelessWidget এর বদলে ConsumerWidget ব্যবহার করা হলো
class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // এখানে আমরা স্টেট চেক করছি যে ইউজার কত নাম্বার মেনুতে আছে
    final currentIndex = ref.watch(navIndexProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    // মেনু অনুযায়ী কোন পেজটা দেখাবো তার লিস্ট
    final List<Widget> views = [
      _buildHomeContent(),
      const ApiScannerView(),
      const AppScannerView(),
      const SupportView(),
    ];

    return Scaffold(
      appBar: isDesktop ? null : _buildMobileAppBar(),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(ref, currentIndex),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF1E293B)),
          Expanded(
            child: views[currentIndex], // এখানে ক্লিকে ক্লিকে পেজ বদলাবে
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavBar(ref, currentIndex),
    );
  }

  AppBar _buildMobileAppBar() {
    return AppBar(
      title: const Text('DevSec Scanner'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: const Color(0xFF1E293B), height: 1.0),
      ),
    );
  }

  Widget _buildSidebar(WidgetRef ref, int currentIndex) {
    return Container(
      width: 250,
      color: const Color(0xFF0F172A),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'DevSec Scanner',
            style: GoogleFonts.firaCode(
              fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFFF8FAFC), letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Color(0xFF1E293B), height: 1),
          _sidebarItem(ref, currentIndex, index: 0, icon: Icons.dashboard, title: 'Dashboard'),
          _sidebarItem(ref, currentIndex, index: 1, icon: Icons.api, title: 'API Scanner'),
          _sidebarItem(ref, currentIndex, index: 2, icon: Icons.folder_zip, title: 'App Scanner'),
          const Spacer(),
          _sidebarItem(ref, currentIndex, index: 3, icon: Icons.support_agent, title: 'Support'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sidebarItem(WidgetRef ref, int currentIndex, {required int index, required IconData icon, required String title}) {
    final isSelected = currentIndex == index;
    return Container(
      color: isSelected ? const Color(0xFF1E293B) : Colors.transparent,
      child: Tooltip(
        message: 'Open $title',
        waitDuration: const Duration(milliseconds: 500),
        child: ListTile(
          leading: Icon(icon, color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF94A3B8)),
          title: Text(
          title,
          style: GoogleFonts.firaCode(
            color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF94A3B8),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        // ক্লিকে ক্লিকে ইনডেক্স চেঞ্জ করার জাদু
        onTap: () => ref.read(navIndexProvider.notifier).state = index,
      ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Tooltip(
            message: 'DevSec Security Systems',
            child: Icon(Icons.security, size: 64, color: Color(0xFF38BDF8)),
          ),
          const SizedBox(height: 24),
          Text(
            'System Ready.\nSelect a Scanner to begin.',
            textAlign: TextAlign.center,
            style: GoogleFonts.firaCode(fontSize: 18, color: const Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(WidgetRef ref, int currentIndex) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0F172A),
      selectedItemColor: const Color(0xFF38BDF8),
      unselectedItemColor: const Color(0xFF94A3B8),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) => ref.read(navIndexProvider.notifier).state = index,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.api), label: 'API'),
        BottomNavigationBarItem(icon: Icon(Icons.folder_zip), label: 'App'),
        BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'Support'),
      ],
    );
  }
}