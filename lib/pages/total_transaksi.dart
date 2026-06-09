import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:baber/services/api_service.dart';
import 'detail_transaksi.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFEDEFF5);
  static const Color accentYellow = Color(0xFFFEB800);
}

class TotalTransaksiPage extends StatefulWidget {
  const TotalTransaksiPage({super.key});

  @override
  State<TotalTransaksiPage> createState() => _TotalTransaksiPageState();
}

class _TotalTransaksiPageState extends State<TotalTransaksiPage> {
  final ApiService apiService = ApiService();

  String formatRupiah(dynamic amount) {
    if (amount == null) return "Rp 0";
    final number = double.tryParse(amount.toString()) ?? 0.0;
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(number);
  }

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
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            },
          ),
        title: const Text(
          "Riwayat SaaS Fee",
          style: TextStyle(color: AppColors.primaryNavy, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 0, // Mengatur jarak antara tombol back dan teks
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
              child: Text("Gagal memuat data transaksi", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            );
          }

          List<dynamic> transactions = snapshot.data!;
          int totalTransaksi = transactions.length;

          return Column(
            children: [
              const SizedBox(height: 20),
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
              Expanded(
                child: transactions.isEmpty
                    ? const Center(child: Text("Belum ada riwayat transaksi", style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          String idTransaksi = "TX-${tx['id'] ?? (index + 1)}";
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
    );
  }

  Widget _buildSummaryCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: const Color(0xFFEBF2FF), borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002583))),
            const SizedBox(height: 5),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, String title, String time, String desc, String status, String imgUrl) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(radius: 25, backgroundImage: NetworkImage(imgUrl)),
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
                            Expanded(child: Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey), overflow: TextOverflow.ellipsis)),
                            Text("[$status]", style: TextStyle(fontSize: 11, color: status == 'APPROVED' ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
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
}