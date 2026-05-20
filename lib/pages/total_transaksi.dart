import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:baber/services/api_service.dart'; 
import 'detail_transaksi.dart'; 
import 'owner_all_page.dart';
import 'wallet.dart';
import 'profil.dart';

class TotalTransaksiPage extends StatefulWidget {
  const TotalTransaksiPage({super.key});

  @override
  State<TotalTransaksiPage> createState() => _TotalTransaksiPageState();
}

class _TotalTransaksiPageState extends State<TotalTransaksiPage> {
  final ApiService apiService = ApiService(); 
  int _currentIndex = 0; // 🌟 Ditambahkan agar BottomNavigationBar tidak error

  // Helper: Format string desimal ke Rupiah (e.g., 2000.00 -> Rp 2.000)
  String formatRupiah(dynamic amount) {
    if (amount == null) return "Rp 0";
    final number = double.tryParse(amount.toString()) ?? 0.0;
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(number);
  }

  // Helper: Mengubah format ISO created_at menjadi tanggal yang rapi
  String formatTanggalDatabase(dynamic dateStr) {
    if (dateStr == null || dateStr.toString().isEmpty) return "-";
    try {
      DateTime parsedDate = DateTime.parse(dateStr.toString());
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return dateStr.toString(); 
    }
  }

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
      body: FutureBuilder<List<dynamic>?>(
        future: apiService.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF002583)),
              ),
            );
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text(
                "Gagal memuat data transaksi", 
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }

          List<dynamic> transactions = snapshot.data!;
          int totalTransaksi = transactions.length;

          return Column(
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

              // Ringkasan Transaksi Dinamis
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildSummaryCard(totalTransaksi.toString(), "Total\nTransaksi"),
                    const SizedBox(width: 15),
                    _buildSummaryCard(totalTransaksi.toString(), "Transaksi\nSelesai"), 
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

              // Daftar Transaksi Berdasarkan Database Developer
              Expanded(
                child: transactions.isEmpty
                    ? const Center(
                        child: Text(
                          "Belum ada riwayat transaksi", 
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          
                          String idTransaksi = "TX-#${tx['id'] ?? (index + 1)}";
                          String totalBayar = formatRupiah(tx['amount']); 
                          String metodeBayar = (tx['type'] ?? 'DEDUCTION').toString().toUpperCase(); 
                          String namaOwner = tx['owner'] != null ? tx['owner']['name'] : "Owner";
                          String waktuTampil = formatTanggalDatabase(tx['created_at']);

                          return _buildActivityItem(
                            context,
                            idTransaksi, 
                            waktuTampil,
                            "Fee: $totalBayar | Tipe: $metodeBayar ($namaOwner)",
                            (tx['status'] ?? 'Selesai').toString().toUpperCase(), 
                            'https://placehold.co/150', 
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: _buildBottomNav(),
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002583)),
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

  Widget _buildActivityItem(BuildContext context, String title, String time, String desc, String status, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTransaksiPage(
              storeName: title,
              date: time,
            ),
          ),
        );
      },
      child: Container(
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
                            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            Text(time, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                desc, 
                                style: const TextStyle(fontSize: 12, color: Colors.grey), 
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "[$status]", 
                              style: TextStyle(
                                fontSize: 11, 
                                color: status == 'APPROVED' ? Colors.green : Colors.orange, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNav() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
  //     ),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex,
  //       onTap: (index) {
  //         setState(() {
  //           _currentIndex = index;
  //         });

  //         // Logika rute navigasi menu
  //         switch (index) {
  //           case 0:
  //             break;
  //           case 1:
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerAllPage()));
  //             break;
  //           case 2:
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => const Wallet()));
  //             break;
  //           case 3:
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => const Profil()));
  //             break;
  //         }
  //       },
  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.white,
  //       selectedItemColor: const Color(0xFF002583), // Menggantikan AppColors.primaryNavy
  //       unselectedItemColor: Colors.black38,
  //       selectedFontSize: 11,
  //       unselectedFontSize: 11,
  //       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //         BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Owners'),
  //         BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
  //         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  //       ],
  //     ),
  //  );
  }
//}