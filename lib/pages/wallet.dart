import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_page.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFEDEFF5);
  static const Color accentYellow = Color(0xFFFEB800);
}

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final ApiService apiService = ApiService();

  void _refresh() {
    setState(() {});
  }

  Future<void> _handleUpdateStatus(int id, String action) async {
    bool success = await apiService.updateDepositStatus(id, action);
    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berhasil diperbarui')));
        _refresh();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002583))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () {
            // Ganti Provider dengan Navigator agar kembali ke halaman sebelumnya
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // Jika tidak ada halaman sebelumnya, paksa kembali ke dashboard
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
          },
        ),
      ),
      // TAMBAHKAN NAVBAR DI SINI (Index 2 untuk Wallet)
      bottomNavigationBar: _buildCustomNavbar(context, 2),
      body: FutureBuilder<List<dynamic>?>(
        future: apiService.getDepositRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Data tidak tersedia"));
          }

          final List<dynamic> allData = snapshot.data!;
          final pendingList = allData.where((i) => i['status'].toString().toLowerCase() == 'pending').toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text("Permintaan Top Up", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                pendingList.isEmpty
                    ? const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("Tidak ada permintaan")))
                    : Column(children: pendingList.map((item) => _buildRequestCard(item)).toList()),
              ],
            ),
          );
        },
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
      if (index == 1) Navigator.pushReplacementNamed(context, '/owner_all_page');
      if (index == 2) return; // Sudah di halaman wallet
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

  // Widget ini sekarang sudah berada di DALAM kelas _WalletState
  Widget _buildRequestCard(dynamic item) {
    return Card(
      color: AppColors.cardGrey,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          item['owner']?['name'] ?? 'Unknown',
          style: const TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Rp ${item['amount']}',
          style: const TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 0, 0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () => _handleUpdateStatus(item['id'], 'reject'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text("TOLAK", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () => _handleUpdateStatus(item['id'], 'approve'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text("TERIMA", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}