import 'package:flutter/material.dart';
import '../widgets/cabang_card.dart'; // Sesuaikan path jika perlu

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFEDEFF5);
  static const Color accentYellow = Color(0xFFFEB800);
}

class DaftarCabangPage extends StatefulWidget {
  const DaftarCabangPage({super.key});

  @override
  State<DaftarCabangPage> createState() => _DaftarCabangPageState();
}

class _DaftarCabangPageState extends State<DaftarCabangPage> {
  String searchQuery = "";
  
  // List data dummy untuk cabang
  List<Map<String, dynamic>> _branches = [];

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() {
    setState(() {
      _branches = [
        {"name": "Blade & Badger", "address": "Jl. Sudirman No. 1, Jakarta"},
        {"name": "The Urban Gent", "address": "Jl. Gatot Subroto No. 45, Jakarta"},
        {"name": "Razor Edge Salon", "address": "Jl. Diponegoro No. 12, Bandung"},
        {"name": "Classic Cut", "address": "Jl. Ahmad Yani No. 88, Surabaya"},
        {"name": "Sharp Scissors", "address": "Jl. Malioboro No. 20, Yogyakarta"},
        {"name": "Gentleman's Grooming", "address": "Jl. Raya Kuta No. 5, Bali"},
        {"name": "Modern Barber Co.", "address": "Jl. Veteran No. 10, Semarang"},
        {"name": "Elite Shave", "address": "Jl. Imam Bonjol No. 33, Medan"},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> branchesList = _branches ?? [];

  List<Map<String, dynamic>> filteredBranches = branchesList.where((branch) {
    final String branchName = (branch["name"] ?? "").toString().toLowerCase();
    return branchName.contains(searchQuery.toLowerCase());
  }).toList();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          "Daftar Cabang",
          style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
        body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
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
            child: filteredBranches.isEmpty
                ? const Center(
                    child: Text(
                      "Cabang tidak ditemukan", 
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredBranches.length,
                    itemBuilder: (context, index) {
                      final branch = filteredBranches[index];
                      return CabangCard(
                        name: branch["name"]!,
                        address: branch["address"]!,
                        logoPath: 'https://via.placeholder.com/150',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}