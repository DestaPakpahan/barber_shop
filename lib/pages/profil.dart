import 'package:flutter/material.dart';
import 'load_page.dart';
import 'edit_profil.dart';
import 'password.dart';
// import 'settings.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF);
  static const Color accentYellow = Color(0xFFFEB800);
}

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildHeader(),
            const SizedBox(height: 45),
            _buildSectionTitle('Akun & Keamanan'),
            _buildMenuItem(
              'Edit Profil',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfil())),
            ),
            _buildMenuItem(
              'Ubah Kata Sandi',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Password())),
            ),
            const SizedBox(height: 25),
            Center(
              child: TextButton.icon(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoadPage()),
                  (route) => false,
                ),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.primaryNavy,
            child: Text('DA', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Developer Admin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
              SizedBox(height: 4),
              Text('dev@admin.com', style: TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Text(title, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}