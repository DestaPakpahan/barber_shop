import 'package:flutter/material.dart';

// Pages
import '../pages/dashboard_page.dart';
import '../pages/owner_all_page.dart';

// Screens
import 'profil_screen.dart';
import 'tarik_saldo_screen.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color backgroundLight = Color(0xFFF3F4F6);
  static const Color cardGrey = Color(0xFFEDEFF5);
  static const Color accentYellow = Color(0xFFFEB800);
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔙 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('wallet',
            style: TextStyle(color: Colors.grey, fontSize: 13)),
      ),

      // 🔥 NAVBAR
      bottomNavigationBar: _buildBottomNav(context),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildBalanceCard(context),
                const SizedBox(height: 24),
                _buildChartContainer(child: _buildLineChartSection()),
                const SizedBox(height: 20),
                _buildChartContainer(child: _buildBarChartSection()),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 BALANCE CARD
  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Total Saldo',
                  style: TextStyle(color: Colors.black54, fontSize: 13)),
              Row(
                children: [
                  Text('Riwayat',
                      style:
                          TextStyle(color: Colors.black54, fontSize: 13)),
                  Icon(Icons.chevron_right,
                      size: 18, color: Colors.black54),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Rp12.450.000',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubBalance(
                        'Pendapatan Hari Ini', 'Rp415.000'),
                    const SizedBox(height: 12),
                    _buildSubBalance(
                        'Total Penarikan Saldo', 'Rp5.000.000'),
                  ],
                ),
              ),

              // 🔥 BUTTON TARIK SALDO
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TarikSaldoScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow,
                  foregroundColor: AppColors.primaryNavy,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Tarik Saldo',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubBalance(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.black54, fontSize: 11)),
        Text(amount,
            style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildChartContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _buildLineChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rp',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black54)),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('700', style: TextStyle(fontSize: 10)),
                  Text('500', style: TextStyle(fontSize: 10)),
                  Text('300', style: TextStyle(fontSize: 10)),
                  Text('100', style: TextStyle(fontSize: 10)),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: LineChartPainter(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBarChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rp',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black54)),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('10jt', style: TextStyle(fontSize: 10)),
            const SizedBox(width: 20),
            _barItem(120),
            const SizedBox(width: 15),
            _barItem(60),
          ],
        ),
      ],
    );
  }

  Widget _barItem(double height) {
    return Container(
      width: 25,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // 🔥 NAVBAR AKTIF
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // HOME
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const DashboardPage()),
              );
            },
            child: const Icon(Icons.home_filled,
                color: Colors.white, size: 26),
          ),

          // OWNER
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const OwnerAllPage()),
              );
            },
            child: const Icon(Icons.people_outline,
                color: Colors.white, size: 26),
          ),

          // WALLET (ACTIVE)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentYellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.account_balance_wallet,
                color: AppColors.primaryNavy, size: 24),
          ),

          // PROFIL
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProfilScreen()),
              );
            },
            child: const Icon(Icons.person_outline,
                color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}

// 🔥 CHART
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primaryNavy
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..color = AppColors.primaryNavy;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.75),
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.3),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);

    for (var point in points) {
      canvas.drawCircle(point, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
