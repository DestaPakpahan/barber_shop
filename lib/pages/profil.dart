import 'package:flutter/material.dart';

// Pages
import '../pages/dashboard_page.dart';
import '../pages/owner_all_page.dart';
import '../pages/load_page.dart';

// Screens
import 'wallet.dart';
import 'edit_profil.dart';
import 'password.dart';
import 'system_fee.dart';

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

      // 🔙 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: const Color(0xFF8DA8FF),
                    child: const Text(
                      'DN',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Dian Nugraheni',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Senior Developer & Founder',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 45),

            // 🔐 AKUN
            _buildSectionTitle('Akun & Keamanan'),

            _buildMenuItem('Edit Profil', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfil()),
              );
            }),

            _buildMenuItem('Ubah Kata Sandi', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Password()),
              );
            }),

            const SizedBox(height: 25),

            // ⚙️ KONFIGURASI
            _buildSectionTitle('Konfigurasi SaaS'),

            _buildMenuItem('Sistem Fee per Transaksi', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SystemFee()),
              );
            }),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Text(
                'Versi Aplikasi v2.1.0',
                style: TextStyle(color: Colors.black26, fontSize: 12),
              ),
            ),

            const SizedBox(height: 30),

            // 🚪 LOGOUT
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // 🔥 langsung ke LoadPage + hapus semua halaman
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoadPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // 🔥 NAVBAR AKTIF
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryNavy,
        selectedItemColor: AppColors.accentYellow,
        unselectedItemColor: Colors.white,
        currentIndex: 3,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OwnerAllPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Wallet()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
        ],
      ),
    );
  }

  // 🔹 SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          const Divider(),
        ],
      ),
    );
  }

  // 🔹 MENU ITEM
  Widget _buildMenuItem(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Text(title),
      ),
    );
  }
}
