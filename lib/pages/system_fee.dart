import 'package:flutter/material.dart';
import 'package:baber/services/api_service.dart'; // Sesuaikan dengan path project kamu

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF); 
  static const Color accentYellow = Color(0xFFFEB800);
}

class SystemFee extends StatefulWidget {
  const SystemFee({super.key});

  @override
  State<SystemFee> createState() => _SystemFeeScreenState();
}

class _SystemFeeScreenState extends State<SystemFee> {
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'System Fee',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            
            _buildInputField(
              label: 'System Fee per Transaksi',
              controller: _feeTransaksiController,
              hint: 'Contoh: 2000',
            ),
            
            const SizedBox(height: 18),
            
            _buildInputField(
              label: 'System Fee per Produk (Belum Didukung API Backend)',
              controller: _feeProdukController,
              hint: '0',
              enabled: false, // Di-disable dulu sementara karena API belum siap
            ),
            
            const SizedBox(height: 18),
            
            _buildInputField(
              label: 'Minimal Saldo untuk Transaksi (Belum Didukung API Backend)',
              controller: _minSaldoController,
              hint: '0',
              enabled: false, // Di-disable dulu sementara karena API belum siap
            ),

            const Spacer(),

            // Tombol Simpan / Loading Indicator
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _simpanSystemFee,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow,
                  disabledBackgroundColor: AppColors.accentYellow.withOpacity(0.6),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryNavy,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        'Simpan',
                        style: TextStyle(
                          color: AppColors.primaryNavy,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: enabled ? Colors.black : Colors.black45,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: enabled ? AppColors.cardGrey : AppColors.cardGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.w500,
              color: enabled ? Colors.black : Colors.black38,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}