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

  // 🔥 DATA TOP UP
  final List<Map<String, dynamic>> topupRequests = [
    {
      'ownerName': 'Owner Toko A',
      'amount': 'Rp500.000',
      'status': 'Pending',
    },
    {
      'ownerName': 'Owner Toko B',
      'amount': 'Rp1.200.000',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔥 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Wallet',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
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

                // 🔥 CARD SALDO
                _buildBalanceCard(context),

                const SizedBox(height: 24),

                // 🔥 REQUEST TOPUP
                _buildTopupRequestSection(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 CARD SALDO
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

          const Text(
            'Total Saldo',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Rp12.450.000',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [

              // 🔥 BUTTON TARIK SALDO
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TarikSaldo(),
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
                      vertical: 14,
                    ),
                  ),

                  child: const Text(
                    'Tarik Saldo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // 🔥 BUTTON TOP UP
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TopUpSaldo(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryNavy,
                    elevation: 0,

                    side: const BorderSide(
                      color: AppColors.primaryNavy,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),

                  child: const Text(
                    'Top Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔥 SECTION REQUEST TOPUP
  Widget _buildTopupRequestSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Permintaan Top Up',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          // 🔥 LIST TOP UP
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

  // 🔥 CARD TOPUP
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

          // 🔥 ICON
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: const Color(0xFFE8EDFF),
              borderRadius: BorderRadius.circular(12),
            ),

            child: const Icon(
              Icons.account_balance_wallet,
              color: AppColors.primaryNavy,
            ),
          ),

          const SizedBox(width: 14),

          // 🔥 TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  ownerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  amount,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // 🔥 STATUS / BUTTON
          status == 'Diterima'

              // 🔥 STATUS DITERIMA
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

                  // 🔥 STATUS DITOLAK
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

                  // 🔥 BUTTON ACTION
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // 🔥 BUTTON TOLAK
                        ElevatedButton(
                          onPressed: () {

                            setState(() {
                              topupRequests[index]['status'] =
                                  'Ditolak';
                            });

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  '$ownerName ditolak',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),

                            padding:
                                const EdgeInsets.symmetric(
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

                        // 🔥 BUTTON TERIMA
                        ElevatedButton(
                          onPressed: () {

                            setState(() {
                              topupRequests[index]['status'] =
                                  'Diterima';
                            });

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  '$ownerName diterima',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.accentYellow,

                            foregroundColor:
                                AppColors.primaryNavy,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),

                            padding:
                                const EdgeInsets.symmetric(
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

  // 🔥 BOTTOM NAVBAR
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
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,

        children: [

          // 🔥 HOME
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DashboardPage(),
                ),
              );
            },

            child: const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 26,
            ),
          ),

          // 🔥 OWNER
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const OwnerAllPage(),
                ),
              );
            },

            child: const Icon(
              Icons.people_outline,
              color: Colors.white,
              size: 26,
            ),
          ),

          // 🔥 WALLET ACTIVE
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

          // 🔥 PROFILE
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Profil(),
                ),
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