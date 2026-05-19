import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  // ⚠️ WAJIB untuk emulator Android
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

        // ✅ ambil access_token (BUKAN token)
        final token = data['access_token'];

        if (token == null) {
          print("Token tidak ditemukan di response!");
          return null;
        }

        // ✅ simpan ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print("TOKEN LOGIN: $token");

        return data;
      } else {
        print("Login Gagal: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Terjadi kesalahan koneksi: $e");
      return null;
    }
  }

  // ===================== GET OWNERS =====================
  Future<List<dynamic>?> getOwners() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print("TOKEN DI GET OWNERS: $token");

      // ❌ kalau token null, hentikan
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

      print("Status Owners: ${response.statusCode}");
      print("Response Owners: ${response.body}");

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

  // ===================== LOGOUT =====================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    print("Logout berhasil, token dihapus");
  }
}