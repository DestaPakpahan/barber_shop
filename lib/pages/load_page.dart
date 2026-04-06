import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002583),
      body: Column(
        children: [
          // BAGIAN ATAS (LOGO)
          Expanded(
            flex: 5,
            child: Center(
              child: Image.asset('assets/images/logo.png', width: 200),
            ),
          ),

          // BAGIAN BAWAH (FORM)
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
                    style: const TextStyle(fontSize: 14), // 🔥 teks lebih kecil
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(
                        0xFFE0E6F2,
                      ), // 🔥 lebih gelap dari sebelumnya
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10, // 🔥 bikin lebih pendek
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
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DashboardPage(),
                        ),
                      );
                    },
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
