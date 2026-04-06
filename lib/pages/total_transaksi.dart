import 'package:flutter/material.dart';
import 'detail_transaksi.dart'; 

class TotalTransaksiPage extends StatelessWidget {
  const TotalTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Judul
          const Text(
            "Riwayat Transaksi",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002583),
            ),
          ),
          const Text(
            "Aktivitas layanan di semua cabang",
            style: TextStyle(color: Color(0xFFFEB800), fontSize: 12),
          ),
          const SizedBox(height: 25),

          // Ringkasan Transaksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSummaryCard("10", "Transaksi\nHari Ini"),
                const SizedBox(width: 15),
                _buildSummaryCard("1.126", "Transaksi\nBulan Ini"),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Judul List
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Aktivitas Terbaru",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Daftar Transaksi
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildActivityItem(
                  context,
                  "The Gentle Cut - Magelang",
                  "5m ago",
                  "Haircut & Coloring | Staff: Yudha",
                  "https://via.placeholder.com/150",
                ),
                _buildActivityItem(
                  context,
                  "Barber King - Sleman",
                  "13m ago",
                  "Haircut & Wash | Staff: Roni",
                  "https://via.placeholder.com/150",
                ),
                _buildActivityItem(
                  context,
                  "Urban Cut - Yogyakarta",
                  "15m ago",
                  "Shaving | Staff: Baba",
                  "https://via.placeholder.com/150",
                ),
                _buildActivityItem(
                  context,
                  "Barber King - Taman Siswa",
                  "25m ago",
                  "Haircut Kids | Staff: Budi",
                  "https://via.placeholder.com/150",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSummaryCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF2FF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Menambahkan BuildContext context ke dalam parameter fungsi
  Widget _buildActivityItem(BuildContext context, String store, String time, String desc, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTransaksiPage(
              storeName: store,
              date: time,
            ),
          ),
        );
      },
      child: Container( // Menggunakan Container agar area klik lebih luas
        color: Colors.transparent, 
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(store, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            const Text("[Selesai]", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF2C3E8F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home, color: Color(0xFFFEB800)),
          Icon(Icons.people, color: Colors.white),
          Icon(Icons.business_center, color: Colors.white),
          Icon(Icons.account_circle, color: Colors.white),
        ],
      ),
    );
  }
}