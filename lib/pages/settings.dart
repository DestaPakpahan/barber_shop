import 'package:flutter/material.dart';
import 'package:baber/services/api_service.dart'; // Sesuaikan dengan path project kamu

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF); 
  static const Color accentYellow = Color(0xFFFEB800);
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<Settings> {
  final ApiService _apiService = ApiService();
  final TextEditingController _feeTransaksiController = TextEditingController();
  final TextEditingController _feeProdukController = TextEditingController();
  final TextEditingController _minSaldoController = TextEditingController();
  
  bool _isLoading = false;

  // Fungsi untuk mengirim data ke database
  Future<void> _simpanSystemFee() async {
    final String inputFee = _feeTransaksiController.text.trim();

    if (inputFee.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Field System Fee per Transaksi tidak boleh kosong!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final int? feeAmount = int.tryParse(inputFee);
    if (feeAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nominal angka yang valid!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Panggil service API
    bool success = await _apiService.updateSystemFee(feeAmount);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biaya sistem berhasil diperbarui ke database!'),
          backgroundColor: Colors.green,
        ),
      );
      // Opsional: Kembali ke halaman sebelumnya jika sukses
      // Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memperbarui data. Cek koneksi atau token.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _feeTransaksiController.dispose();
    _feeProdukController.dispose();
    _minSaldoController.dispose();
    super.dispose();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
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
      title: const Text(
        'Pengaturan Fee',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002583)),
      ),
    ),
    bottomNavigationBar: _buildCustomNavbar(context, 3),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Visual untuk mempercantik halaman
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryNavy.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet, size: 40, color: AppColors.primaryNavy),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("System Fee", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Nominal biaya per transaksi saat ini", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Satu-satunya Input yang dibutuhkan
          _buildInputField(
            label: 'System Fee per Transaksi',
            controller: _feeTransaksiController,
            hint: 'Masukkan nominal fee',
          ),
          
          const Spacer(),

          // Tombol Simpan
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _simpanSystemFee,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
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
        if (index == 2) Navigator.pushReplacementNamed(context, '/wallet');
        if (index == 3) return; // Sudah di halaman Settings
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Owners'),
        BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

// Widget Input Field yang sudah disederhanakan
Widget _buildInputField({
  required String label,
  required TextEditingController controller,
  required String hint,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      const SizedBox(height: 10),
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade50,
          hintText: hint,
          prefixIcon: const Icon(Icons.attach_money, color: AppColors.primaryNavy),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryNavy)),
        ),
      ),
    ],
  );
}
}