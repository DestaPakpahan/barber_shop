import 'package:flutter/material.dart';
import 'package:baber/services/api_service.dart'; // Pastikan path sesuai
import '../widgets/owner_card.dart'; // Pastikan path sesuai
import 'dashboard_page.dart';
import 'wallet.dart';
import 'profil.dart';

// Struktur warna pembantu agar AppColors tidak eror
class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF);
  static const Color accentYellow = Color(0xFFFEB800);
}

class OwnerAllPage extends StatefulWidget {
  const OwnerAllPage({super.key});

  @override
  State<OwnerAllPage> createState() => _OwnerAllPageState();
}

class _OwnerAllPageState extends State<OwnerAllPage> {
  String activeTab = "Semua";
  String searchQuery = "";
  int _currentIndex =
      1; // FIX 1: Ditambahkan agar default aktif di menu Owners (Index 1)
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // FIX 2: Menaruh bottomNavigationBar bawaan scaffold di tempat yang benar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.cardGrey, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            // Logika navigasi berdasarkan index menu yang dipilih
            switch (index) {
              case 0:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                  (route) => false,
                );
                break;
              case 1:
                // Kita sudah berada di halaman Owner All, tidak perlu push baru
                break;
              case 2:
                // Menuju halaman Wallet
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Wallet()),
                );
                break;
              case 3:
                // Menuju halaman Profil
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Profil()),
                );
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryNavy,
          unselectedItemColor: Colors.black38,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ), // Index 0
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Owners',
            ), // Index 1
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Wallet',
            ), // Index 2
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ), // Index 3
          ],
        ),
      ),

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

              // LIST DATA (HANYA DARI API)
              Expanded(
                child: FutureBuilder<List<dynamic>?>(
                  future: apiService.getOwners(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Gagal memuat data dari server",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    List<dynamic> apiData = snapshot.data ?? [];

                    // Logika Filtering
                    List<dynamic> filtered = apiData.where((owner) {
                      final name = (owner["name"] ?? "")
                          .toString()
                          .toLowerCase();
                      final matchesSearch = name.contains(
                        searchQuery.toLowerCase(),
                      );

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
                        child: Text(
                          "Data tidak ditemukan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final owner = filtered[index];

                        if (owner["status"] == "pending") {
                          return PendingCard(
                            id: (owner["id"] ?? "").toString(),
                            name: (owner["name"] ?? "Tanpa Nama").toString(),
                            time: (owner["time"] ?? "Baru saja").toString(),
                            wa: (owner["wa"] ?? "-").toString(),
                            email: (owner["email"] ?? "-").toString(),
                            lokasi: (owner["lokasi"] ?? "-").toString(),
                            rencana: (owner["rencana"] ?? "1").toString(),
                            onRefresh: () {
                              setState(() {});
                            },
                          );
                        } else {
                          return OwnerCard(
                            name: (owner["name"] ?? "Tanpa Nama").toString(),
                            cabang:
                                int.tryParse(owner["cabang"].toString()) ?? 1,
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
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002583),
          ),
        ),
      ],
    );
  }
}

// --- Widget PendingCard ---
class PendingCard extends StatelessWidget {
  final String id;
  final String name;
  final String time;
  final String wa;
  final String email;
  final String lokasi;
  final String rencana;
  final VoidCallback onRefresh;

  const PendingCard({
    super.key,
    required this.id,
    required this.name,
    required this.time,
    required this.onRefresh,
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

  void _processApproval(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    ApiService apiService = ApiService();
    bool isSuccess = await apiService.approveOwner(id);

    Navigator.pop(context);

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Owner berhasil disetujui dan diaktifkan!'),
          backgroundColor: Colors.green,
        ),
      );
      onRefresh();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menyetujui owner. Silakan coba lagi.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
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
          Text(
            "Rencana Cabang: $rencana",
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _processApproval(context),
                  child: _buildActionBtn("Terima", Colors.green),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: _buildActionBtn("Tolak", Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
