import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnerProfilePage extends StatefulWidget {
  final Map<String, dynamic> ownerData;
  final VoidCallback onBackToList;

  const OwnerProfilePage({
    super.key, 
    required this.ownerData, 
    required this.onBackToList
  });

  @override
  State<OwnerProfilePage> createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage> {
  
  // Fungsi mengambil inisial nama yang aman dari error index out of range
  String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "?";
    }

    List<String> parts = name.trim().split(" ")..removeWhere((e) => e.trim().isEmpty);
    if (parts.isEmpty) return "?";

    if (parts.length > 1) {
      String firstInitial = parts[0].isNotEmpty ? parts[0][0] : "";
      String secondInitial = parts[1].isNotEmpty ? parts[1][0] : "";
      return (firstInitial + secondInitial).toUpperCase();
    }
    
    return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : "?";
  }

  // Fungsi helper untuk parsing data cabang secara aman dari berbagai format API
  List<dynamic> _parseBranches() {
    final rawBranches = widget.ownerData["branches"];
    
    if (rawBranches == null) return [];
    
    // Jika formatnya sudah berupa List/Array (Ideal)
    if (rawBranches is List) {
      return rawBranches;
    }
    
    // Jika format dari backend tidak sengaja terkirim berupa String JSON
    if (rawBranches is String) {
      try {
        final parsed = jsonDecode(rawBranches);
        if (parsed is List) return parsed;
      } catch (e) {
        return [];
      }
    }
    
    return [];
  }

  @override
  Widget build(BuildContext context) {
    // Parsing data dasar owner dengan aman
    final String ownerName = widget.ownerData["name"]?.toString() ?? "Tanpa Nama";
    final String ownerEmail = widget.ownerData["email"]?.toString() ?? "-";
    final String ownerStatus = widget.ownerData["status"]?.toString() ?? "Active";
    
    // Mengambil data cabang lewat fungsi proteksi
    final List<dynamic> daftarCabang = _parseBranches();

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text(
      //     "Profil Owner", // Ganti dari "Daftar Owner" ke "Profil Owner"
      //     style: TextStyle(
      //       color: Color(0xFF002583), 
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   // Jika ingin menampilkan tombol back otomatis, 
      //   // jangan komentar/hilangkan leading, biarkan default atau set secara eksplisit
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Color(0xFF002583)),
      //     onPressed: () => Navigator.pop(context), // Cara termudah kembali ke halaman sebelumnya
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CARD PROFIL UTAMA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF1FD),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: const Color(0xFF002583),
                    child: Text(
                      getInitials(ownerName),
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ownerName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Status: ${ownerStatus.toUpperCase()}",
                          style: TextStyle(
                            color: ownerStatus.toLowerCase() == 'active' ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // DETAIL INFORMASI
            const Text(
              "Informasi Kontak",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF002583)),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.email, color: Color(0xFF002583)),
              title: const Text("Email"),
              subtitle: Text(ownerEmail),
              trailing: IconButton(
                icon: const Icon(Icons.open_in_new, color: Color(0xFF002583)),
                tooltip: "Buka Gmail",
                onPressed: () async {
                  final Uri gmailUrl = Uri.parse('https://mail.google.com');
                  
                  try {
                    await launchUrl(
                      gmailUrl,
                      mode: LaunchMode.externalApplication,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Tidak dapat membuka Gmail")),
                    );
                  }
                },
              ),
            ),
            const Divider(height: 30, thickness: 1),

            // SEKSI DAFTAR CABANG
            const Text(
              "Daftar Cabang Yang Dikelola",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF002583)),
            ),
            const SizedBox(height: 12),

            if (daftarCabang.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.storefront, color: Colors.grey, size: 40),
                    SizedBox(height: 8),
                    Text(
                      "Belum memiliki cabang yang terdaftar",
                      style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: daftarCabang.length,
                itemBuilder: (context, index) {
                  final cabang = daftarCabang[index];
                  final String namaCabang = cabang["name"]?.toString() ?? "Cabang Tanpa Nama";
                  final String alamatCabang = cabang["address"]?.toString() ?? cabang["location"]?.toString() ?? "Lokasi belum diatur";

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF002583).withOpacity(0.2)),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF002583),
                        child: Icon(Icons.store, color: Colors.white),
                      ),
                      title: Text(
                        namaCabang,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(alamatCabang),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}