import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildNotificationItem(
            title: "Top-up Berhasil",
            desc: "Owner Siti Nur Halifa telah menambah saldo sebesar Rp1.000.000",
          ),
          _buildNotificationItem(
            title: "Saldo Kritis",
            desc: "Sisa saldo Owner Baskara Putra kurang dari Rp50.000. Segera ingatkan untuk top-up",
          ),
          _buildNotificationItem(
            title: "Pendapatan Masuk",
            desc: "Selamat! Saldo Developer bertambah +Rp2.000 dari transaksi di Barber King Sleman",
          ),
          _buildNotificationItem(
            title: "Potongan saldo -Rp2.000 dari Barber King Sleman (Owner: Desta Agustriani) berhasil",
            desc: "",
            isSingleText: true,
          ),
          _buildNotificationItem(
            title: "Pendapatan Masuk",
            desc: "Selamat! Saldo Developer bertambah +Rp2.000 dari transaksi di Gentelman Cut",
          ),
          _buildNotificationItem(
            title: "Registrasi Baru",
            desc: "Ahmad Zaki telah mendaftar sebagai Owner baru. Silakan lakukan verifikasi akun",
          ),
          _buildNotificationItem(
            title: "Top-up Berhasil",
            desc: "Owner Desta Agustriani telah menambah saldo sebesar Rp3.000.000",
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String desc,
    bool isSingleText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              if (!isSingleText) const SizedBox(height: 4),
              if (!isSingleText)
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}