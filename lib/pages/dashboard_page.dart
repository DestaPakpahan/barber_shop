import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import 'owner_all_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Color(0xFF2C3E8F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.home, color: Color(0xFFFEB800)),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OwnerAllPage(),
                  ),
                );
              },
              child: const Icon(Icons.people, color: Colors.white),
            ),

            const Icon(Icons.folder, color: Colors.white),
            const Icon(Icons.person, color: Colors.white),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔔 NOTIF
              Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: const [
                    Icon(Icons.notifications,
                        size: 28,
                        color: Color(0xFF002583)),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.red,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 HEADER
              const Text(
                "Hi Developer!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF002583),
                ),
              ),

              const Text(
                "Let's manage the barbershop ecosystem.",
                style: TextStyle(color: Color(0xFFFEB800)),
              ),

              const SizedBox(height: 20),

              // 🔥 PLATFORM OVERVIEW (DULUAN)
              const Text(
                "Platform Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002583),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OwnerAllPage(),
                          ),
                        );
                      },
                      child: const StatCard(
                        title: "Total Owner",
                        value: "12 owner",
                        subtitle: "1 Menunggu Aktivasi",
                        icon: Icons.groups,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: StatCard(
                      title: "Total Cabang",
                      value: "20 cabang",
                      icon: Icons.store,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔥 FINANCIAL MONITORING (PINDAH KE SINI)
              const Text(
                "Financial Monitoring",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002583),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF1FD),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "Rp45.000.000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF002583),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("Total Deposit Owner"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF1FD),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "5 orang",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF002583),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("Owner Perlu Top-Up"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔥 AKTIVITAS

              Container(
  width: double.infinity,
  padding: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: const Color(0xFFDDE3F0), // 🔥 outer abu
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    children: [

      const Text(
        "Aktivitas Saldo Terkini",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF002583),
        ),
      ),

      const SizedBox(height: 10),

      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _activityItem(
              "Top-up Berhasil Siti Nur Holifa +Rp1.000.000 (17:30 WIB)",
            ),

            _divider(),

            _activityItem(
              "Top-up Berhasil Desta Pakpahan +Rp500.000 (15.00)",
            ),

            _divider(),

            _activityItem(
              "Saldo Kritis Fikriawan — Sisa Rp12.000 (Sistem sudah mengirim pengingat)",
            ),

            _divider(),

            _activityItem(
              "Top-up Berhasil Sheila Putri +Rp5.000.000 (09.40)",
            ),
          ],
        ),
      ),
    ],
  ),
),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

Widget _activityItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF002583),
        fontSize: 10,
      ),
    ),
  );
}

Widget _divider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 4),
    color: const Color(0xFFFEB800), // 🔥 garis kuning
  );
}
