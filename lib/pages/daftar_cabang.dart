import 'package:flutter/material.dart';
import 'package:baber/services/api_service.dart'; 
import '../widgets/cabang_card.dart'; 

class DaftarCabangPage extends StatefulWidget {
  const DaftarCabangPage({super.key});

  @override
  State<DaftarCabangPage> createState() => _DaftarCabangPageState();
}

class _DaftarCabangPageState extends State<DaftarCabangPage> {
  String searchQuery = "";
  final ApiService apiService = ApiService(); 
  
  // 1. Deklarasikan variabel penampung Future di sini
  late Future<List<dynamic>?> _branchesFuture;

  @override
  void initState() {
    super.initState();
    // 2. Tarik data dari database HANYA SEKALI saat halaman dimuat
    _branchesFuture = apiService.getBranches();
  }

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
          'Daftar Cabang',
          style: TextStyle(
            color: Color(0xFF1A367C), 
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value; // Sekarang setState aman, tidak akan reload API
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari Nama Cabang',
                suffixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF1A367C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF1A367C)),
                ),
              ),
            ),
          ),
          
          // List Cabang
          Expanded(
            child: FutureBuilder<List<dynamic>?>(
              // 3. Panggil variabel penampung, BUKAN memanggil fungsi API langsung
              future: _branchesFuture, 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A367C)),
                    ),
                  );
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return const Center(
                    child: Text(
                      "Gagal memuat data cabang dari database", 
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  );
                }

                List<dynamic> branchData = snapshot.data ?? [];

                // Filter data berdasarkan search bar secara lokal di aplikasi
                List<dynamic> filteredBranches = branchData.where((branch) {
                  final branchName = (branch["name"] ?? "").toString().toLowerCase();
                  return branchName.contains(searchQuery.toLowerCase());
                }).toList();

                if (filteredBranches.isEmpty) {
                  return const Center(
                    child: Text(
                      "Cabang tidak ditemukan atau data kosong", 
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredBranches.length,
                  itemBuilder: (context, index) {
                    final branch = filteredBranches[index];
                    
                    return CabangCard(
                      name: (branch["name"] ?? "Tanpa Nama").toString(),
                      address: (branch["address"] ?? "Alamat tidak tersedia").toString(),
                      logoPath: 'https://via.placeholder.com/150', 
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}