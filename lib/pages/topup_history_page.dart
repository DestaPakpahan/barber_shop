import 'package:flutter/material.dart';

class TopupHistoryPage extends StatelessWidget {
  final String name;

  const TopupHistoryPage({super.key, required this.name});

  // 🔥 FUNCTION INISIAL
  String getInitials(String name) {
    List<String> parts = name.split(" ");
    if (parts.length > 1) {
      return parts[0][0] + parts[1][0];
    }
    return parts[0][0];
  }

  // 🔥 ROW TABLE
  Widget buildRow(
      String tanggal, String metode, String nominal, String status) {
    return Container(
      height: 26,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(tanggal, style: const TextStyle(fontSize: 11)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              metode,
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              nominal,
              style: const TextStyle(fontSize: 11, color: Colors.green),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(status, style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // 🔥 CARD CABANG (SUDAH TANPA ASSET)
  Widget cabangCard(String name, String lokasi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF1FD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(lokasi),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🔙 BACK
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),

                const SizedBox(height: 10),

                // 🔥 AVATAR (INISIAL)
                CircleAvatar(
                  radius: 45,
                  backgroundColor: const Color(0xFF002583),
                  child: Text(
                    getInitials(name),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF002583),
                  ),
                ),

                const Text("Status Owner: Aktif"),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEB800),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Hubungi Owner"),
                ),

                const Divider(height: 30),

                // 🔥 SALDO
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Sisa Saldo: Rp1.250.000",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Text("Total Deposit: Rp5.000.000"),
                const Text("Total Terpakai: Rp3.750.000"),

                const Divider(height: 30),

                // 🔘 TAB
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF002583)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("Penggunaan Saldo"),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEB800),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Riwayat Top-up"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔥 TABEL
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tanggal",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Metode",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Nominal",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        buildRow(
                          "01 Apr 2026",
                          "Transfer",
                          "+Rp1.000.000",
                          "Berhasil",
                        ),
                        buildRow(
                          "15 Mar 2026",
                          "Transfer",
                          "+Rp2.000.000",
                          "Berhasil",
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Daftar Cabang"),
                ),

                const SizedBox(height: 10),

                cabangCard("Barber King", "Sendangadi, Sleman"),
                cabangCard("Barber King", "Wirogunan"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
