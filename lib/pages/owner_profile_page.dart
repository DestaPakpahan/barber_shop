import 'package:flutter/material.dart';
import 'detail_cabang.dart';

class OwnerProfilePage extends StatefulWidget {
  final String name;

  const OwnerProfilePage({super.key, required this.name});

  @override
  State<OwnerProfilePage> createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update warna tombol saat tab digeser
    });
  }

  String getInitials(String name) {
    List<String> parts = name.split(" ");
    if (parts.length > 1) {
      return parts[0][0] + parts[1][0];
    }
    return parts[0][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. BAGIAN PROFIL & SALDO (STATIS)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: const Color(0xFF002583),
                    child: Text(
                      getInitials(widget.name),
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002583)),
                  ),
                  const Text("Status Owner: Aktif"),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEB800),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Hubungi Owner"),
                  ),
                  const Divider(height: 30),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Sisa Saldo: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "Rp1.250.000", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Text("Total Deposit: Rp5.000.000"),
                  const Text("Total Terpakai: Rp3.750.000"),
                ],
              ),
            ),

            // 2. TOMBOL TAB (DESAIN ASLI)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _tabController.animateTo(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: _tabController.index == 0 ? const Color(0xFFFEB800) : Colors.transparent,
                      border: _tabController.index == 0 ? null : Border.all(color: const Color(0xFF002583)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Penggunaan Saldo"),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _tabController.animateTo(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: _tabController.index == 1 ? const Color(0xFFFEB800) : Colors.transparent,
                      border: _tabController.index == 1 ? null : Border.all(color: const Color(0xFF002583)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Riwayat Top-up"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 3. BAGIAN TABEL YANG BISA DIGESER
            SizedBox(
              height: 150, // Sesuaikan tinggi tabel agar tidak memakan semua ruang
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTableUsage(),
                  _buildTableTopup(),
                ],
              ),
            ),

            const Divider(height: 30),

            // 4. DAFTAR CABANG (STATIS - TIDAK IKUT GESER)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Daftar Cabang", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: [
                          _cabangCard("Barber King", "Sendangadi, Sleman"),
                          _cabangCard("Barber King", "Wirogunan"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildTableUsage() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _headerRow(["Aktivitas", "Cabang", "Potongan", "Sisa"]),
        _dataRow(["System Fee", "Sleman", "-Rp2.000", "Rp1.248.000"], isUsage: true),
        _dataRow(["System Fee", "Wirogunan", "-Rp2.000", "Rp1.250.000"], isUsage: true),
      ],
    );
  }

  Widget _buildTableTopup() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        _headerRow(["Tanggal", "Metode", "Nominal", "Status"]),
        _dataRow(["01 Apr 2026", "Transfer", "+Rp1.000.000", "Berhasil"], isTopup: true),
        _dataRow(["15 Mar 2026", "Transfer", "+Rp2.000.000", "Berhasil"], isTopup: true),
      ],
    );
  }

  Widget _headerRow(List<String> titles) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        children: titles.map((t) => Expanded(child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))).toList(),
      ),
    );
  }

  Widget _dataRow(List<String> values, {bool isUsage = false, bool isTopup = false}) {
    return Container(
      height: 35,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: values.asMap().entries.map((entry) {
          int idx = entry.key;
          String val = entry.value;
          Color textColor = Colors.black;

          // Logika pewarnaan kolom ke-3 (index 2)
          if (idx == 2) {
            if (isUsage) textColor = Colors.red;
            if (isTopup) textColor = Colors.green;
          }

          return Expanded(
            child: Text(
              val,
              style: TextStyle(fontSize: 10, color: textColor),
            ),
          ); // Penutup Expanded
        }).toList(), // Penutup map().toList()
      ), // Penutup Row
    ); // Penutup Container
  }

  Widget _cabangCard(String name, String lokasi) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CabangDetailPage(
          name: name,
          address: lokasi,
          logoPath: "https://via.placeholder.com/150",
        )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color(0xFFEBF1FD), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF002583),
              child: Text(getInitials(name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(lokasi),
              ],
            ),
          ],
        ),
      ),
    );
  }
}