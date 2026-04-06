import 'package:flutter/material.dart';

class CabangDetailPage extends StatelessWidget {
  final String name;
  final String address;
  final String logoPath;

  const CabangDetailPage({
    super.key,
    required this.name,
    required this.address,
    this.logoPath = "https://via.placeholder.com/150",
  });

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // Menghilangkan teks "Detail Cabang" di title agar lebih clean jika sudah ada logo di bawah
          title: const Text("Detail Cabang"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      // Menggunakan logoPath dari parameter
                      backgroundImage: NetworkImage(logoPath),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name, // Menggunakan parameter namaCabang
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF002583)),
                    ),
                    const Text("Owner: Desta Agustriani",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              _buildSectionHeader("Lokasi"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(address), // Menggunakan parameter lokasiCabang
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEB800)),
                    child: const Text("Lihat Maps",
                        style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
              const Divider(),

              _buildSectionHeader("Performa Cabang"),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Total Transaksi : 100 Transaksi"),
                    Text("Kontribusi Komisi : Rp200.000"),
                  ],
                ),
              ),
              const Divider(),

              _buildSectionHeader("Daftar Staff (3 staff)"),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildStaffItem("Aris Setiawan", "Kasir"),
                    _buildStaffItem("Roni Wijaya", "Barber"),
                    _buildStaffItem("Gani Rahman", "Barber"),
                  ],
                ),
              ),
              const Divider(),

              _buildSectionHeader("Layanan"),
              _buildPriceItem("Haircut", "Rp35.000 - Rp45.000"),
              _buildPriceItem("Haircut + Cuci", "Rp45.000 - Rp55.000"),
              _buildPriceItem("Cukur Jenggot", "Rp15.000 - Rp25.000"),
              _buildPriceItem("Semir Hitam", "Rp50.000 - Rp75.000"),
              _buildPriceItem("Gentlemen Grooming", "Rp60.000 - Rp85.000"),
              _buildPriceItem("Haircut Anak", "Rp50.000 - Rp65.000"),
              const Divider(),

              _buildSectionHeader("Produk"),
              _buildPriceItem("Pomade (Water-based)", "Rp65.000 - Rp150.000"),
              _buildPriceItem("Pomade (Oil-based)", "Rp50.000 - Rp120.000"),
              _buildPriceItem("Hair Clay", "Rp80.000 - Rp150.000"),
              _buildPriceItem('Hair Powder', 'Rp45.000 - Rp95.000'),
              _buildPriceItem('Hair Tonic', 'Rp55.000 - Rp100.000'),
              const Divider(),

              _buildSectionHeader("Riwayat Transaksi"),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                },
                children: [
                  _buildTableRow("Layanan", "Staff", "Tanggal Transaksi",
                      isHeader: true),
                  _buildTableRow("Haircut + Wash", "Roni", "3-4-2026 14:20 WIB"),
                  _buildTableRow("Kids Haircut", "Gani", "3-4-2026 13:45 WIB"),
                  _buildTableRow("Haircut + Wash", "Roni", "3-4-2026 14:20 WIB"),
                  _buildTableRow("Kids Haircut", "Gani", "3-4-2026 13:45 WIB"),
                  _buildTableRow("Haircut + Wash", "Roni", "3-4-2026 14:20 WIB"),
                  _buildTableRow("Kids Haircut", "Gani", "3-4-2026 13:45 WIB"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    // Widget pendukung (Header, StaffItem, PriceItem, TableRow) tetap sama
    Widget _buildSectionHeader(String title) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      );
    }

    Widget _buildStaffItem(String name, String role) {
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
            Text(name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text(role, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );
    }

    Widget _buildPriceItem(String title, String price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(price)],
      );
    }

    TableRow _buildTableRow(String col1, String col2, String col3,
        {bool isHeader = false}) {
      return TableRow(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(col1,
                  style: TextStyle(
                      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(col2,
                  style: TextStyle(
                      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(col3,
                  style: TextStyle(
                      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11))),
        ],
      );
    }
  }