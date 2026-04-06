import 'package:flutter/material.dart';

class OwnerPendingPage extends StatefulWidget {
  const OwnerPendingPage({super.key});

  @override
  State<OwnerPendingPage> createState() => _OwnerPendingPageState();
}

class _OwnerPendingPageState extends State<OwnerPendingPage> {

  List<Map<String, String>> pendingOwners = [
    {"name": "Ahmad Zaki - Gentelman Cut", "time": "2 hours ago"},
  ];

  List<Map<String, String>> filteredOwners = [];

  @override
  void initState() {
    super.initState();
    filteredOwners = pendingOwners;
  }

  // 🔍 FUNCTION SEARCH
  void searchOwner(String query) {
    setState(() {
      filteredOwners = pendingOwners
          .where((owner) => owner["name"]!
              .toLowerCase()
              .contains(query.toLowerCase()))
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

              // 🔥 HEADER
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          color: Color(0xFF002583)),

                    ),
                  ),
                  const Text(
                    "Owner Pending",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002583),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // 🔍 SEARCH AKTIF
              TextField(
                onChanged: searchOwner,
                decoration: InputDecoration(
                  hintText: "Cari Nama Owner",
                  suffixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFF002583),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFF002583),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 🔘 FILTER
              Row(
                children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF002583),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Semua"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEB800),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Pending"),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // 📋 LIST DINAMIS
              Expanded(
                child: filteredOwners.isEmpty
                    ? const Center(
                        child: Text(
                          "Owner tidak ditemukan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredOwners.length,
                        itemBuilder: (context, index) {
                          final owner = filteredOwners[index];
                          return PendingCard(
                            name: owner["name"]!,
                            time: owner["time"]!,
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


class PendingCard extends StatelessWidget {
  final String name;
  final String time;

  const PendingCard({super.key, required this.name, required this.time});

  String getInitials(String name) {
    List<String> parts = name.split(" ");
    if (parts.length > 1) {
      return parts[0][0] + parts[1][0];
    }
    return parts[0][0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF1FD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 HEADER
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF002583),
                child: Text(
                  getInitials(name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // 🔤 NAMA + WAKTU
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children :[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text("WhatsApp: 0812-3456-7891"),
          const Text("Email: Zaki@gmail.com"),
          const Text("Lokasi: Condongcatur, Sleman"),
          const Text("Rencana Cabang: 1"),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Terima",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("Tolak", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
