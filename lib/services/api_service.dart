import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // ===================== LOGIN =====================
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login/developer'),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print("DEBUG LOGIN: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['access_token']);
        return data;
      }
      return null;
    } catch (e) {
      print("ERROR LOGIN: $e");
      return null;
    }
  }

  // ===================== GET OWNERS =====================
  Future<List<dynamic>?> getOwners() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('$baseUrl/developer/owners'), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data is List ? data : (data['data'] ?? []);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> approveOwner(String id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(Uri.parse('$baseUrl/developer/owners/$id/approve'), headers: headers);
      return response.statusCode == 200;
    } catch (e) {
      print("Error Approve: $e");
      return false;
    }
  }

  // ===================== DASHBOARD & TRANSAKSI =====================
  Future<Map<String, dynamic>?> getDashboardData() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('$baseUrl/developer/dashboard'), headers: headers);
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>?> getTransactions() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('$baseUrl/developer/transactions'), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data is List ? data : (data['data'] as List? ?? []);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ===================== DEPOSITS =====================
  Future<List<dynamic>?> getDepositRequests() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('$baseUrl/developer/deposits/requests'), headers: headers);

      print("🌐 Status Code: ${response.statusCode}");
      print("📦 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map) {
          if (decoded.containsKey('data')) return decoded['data'] as List<dynamic>;
          if (decoded.containsKey('deposits')) return decoded['deposits'] as List<dynamic>;
        } else if (decoded is List) {
          return decoded;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("❌ Error Exception: $e");
      return null;
    }
  }

    Future<bool> updateDepositStatus(int id, String action) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(Uri.parse('$baseUrl/developer/deposits/requests/$id/$action'), headers: headers);
      return response.statusCode == 200;
    } catch (e) {
      print("Error Update Status: $e");
      return false;
    }
  }

  Future<bool> updateSystemFee(int fee) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/developer/system-fee'),
        headers: headers,
        body: jsonEncode({'fee': fee}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error Update Fee: $e");
      return false;
    }
  }

  Future<List<dynamic>?> getBranches() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('$baseUrl/developer/branches'), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data is List ? data : (data['data'] ?? []);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ===================== LOGOUT =====================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}