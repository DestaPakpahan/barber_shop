import 'package:flutter/material.dart';
import 'package:baber/pages/daftar_cabang.dart';
import 'owner_all_page.dart';
import 'total_transaksi.dart';
import 'notifikasi.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFEDEFF5);
  static const Color accentYellow = Color(0xFFFEB800);
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildCustomNavbar(context, 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 50),

            // HEADER: Profil, Teks, dan Notifikasi
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/profil'),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryNavy,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'DA',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hi Developer!',
                        style: TextStyle(color: AppColors.primaryNavy, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Let’s manage the barbershop ecosystem.',
                        style: TextStyle(color: AppColors.accentYellow, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: AppColors.primaryNavy, size: 28),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifikasiPage()));
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // TOTAL SAAS FEE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: AppColors.primaryNavy.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'TOTAL SAAS FEE COLLECTED',
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rp 16.000',
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // STAT CARDS SECTION
            Row(
              children: [
                _buildStatCard(context, Icons.store, 'Branches', const DaftarCabangPage()),
                const SizedBox(width: 12),
                _buildStatCard(context, Icons.receipt_long, 'Transactions', const TotalTransaksiPage()),
              ],
            ),
                const SizedBox(height: 30),
                _buildRecentActivity(), // Tambahkan ini di sini
                const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String title, Widget destinationPage) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destinationPage)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primaryNavy, size: 28),
              const SizedBox(height: 12),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildRecentActivity() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Recent Activities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavy,
            ),
          ),
        ),
        // List data dummy yang lebih banyak
        _buildActivityItem(Icons.person_add, 'New owner signup: "Blade & Badger"', '2 minutes ago'),
        _buildActivityItem(Icons.account_balance_wallet, 'Top-up request: \$500.00 from "The Urban Gent"', '1 hour ago'),
        _buildActivityItem(Icons.update, 'System update v1.0.4 deployed', '1 hour ago'),
        _buildActivityItem(Icons.store_mall_directory, 'New branch added: "Classic Cut"', '3 hours ago'),
        _buildActivityItem(Icons.report_problem, 'Payment failed: "Sharp Scissors"', '5 hours ago'),
        _buildActivityItem(Icons.notifications_active, 'User feedback received: "Great service!"', 'yesterday'),
        _buildActivityItem(Icons.security, 'Security patch applied', '2 days ago'),
      ],
    ),
  );
}

Widget _buildActivityItem(IconData icon, String title, String time) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cardGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: AppColors.primaryNavy),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildCustomNavbar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primaryNavy,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) return;
        if (index == 1) Navigator.pushReplacementNamed(context, '/owner_all_page');
        if (index == 2) Navigator.pushReplacementNamed(context, '/wallet');
        if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Owners'),
        BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}