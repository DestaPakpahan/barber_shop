import 'package:flutter/material.dart';
import '../pages/detail_cabang.dart'; 

class CabangCard extends StatelessWidget {
  final String name;
  final String address;
  final String logoPath;

  const CabangCard({
    super.key,
    required this.name,
    required this.address,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 2. Logika navigasi saat kartu diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CabangDetailPage(
              name: name,
              logoPath: logoPath,
              address: address,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF2FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(logoPath), 
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}