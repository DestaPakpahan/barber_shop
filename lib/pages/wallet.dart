import 'package:flutter/material.dart';

// Pages
import '../pages/dashboard_page.dart';
import '../pages/owner_all_page.dart';

// Screens
import 'profil.dart';
import 'tarik_saldo.dart';
import 'topup_saldo.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color cardGrey = Color(0xFFEDEFF5);
  static const Color accentYellow = Color(0xFFFEB800);
}

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  double totalSaldo = 12450000;
  final List<Map<String, dynamic>> topupRequests = [
    {'ownerName': 'Owner Toko A', 'amount': 'Rp500.000', 'status': 'Pending'},
    {'ownerName': 'Owner Toko B', 'amount': 'Rp1.200.000', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Wallet',
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryNavy,
        unselectedItemColor: Colors.black38,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
              break;

            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OwnerAllPage()),
              );
              break;

            case 2:
              break;

            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Profil()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Owners'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              children: [
                const SizedBox(height: 10),

                _buildBalanceCard(context),

                const SizedBox(height: 24),

                _buildTopupRequestSection(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Saldo',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Rp${totalSaldo.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              //Expanded(
                //child: ElevatedButton(
                  //onPressed: () async {
                    //final result = await Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (_) => const TarikSaldo()),
                    //);

                    //print("Hasil dari TarikSaldo = $result");

                    //if (result != null && result is int) {
                     // setState(() {
                       // totalSaldo -= result;
                     // });
                    //}
                  //},
                  //style: ElevatedButton.styleFrom(
                    //backgroundColor: AppColors.accentYellow,
                    //foregroundColor: AppColors.primaryNavy,
                    //elevation: 0,
                    //shape: RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(12),
                   // ),
                  //),
                  //child: const Text(
                    //'Tarik Saldo',
                    //style: TextStyle(fontWeight: FontWeight.bold),
                 // ),
                //),
              //),

              const SizedBox(width: 10),

              //Expanded(
              //child: ElevatedButton(
              //onPressed: () {
              //Navigator.push(
              //context,
              //MaterialPageRoute(builder: (_) => const TopUpSaldo()),
              //);
              //},
              //style: ElevatedButton.styleFrom(
              //backgroundColor: Colors.white,
              //foregroundColor: AppColors.primaryNavy,
              //elevation: 0,
              //shape: RoundedRectangleBorder(
              //borderRadius: BorderRadius.circular(12),
              //),
              //),
              //child: const Text(
              //'Top Up',
              //style: TextStyle(fontWeight: FontWeight.bold),
              //),
              //),
              //),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopupRequestSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Permintaan Top Up',
            style: TextStyle(
              color: AppColors.primaryNavy,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          ...topupRequests.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _topupCard(
                index: index,
                ownerName: item['ownerName'],
                amount: item['amount'],
                status: item['status'],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _topupCard({
    required int index,
    required String ownerName,
    required String amount,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.circular(12),
            ),

            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ownerName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  amount,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),

          status == 'Diterima'
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Text(
                    'Diterima',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              : status == 'Ditolak'
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Text(
                    'Ditolak',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          topupRequests[index]['status'] = 'Ditolak';
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$ownerName ditolak'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),

                      child: const Text(
                        'Tolak',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    ElevatedButton(
                      onPressed: () {
                        final nominal = int.parse(
                          amount
                              .replaceAll('Rp', '')
                              .replaceAll('.', '')
                              .trim(),
                        );

                        setState(() {
                          topupRequests[index]['status'] = 'Diterima';
                          totalSaldo += nominal;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$ownerName diterima (+Rp${nominal.toString()})',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentYellow,

                        foregroundColor: AppColors.primaryNavy,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),

                      child: const Text(
                        'Terima',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget_buildBottomNav(BuildContext context) {
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
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            },

            child: const Icon(Icons.home_filled, color: Colors.white, size: 26),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OwnerAllPage()),
              );
            },

            child: const Icon(
              Icons.people_outline,
              color: Colors.white,
              size: 26,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: AppColors.accentYellow,
              borderRadius: BorderRadius.circular(10),
            ),

            child: const Icon(
              Icons.account_balance_wallet,
              color: AppColors.primaryNavy,
              size: 24,
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Profil()),
              );
            },

            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
