import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic responsiveness check
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: isDesktop ? null : _buildMobileAppBar(),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF1E293B)),
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavBar(),
    );
  }

  AppBar _buildMobileAppBar() {
    return AppBar(
      title: const Text('DevSec Scanner'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color(0xFF1E293B), // Subtle border
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: const Color(0xFF0F172A),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'DevSec Scanner',
            style: GoogleFonts.firaCode(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF8FAFC),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Color(0xFF1E293B), height: 1),
          _sidebarItem(icon: Icons.dashboard, title: 'Dashboard', isSelected: true),
          _sidebarItem(icon: Icons.api, title: 'API Scanner'),
          _sidebarItem(icon: Icons.folder_zip, title: 'App Scanner'),
          const Spacer(),
          _sidebarItem(icon: Icons.settings, title: 'Settings'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sidebarItem({required IconData icon, required String title, bool isSelected = false}) {
    return Container(
      color: isSelected ? const Color(0xFF1E293B) : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF94A3B8)),
        title: Text(
          title,
          style: GoogleFonts.firaCode(
            color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF94A3B8),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
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
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0F172A),
      selectedItemColor: const Color(0xFF38BDF8),
      unselectedItemColor: const Color(0xFF94A3B8),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.api), label: 'API'),
        BottomNavigationBarItem(icon: Icon(Icons.folder_zip), label: 'App'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
