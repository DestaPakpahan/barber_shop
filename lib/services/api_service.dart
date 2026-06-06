import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  // 💡 JIKA PAKAI EMULATOR ANDROID STUDIO: Ganti ke "http://10.0.2.2:8000/api"
  // 💡 JIKA PAKAI HP FISIK: Ganti ke IP Wifi Laptopmu, misal "http://192.168.1.15:8000/api"
  // Sementara kita set ke 10.0.2.2 agar bisa dijangkau oleh Emulator Android.
  final String baseUrl = "http://127.0.0.1:8000/api";

  // ===================== LOGIN =====================
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login/developer'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      print("RESPONSE LOGIN: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];

        if (token == null) {
          print("Token tidak ditemukan di response!");
          return null;
        }

        // Simpan token aktif ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print("TOKEN LOGIN BERHASIL DISIMPAN: $token");
        return data;
      } else {
        print("Login Gagal: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Terjadi kesalahan koneksi saat login: $e");
      return null;
    }
  }

  // ===================== GET OWNERS =====================
  Future<List<dynamic>?> getOwners() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print("Token kosong! Harus login dulu.");
        return null;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/developer/owners'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Gagal mengambil data owners: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error Koneksi Owners: $e");
      return null;
    }
  }

  // ===================== SETUJUI PENDAFTARAN OWNER =====================
  Future<bool> approveOwner(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print("Token kosong! Harus login dulu.");
        return false;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/developer/owners/$id/approve'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal menyetujui owner: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error Koneksi Approve Owner: $e");
      return false;
    }
  }

  // ===================== GET DASHBOARD DATA =====================
  Future<Map<String, dynamic>?> getDashboardData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print("Token kosong! Harus login dulu.");
        return null;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/developer/dashboard'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Gagal mengambil data dashboard: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error Koneksi Dashboard: $e");
      return null;
    }
  }

  // ===================== UPDATE SYSTEM FEE =====================
  Future<bool> updateSystemFee(int fee) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print("Token kosong! Harus login dulu.");
        return false;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/developer/system-fee'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'fee': fee,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal mengupdate system fee: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error Koneksi Update Fee: $e");
      return false;
    }
  }

  // ===================== GET BRANCHES (SUDAH DIPERBAIKI) =====================
  Future<List<dynamic>?> getBranches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); // Ambil token dinamis dari login

      if (token == null) {
        print("Token kosong! Ambil cabang gagal karena belum login.");
        return null;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/branches'), 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      );

      print("Status Get Branches: ${response.statusCode}");
      print("Response Get Branches: ${response.body}");

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        
        // Antisipasi jika data array dibungkus dalam objek map e.g., {"data": [...]}
        if (decodedData is Map && decodedData.containsKey('data')) {
          return decodedData['data'];
        }
        return decodedData; // Kembalikan array langsung jika formatnya [...]
      } else {
        print("Gagal memuat cabang. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error Koneksi Cabang: $e");
      return null;
    }
  }

  // ===================== FETCH DATA TRANSAKSI (SUDAH DIPERBAIKI) =====================
  Future<List<dynamic>?> getTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); 

      if (token == null) {
        print("Token kosong! Gagal mengambil transaksi karena belum login.");
        return null;
      }
      
      final url = Uri.parse('$baseUrl/developer/transactions'); 

      // Tambahkan print ini untuk memastikan URL & Token yang dikirim ke debug console
      print("Menembak URL Transaksi: $url");
      print("Menggunakan Token Aktif: Bearer $token");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status Get Transactions: ${response.statusCode}");
      print("Response Body Get Transactions: ${response.body}");

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        
        // Antisipasi penanganan format JSON Object ataupun Array List
        if (responseData is Map && responseData.containsKey('data')) {
          return responseData['data'] as List<dynamic>;
        } else if (responseData is List) {
          return responseData;
        }
        return null;
      } else {
        print("Gagal Load Transaksi. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error Jaringan pada ApiService (Transactions): $e");
      return null;
    }
  }



  // ===================== LOGOUT =====================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print("Logout berhasil, token dihapus");
  }
}