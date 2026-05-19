import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';

// Pages
import 'owner_all_page.dart';
import 'daftar_cabang.dart';
import 'total_transaksi.dart';
import 'notifikasi.dart';

// Screens
import '../screens/wallet_screen.dart';
import '../screens/profil_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔥 BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Color(0xFF2C3E8F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // HOME (aktif)
            const Icon(Icons.home, color: Color(0xFFFEB800)),

            // OWNER
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OwnerAllPage(),
                  ),
                );
              },
              child: const Icon(Icons.people, color: Colors.white),
            ),

            // WALLET 🔥
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WalletScreen(),
                  ),
                );
              },
              child: const Icon(Icons.account_balance_wallet, color: Colors.white),
            ),

            // PROFIL 🔥
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilScreen(),
                  ),
                );
              },
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔔 NOTIF
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotifikasiPage()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications,
                          size: 28,
                          color: Color(0xFF002583),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 10,
                              minHeight: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // HEADER
                const Text(
                  "Hi Developer!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF002583),
                  ),
                ),
                const Text(
                  "Let's manage the barbershop ecosystem.",
                  style: TextStyle(color: Color(0xFFFEB800)),
                ),

                const SizedBox(height: 20),

                // PLATFORM OVERVIEW
                const Text(
                  "Platform Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF002583),
                  ),
                ),
                const SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildStatCardWrapper(
                        context,
                        const StatCard(
                          title: "Total Owner",
                          value: "12 owner",
                          subtitle: "1 Menunggu Aktivasi",
                          icon: Icons.groups,
                        ),
                        const OwnerAllPage(),
                      ),
                      const SizedBox(width: 15),
                      _buildStatCardWrapper(
                        context,
                        const StatCard(
                          title: "Total Cabang",
                          value: "20 cabang",
                          icon: Icons.store,
                        ),
                        const DaftarCabangPage(),
                      ),
                      const SizedBox(width: 15),
                      _buildStatCardWrapper(
                        context,
                        const StatCard(
                          title: "Total Transaksi",
                          value: "124 transaksi",
                          icon: Icons.receipt_long,
                        ),
                        const TotalTransaksiPage(),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // FINANCIAL
                const Text(
                  "Financial Monitoring",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF002583),
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    _financialBox("Rp45.000.000", "Total Deposit Owner"),
                    const SizedBox(width: 10),
                    _financialBox("5 orang", "Owner Perlu Top-Up"),
                  ],
                ),

                const SizedBox(height: 20),

                // AKTIVITAS
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE3F0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Aktivitas Saldo Terkini",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF002583),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _activityItem("Top-up Berhasil Siti +Rp1.000.000"),
                            _divider(),
                            _activityItem("Top-up Desta +Rp500.000"),
                            _divider(),
                            _activityItem("Saldo Kritis Fikriawan"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCardWrapper(BuildContext context, Widget card, Widget targetPage) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage)),
        child: card,
      ),
    );
  }

  Widget _financialBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF1FD),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002583)),
            ),
            const SizedBox(height: 5),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _activityItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF002583), fontSize: 10),
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: const Color(0xFFFEB800),
    );
  }
}
