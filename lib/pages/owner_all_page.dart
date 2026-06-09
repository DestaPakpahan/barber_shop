import 'package:flutter/material.dart';
import 'package:baber/services/api_service.dart';
import 'owner_profile_page.dart';
import '../widgets/owner_card.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFEDEFF5);
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
  final ApiService apiService = ApiService();
  dynamic _selectedOwnerData;
  late Future<List<dynamic>?> _ownersFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _ownersFuture = apiService.getOwners();
    });
  }

  final Map<String, int> _manualBranchOverrides = {"2": 2, "9": 1, "10": 1};

  List<dynamic> _patchOwnerData(List<dynamic> data) {
    return data.map((owner) {
      final String ownerId = (owner["id"] ?? "").toString();
      if (_manualBranchOverrides.containsKey(ownerId)) {
        Map<String, dynamic> patchedOwner = Map<String, dynamic>.from(owner);
        patchedOwner["cabang"] = _manualBranchOverrides[ownerId];
        return patchedOwner;
      }
      return owner;
    }).toList();
  }

  int _getBranchCount(dynamic owner) {
    if (owner["cabang"] != null) return int.tryParse(owner["cabang"].toString()) ?? 0;
    if (owner["branches_count"] != null) return int.tryParse(owner["branches_count"].toString()) ?? 0;
    if (owner["branches"] is List) return (owner["branches"] as List).length;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () {
            if (_selectedOwnerData != null) {
              setState(() => _selectedOwnerData = null);
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
        ),
        title: Text(
          _selectedOwnerData != null ? 'Profil Owner' : 'Daftar Owner',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
        ),
      ),
      body: SafeArea(
        child: _selectedOwnerData != null
            ? OwnerProfilePage(
                ownerData: _selectedOwnerData,
                onBackToList: () => setState(() => _selectedOwnerData = null),
              )
            : _buildOwnerList(),
      ),
      bottomNavigationBar: _buildCustomNavbar(context, 1),
    );
  }

Widget _buildOwnerList() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Search Bar
        TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: InputDecoration(
            hintText: "Cari Nama Owner",
            suffixIcon: const Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.primaryNavy),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // 2. Tab Selection
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: ["Semua", "Pending", "Tidak Aktif"]
                .map((tab) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _buildTabButton(tab),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 15),

        // 3. Data List dengan Total Counter
        Expanded(
          child: FutureBuilder<List<dynamic>?>(
            future: _ownersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Gagal memuat data"));
              }

              final List<dynamic> apiData = _patchOwnerData(snapshot.data ?? []);
              final filtered = apiData.where((owner) {
                final name = (owner["name"] ?? "").toString().toLowerCase();
                final status = (owner["status"] ?? "inactive").toString().toLowerCase();
                final matchesSearch = name.contains(searchQuery.toLowerCase());
                
                bool matchesTab = false;
                if (activeTab == "Semua") {
                  matchesTab = (status == "active");
                } else if (activeTab == "Pending") {
                  matchesTab = (status == "pending");
                } else {
                  matchesTab = (status == "inactive");
                }
                return matchesSearch && matchesTab;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Owner: ${filtered.length}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 16, 
                      color: AppColors.primaryNavy
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final owner = filtered[index];
                        final status = (owner["status"] ?? "inactive").toString().toLowerCase();
                        
                        if (status == "pending") {
                          return PendingCard(
                            id: (owner["id"] ?? "0").toString(),
                            name: owner["name"] ?? "Tanpa Nama",
                            time: owner["time"] ?? "Baru saja",
                            email: owner["email"] ?? "-",
                            onRefresh: _refreshData,
                          );
                        }
                        return OwnerCard(
                          id: (owner["id"] ?? "0").toString(),
                          name: owner["name"] ?? "Tanpa Nama",
                          cabang: _getBranchCount(owner),
                          status: status,
                          ownerData: owner,
                          onTap: () => setState(() => _selectedOwnerData = owner),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

  Widget _buildTabButton(String label) {
    bool isActive = activeTab == label;
    return GestureDetector(
      onTap: () => setState(() => activeTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(color: isActive ? const Color(0xFFFEB800) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF002583))),
        child: Text(label, style: TextStyle(color: isActive ? Colors.black : const Color(0xFF002583), fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCustomNavbar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primaryNavy,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
        if (index == 1) return; 
        if (index == 2) Navigator.pushReplacementNamed(context, '/wallet');
        if (index == 3) Navigator.pushReplacementNamed(context, '/settings'); 
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Owners'),
        BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}


class PendingCard extends StatelessWidget {
  final String id;
  final String name;
  final String time;
  final String email;
  final VoidCallback onRefresh;

  const PendingCard({
    super.key,
    required this.id,
    required this.name,
    required this.time,
    required this.onRefresh,
    this.email = "-",
  });

  String getInitials(String name) {
    final String trimmedName = name.trim();
    if (trimmedName.isEmpty) return "?";
    final List<String> parts = trimmedName.split(" ")..removeWhere((element) => element.trim().isEmpty);
    if (parts.isEmpty) return "?";

    if (parts.length > 1) {
      final String firstInitial = parts[0].isNotEmpty ? parts[0][0] : "";
      final String secondInitial = parts[1].isNotEmpty ? parts[1][0] : "";
      return (firstInitial + secondInitial).toUpperCase();
    }
    return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : "?";
  }

  void _processApproval(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    ApiService apiService = ApiService();
    bool isSuccess = await apiService.approveOwner(id);

    if (context.mounted) Navigator.pop(context);

    if (isSuccess) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Owner berhasil disetujui dan diaktifkan!'),
            backgroundColor: Colors.green,
          ),
        );
      }
      onRefresh();
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyetujui owner. Silakan coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
          Text("Email: $email", style: const TextStyle(fontSize: 13)),
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
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}