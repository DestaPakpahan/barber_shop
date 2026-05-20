import 'package:baber/pages/daftar_cabang.dart';
import 'package:flutter/material.dart';
import 'owner_all_page.dart';
import 'profil.dart';
import 'wallet.dart';
import 'total_transaksi.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF); 
  static const Color accentYellow = Color(0xFFFEB800);
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0; // Untuk melacak posisi BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ===================== BODY CONTENT =====================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Hi Developer!,',
              style: TextStyle(color: AppColors.primaryNavy, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Let’s manage the barbershop ecosystem.',
              style: TextStyle(color: AppColors.accentYellow, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Main Card: Total System Fee Collected
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryNavy.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL SYSTEM FEE COLLECTED',
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Rp 16.000.000',
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),                      
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===================================================================
            // HORIZONTAL SCROLLABLE CARD STATISTICS (CLICKABLE & CENTERED)
            // ===================================================================
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  
                  // CARD 1: Total Owners (Clickable)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OwnerAllPage()),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 110,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.cardGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.store, color: AppColors.primaryNavy, size: 18),
                            ),
                            const SizedBox(height: 8),
                            const Text('Total Owners', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            const Text('2', style: TextStyle(color: AppColors.primaryNavy, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // CARD 2: Total Branches (Clickable)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarCabangPage()));
                      },
                      child: Container(
                        width: 150,
                        height: 110,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.cardGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.location_on, color: AppColors.primaryNavy, size: 18),
                            ),
                            const SizedBox(height: 8),
                            const Text('Total Branches', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            const Text('2', style: TextStyle(color: AppColors.primaryNavy, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // CARD 3: Total Transactions (Clickable)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TotalTransaksiPage()));
                      },
                      child: Container(
                        width: 150,
                        height: 110,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.cardGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.receipt_long, color: AppColors.primaryNavy, size: 18),
                            ),
                            const SizedBox(height: 8),
                            const Text('Total Transactions', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('8', style: TextStyle(color: AppColors.primaryNavy, fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Action Button: Navigasi ke SystemFee
            // SizedBox(
            //   width: double.infinity,
            //   height: 54,
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       // Jalankan navigasi ke halaman SystemFee()
            //       // Navigator.push(context, MaterialPageRoute(builder: (context) => const SystemFee()));
            //     },
            //     icon: const Icon(Icons.settings_suggest, color: AppColors.primaryNavy),
            //     label: const Text(
            //       'Kelola Layanan Platform (System Fee)',
            //       style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold, fontSize: 14),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.accentYellow,
            //       elevation: 0,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 28),

            // Transaksi Terakhir Header 
            Row(
              children: [
                const Text(
                  'Transaksi Terakhir',
                  style: TextStyle(color: AppColors.primaryNavy, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(), // <-- Menolak eror, mendorong tombol ke kanan otomatis
                TextButton(
                  onPressed: () {},
                  child: const Text('Lihat Semua', style: TextStyle(color: AppColors.primaryNavy, fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 8),

            // List Riwayat Transaksi Terakhir
            _buildTransactionItem(
              title: 'Budi Barbershop Owner',
              subtitle: 'Biaya sistem transaksi #1 • 2026-05-13',
              amount: 'Rp 2.000',
              status: 'Approved',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // ===================== BOTTOM NAVIGATION BAR =====================
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.cardGrey, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            // Logika navigasi berdasarkan index menu yang dipilih
            switch (index) {
              case 0:
                // Halaman Home (Dashboard) - Kita sudah di sini, jadi tidak perlu push baru
                break;
              case 1:
                // Menuju halaman Owner All saat ikon Owners (index 1) ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerAllPage()),
                );
                break;
              case 2:
                // Menuju halaman Analytics (isi nama kelasnya jika sudah ada)
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Wallet()));
                break;
              case 3:
                // Menuju halaman Settings / System Fee
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profil()));
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryNavy,
          unselectedItemColor: Colors.black38,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),         // Index 0
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Owners'),       // Index 1
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'), // Index 2
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),   // Index 3
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Grid Statistik kecil
  Widget _buildStatGridCard({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryNavy, size: 20),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: AppColors.primaryNavy, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String subtitle,
    required String amount,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menggunakan Spacer sebagai pengganti MainAxisAlignment.between
                Row(
                  children: [
                    Text(
                      title, 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Spacer(), // <--- Ini akan mendorong teks harga ke kanan otomatis
                    Text(
                      amount, 
                      style: const TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}