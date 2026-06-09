import 'package:flutter/material.dart';
import '../pages/owner_profile_page.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFE5E8EF);
  static const Color accentYellow = Color(0xFFFEB800);
}

class OwnerCard extends StatelessWidget {
  final String id;
  final String name;
  final int cabang;
  final String status;
  final Map<String, dynamic> ownerData;
  final VoidCallback onTap; // <--- TAMBAHKAN INI AGAR NAVIGASI TERKONTROL DARI ALL PAGE

  const OwnerCard({
    super.key,
    required this.id,
    required this.name,
    required this.cabang,
    this.status = "active",
    required this.ownerData,
    required this.onTap, // <--- WAJIB DIKONDISIKAN DI KONSTRUKTOR
  });

  String getInitials(String inputName) {
    final String trimmed = inputName.trim();
    if (trimmed.isEmpty) return "?";

    final List<String> parts = trimmed.split(" ")..removeWhere((e) => e.trim().isEmpty);
    if (parts.isEmpty) return "?";

    if (parts.length > 1) {
      final String first = parts[0].isNotEmpty ? parts[0][0] : "";
      final String second = parts[1].isNotEmpty ? parts[1][0] : "";
      return (first + second).toUpperCase();
    }
    return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : "?";
  }

  @override
  Widget build(BuildContext context) {
    bool isInactive = status.toLowerCase() == "inactive" || status.toLowerCase() == "tidak aktif";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap, // <--- MENGGUNAKAN AKSI PANGGILAN DARI ALL PAGE AGAR STATE NAVBAR TIDAK RUSAK
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.cardGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: isInactive ? Colors.grey : AppColors.primaryNavy,
                child: Text(
                  getInitials(name),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: isInactive ? Colors.black54 : Colors.black
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isInactive ? "Akun Non-Aktif" : "$cabang Cabang",
                      style: TextStyle(
                        fontSize: 13, 
                        color: isInactive ? Colors.red : Colors.black54,
                        fontWeight: isInactive ? FontWeight.w500 : FontWeight.normal
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}