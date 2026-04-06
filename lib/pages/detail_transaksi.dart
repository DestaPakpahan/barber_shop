import 'package:flutter/material.dart';

class DetailTransaksiPage extends StatelessWidget {
  final String storeName;
  final String date;

  const DetailTransaksiPage({
    super.key,
    required this.storeName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "[ Selesai ]",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              storeName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("Owner: Desta Agustriani",
                style: TextStyle(fontSize: 14)),
            const Text(
              "Rejowinangun Selatan, Kec. Magelang Selatan",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),

            // Informasi Transaksi
            _buildInfoRow("Waktu", ": $date"),
            _buildInfoRow("ID Transaksi", ": TRX-20260404-034"),
            _buildInfoRow("Kasir", ": [K-001] Rony Parulian"),
            _buildInfoRow("Staff", ": [S-003] Yudha Pratama"),
            const Divider(thickness: 1),

            // Rincian Item
            _buildItemRow("Haircut", "1x", "15.000"),
            _buildItemRow("Hair coloring", "1x", "150.000"),
            const Divider(thickness: 1),

            // Total
            _buildTotalRow("Total", "165.000"),
            const Divider(thickness: 1),

            // Pembayaran
            _buildTotalRow("Bayar", "165.000"),
            _buildTotalRow("Kembalian", "0"),
            const Divider(thickness: 1),

            // SaaS Fee / Potongan Saldo
            _buildSaaSRow("Potongan Saldo", "2.000"),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, String qty, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Row(
                children: [
                  Text(qty, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(width: 20),
                  Text("Rp $price", style: const TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
          Text("Rp $price"),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Rp $amount", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSaaSRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text("SaaS Fee - Terpotong Otomatis",
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
          ],
        ),
        Text("Rp $amount", style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
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