import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'package:baber/services/api_service.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  // Tambahkan Controller agar data yang kamu ketik bisa dikirim ke API
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  // Fungsi handleLogin disesuaikan untuk mengirim email & password
  void handleLogin() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Menjalankan fungsi login dari ApiService
    final response = await apiService.login(email, password);

    if (response != null && mounted) {
      // Jika login berhasil, lanjut ke Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else {
      // Jika gagal, munculkan pesan error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Gagal! Periksa Email/Password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002583),
      body: Column(
        children: [
          // BAGIAN ATAS (LOGO) - Tetap sama seperti aslimu
          Expanded(
            flex: 5,
            child: Center(
              child: Image.asset('assets/images/logo.png', width: 200),
            ),
          ),

          // BAGIAN BAWAH (FORM) - Tetap sama seperti aslimu
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Welcome Developer!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF002583),
                      ),
                    ),
                  ),

                  const Center(
                    child: Text(
                      "Manage your SaaS ecosystem and monitoring revenues",
                      style: TextStyle(fontSize: 12, color: Color(0xFFFEB800)),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Email"),
                  const SizedBox(height: 5),

                  TextField(
                    controller: emailController, // Menghubungkan controller
                    style: const TextStyle(fontSize: 14), 
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E6F2), 
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10, 
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text("Password"),
                  const SizedBox(height: 5),

                  TextField(
                    controller: passwordController, // Menghubungkan controller
                    obscureText: true,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E6F2),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Lupa Kata Sandi?",
                    style: TextStyle(fontSize: 12, color: Color(0xFF002583)),
                  ),

                  const Spacer(),

                  // BUTTON MASUK
                  GestureDetector(
                    onTap: handleLogin, // Memanggil fungsi login ke API
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEB800),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF002583),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}