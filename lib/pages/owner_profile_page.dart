import 'package:flutter/material.dart';
import 'topup_history_page.dart';

class OwnerProfilePage extends StatelessWidget {
  final String name;

  const OwnerProfilePage({super.key, required this.name});

  // 🔥 FUNCTION INISIAL
  String getInitials(String name) {
    List<String> parts = name.split(" ");
    if (parts.length > 1) {
      return parts[0][0] + parts[1][0];
    }
    return parts[0][0];
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

  // 🔥 ROW TABLE
  Widget buildRow(
    String aktivitas,
    String cabang,
    String potongan,
    String sisa,
  ) {
    return Container(
      height: 26,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              aktivitas,
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(cabang, style: const TextStyle(fontSize: 11)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              potongan,
              style: const TextStyle(fontSize: 11, color: Colors.red),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(sisa, style: const TextStyle(fontSize: 11)),
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
                        text: "Sisa Saldo: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Rp1.250.000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEB800),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Penggunaan Saldo"),
                    ),

                    const SizedBox(width: 10),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TopupHistoryPage(name: name),
                          ),
                        );
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
                        child: const Text("Riwayat Top-up"),
                      ),
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
                                flex: 3,
                                child: Text(
                                  "Aktivitas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Cabang",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Potongan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Sisa",
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
                          "System Fee",
                          "Sleman",
                          "-Rp2.000",
                          "Rp1.248.000",
                        ),
                        buildRow(
                          "System Fee",
                          "Wirogunan",
                          "-Rp2.000",
                          "Rp1.250.000",
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
