import 'package:flutter/material.dart';
import '../widgets/owner_card.dart';

class OwnerAllPage extends StatefulWidget {
  const OwnerAllPage({super.key});

  @override
  State<OwnerAllPage> createState() => _OwnerAllPageState();
}

class _OwnerAllPageState extends State<OwnerAllPage> {
  String activeTab = "Semua";
  String searchQuery = "";

  // 1. Data Gabungan (Diberi flag 'status')
  final List<Map<String, dynamic>> allOwners = [
    {"name": "Desta Pakpahan", "cabang": 2, "status": "active"},
    {"name": "Siti Nur Holifa", "cabang": 1, "status": "active"},
    {"name": "Ahmad Zaki - Gentleman Cut", "status": "pending", "time": "2 hours ago", "wa": "0812-3456-7891", "email": "Zaki@gmail.com", "lokasi": "Condongcatur, Sleman", "rencana": 1},
    {"name": "Sheila Putri", "cabang": 3, "status": "active"},
    {"name": "Baskara Putra", "cabang": 2, "status": "active"},
    {"name": "Nadin Amizah", "cabang": 2, "status": "active"},
    {"name": "Fikriawan", "cabang": 2, "status": "active"},
  ];

  List<Map<String, dynamic>> filteredOwners = [];

  @override
  void initState() {
    super.initState();
    _applyFilter();
  }

  void _applyFilter() {
    setState(() {
      filteredOwners = allOwners.where((owner) {
        final matchesSearch = owner["name"].toLowerCase().contains(searchQuery.toLowerCase());
        
        bool matchesTab;
        if (activeTab == "Semua") {
          matchesTab = (owner["status"] == "active");
        } else {
          matchesTab = (owner["status"] == "pending");
        }
        return matchesSearch && matchesTab;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 15),
              
              // SEARCH
              TextField(
                onChanged: (value) {
                  searchQuery = value;
                  _applyFilter();
                },
                decoration: InputDecoration(
                  hintText: "Cari Nama Owner",
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF002583)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF002583)),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),

              // FILTER TABS
              Row(
                children: [
                  _buildTabButton("Semua"),
                  const SizedBox(width: 10),
                  _buildTabButton("Pending"),
                ],
              ),

              const SizedBox(height: 15),

              // LIST DINAMIS
              Expanded(
                child: filteredOwners.isEmpty
                    ? const Center(child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        itemCount: filteredOwners.length,
                        itemBuilder: (context, index) {
                          final owner = filteredOwners[index];
                          
                          if (owner["status"] == "pending") {
                            return PendingCard(
                              name: owner["name"],
                              time: owner["time"] ?? "",
                              wa: owner["wa"] ?? "-",
                              email: owner["email"] ?? "-",
                              lokasi: owner["lokasi"] ?? "-",
                              rencana: owner.containsKey("rencana") ? owner["rencana"].toString() : "-",
                            );
                          } else {
                            return OwnerCard(
                              name: owner["name"],
                              cabang: owner["cabang"],
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTabButton(String label) {
    bool isActive = activeTab == label;
    return GestureDetector(
      onTap: () {
        activeTab = label;
        _applyFilter();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFEB800) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF002583)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : const Color(0xFF002583),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Color(0xFF002583)),
          ),
        ),
        const Text(
          "Daftar Owner",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002583)),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: Color(0xFF2C3E8F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.home, color: Colors.white),
          ),
          const Icon(Icons.people, color: Color(0xFFFEB800)),
          const Icon(Icons.folder, color: Colors.white),
          const Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}


class PendingCard extends StatelessWidget {
  final String name;
  final String time;
  final String wa;
  final String email;
  final String lokasi;
  final String rencana;

  const PendingCard({
    super.key, 
    required this.name, 
    required this.time,
    this.wa = "-",
    this.email = "-",
    this.lokasi = "-",
    this.rencana = "-",
  });

  String getInitials(String name) {
    List<String> parts = name.split(" ");
    if (parts.length > 1) return parts[0][0] + parts[1][0];
    return parts[0][0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF1FD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF002583),
                child: Text(
                  getInitials(name),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("WhatsApp: $wa"),
          Text("Email: $email"),
          Text("Lokasi: $lokasi"),
          Text("Rencana Cabang: $rencana"),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildActionBtn("Terima", Colors.green),
              const SizedBox(width: 10),
              _buildActionBtn("Tolak", Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}