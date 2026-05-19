import 'package:flutter/material.dart';

// Palette Warna Konsisten
class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF); 
  static const Color accentYellow = Color(0xFFFEB800);
}

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy simulasi tampilan
    final List<Map<String, dynamic>> riwayatData = [
      {'title': 'April 2026', 'isHeader': true},
      {'title': 'Penarikan Saldo', 'date': '03 April 2026, 14.40', 'amount': '-Rp1.000.000', 'isPositive': false},
      {'title': 'Pendapatan Masuk', 'date': '03 April 2026, 13.20', 'amount': '+Rp2.000', 'isPositive': true},
      {'title': 'Pendapatan Masuk', 'date': '03 April 2026, 11.00', 'amount': '+Rp2.000', 'isPositive': true},
      {'title': 'Pendapatan Masuk', 'date': '03 April 2026, 10.45', 'amount': '+Rp2.000', 'isPositive': true},
      {'title': 'Pendapatan Masuk', 'date': '02 April 2026, 13.20', 'amount': '+Rp2.000', 'isPositive': true},
      {'title': 'Maret 2026', 'isHeader': true},
      {'title': 'Pendapatan Masuk', 'date': '31 Maret 2026, 13.20', 'amount': '+Rp2.000', 'isPositive': true},
      {'title': 'Penarikan Saldo', 'date': '15 Maret 2026, 09.00', 'amount': '-Rp5.000.000', 'isPositive': false},
    ];

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
          'Riwayat Saldo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        itemCount: riwayatData.length,
        itemBuilder: (context, index) {
          final item = riwayatData[index];

          // Jika item adalah Header Bulan
          if (item['isHeader'] == true) {
            return Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 15),
              child: Text(
                item['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            );
          }

          // Jika item adalah Transaksi
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['date'],
                          style: const TextStyle(
                            color: Colors.black38,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item['amount'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        // Pendapatan menggunakan Navy, Penarikan menggunakan warna gelap standar
                        color: item['isPositive'] 
                            ? AppColors.primaryNavy 
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              // Garis pemisah tipis
              const Divider(color: AppColors.cardGrey, height: 1, thickness: 1.2),
            ],
          );
        },
      ),
    );
  }
}