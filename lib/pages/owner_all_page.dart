import 'package:flutter/material.dart';
import 'package:baber/services/api_service.dart'; // Pastikan path sesuai
import '../widgets/owner_card.dart'; // Pastikan path sesuai

class OwnerAllPage extends StatefulWidget {
  const OwnerAllPage({super.key});

  @override
  State<OwnerAllPage> createState() => _OwnerAllPageState();
}

class _OwnerAllPageState extends State<OwnerAllPage> {
  String activeTab = "Semua";
  String searchQuery = "";
  final ApiService apiService = ApiService();

  // Data Dummy untuk fallback jika API kosong atau offline
  final List<Map<String, dynamic>> dummyOwners = [
    {"name": "Desta Pakpahan", "cabang": 2, "status": "active"},
    {"name": "Siti Nur Holifa", "cabang": 1, "status": "active"},
    {
      "name": "Ahmad Zaki - Gentleman Cut",
      "status": "pending",
      "time": "2 hours ago",
      "wa": "0812-3456-7891",
      "email": "Zaki@gmail.com",
      "lokasi": "Condongcatur, Sleman",
      "rencana": 1
    },
    {"name": "Sheila Putri", "cabang": 3, "status": "active"},
  ];

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
              
              // INPUT PENCARIAN
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
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

              // TAB FILTER
              Row(
                children: [
                  _buildTabButton("Semua"),
                  const SizedBox(width: 10),
                  _buildTabButton("Pending"),
                ],
              ),

              const SizedBox(height: 15),

              // LIST DATA (API + DUMMY)
              Expanded(
                child: FutureBuilder<List<dynamic>?>(
                  future: apiService.getOwners(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Menggabungkan Data Real API dan Data Dummy
                    List<dynamic> apiData = snapshot.data ?? [];
                    List<dynamic> combinedData = [...apiData, ...dummyOwners];

                    // Logika Filtering
                    List<dynamic> filtered = combinedData.where((owner) {
                      final name = (owner["name"] ?? "").toString().toLowerCase();
                      final matchesSearch = name.contains(searchQuery.toLowerCase());
                      
                      bool matchesTab;
                      if (activeTab == "Semua") {
                        matchesTab = (owner["status"] == "active");
                      } else {
                        matchesTab = (owner["status"] == "pending");
                      }
                      return matchesSearch && matchesTab;
                    }).toList();

                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.grey)),
                      );
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final owner = filtered[index];
                        
                        if (owner["status"] == "pending") {
                          return PendingCard(
                            name: (owner["name"] ?? "Tanpa Nama").toString(),
                            time: (owner["time"] ?? "Baru saja").toString(),
                            wa: (owner["wa"] ?? "-").toString(),
                            email: (owner["email"] ?? "-").toString(),
                            lokasi: (owner["lokasi"] ?? "-").toString(),
                            rencana: (owner["rencana"] ?? "1").toString(),
                          );
                        } else {
                          return OwnerCard(
                            name: (owner["name"] ?? "Tanpa Nama").toString(),
                            cabang: int.tryParse(owner["cabang"].toString()) ?? 1,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Helper ---

  Widget _buildTabButton(String label) {
    bool isActive = activeTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = label;
        });
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

// --- Widget PendingCard ---
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
          Text("WhatsApp: $wa", style: const TextStyle(fontSize: 13)),
          Text("Email: $email", style: const TextStyle(fontSize: 13)),
          Text("Lokasi: $lokasi", style: const TextStyle(fontSize: 13)),
          Text("Rencana Cabang: $rencana", style: const TextStyle(fontSize: 13)),
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
          child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}