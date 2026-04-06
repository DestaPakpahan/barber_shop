import 'package:flutter/material.dart';
import '../widgets/owner_card.dart';
import 'owner_pending_page.dart';

class OwnerAllPage extends StatefulWidget {
  const OwnerAllPage({super.key});

  @override
  State<OwnerAllPage> createState() => _OwnerAllPageState();
}

class _OwnerAllPageState extends State<OwnerAllPage> {
  List<Map<String, dynamic>> owners = [
    {"name": "Desta Pakpahan", "cabang": 2},
    {"name": "Siti Nur Holifa", "cabang": 1},
    {"name": "Sheila Putri", "cabang": 3},
    {"name": "Baskara Putra", "cabang": 2},
    {"name": "Nadin Amizah", "cabang": 2},
    {"name": "Fikriawan", "cabang": 2},
  ];

  List<Map<String, dynamic>> filteredOwners = [];

  @override
  void initState() {
    super.initState();
    filteredOwners = owners;
  }

  void searchOwner(String query) {
    setState(() {
      filteredOwners = owners
          .where(
            (owner) =>
                owner["name"].toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔻 BOTTOM NAV
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Color(0xFF2C3E8F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.home, color: Colors.white),
            ),

            const Icon(Icons.people, color: Color(0xFFFEB800)),

            const Icon(Icons.folder, color: Colors.white),
            const Icon(Icons.person, color: Colors.white),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 🔥 HEADER SEJAJAR
              // 🔥 HEADER (CENTER + BACK SEJAJAR)
              Stack(
                alignment: Alignment.center,
                children: [
                  // 🔙 BACK BUTTON (KIRI)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF002583),
                      ),
                    ),
                  ),

                  // 🎯 TITLE (BENAR-BENAR CENTER)
                  const Text(
                    "Daftar Owner",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002583),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // 🔍 SEARCH (REAL-TIME)
              TextField(
                onChanged: searchOwner,
                decoration: InputDecoration(
                  hintText: "Cari Nama Owner",
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF002583)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF002583)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 🔘 FILTER
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEB800),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Semua"),
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OwnerPendingPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF002583)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Pending"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // 📋 LIST OWNER (DINAMIS)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredOwners.length,
                  itemBuilder: (context, index) {
                    final owner = filteredOwners[index];
                    return OwnerCard(
                      name: owner["name"],
                      cabang: owner["cabang"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
