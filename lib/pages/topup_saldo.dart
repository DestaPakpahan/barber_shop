import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF002583);
  static const Color accentYellow = Color(0xFFFEB800);
  static const Color cardGrey = Color(0xFFF4F5F7);
}

class TopUpSaldo extends StatefulWidget {
  const TopUpSaldo({super.key});

  @override
  State<TopUpSaldo> createState() => _TopUpSaldoState();
}

class _TopUpSaldoState extends State<TopUpSaldo> {

  final TextEditingController nominalController =
      TextEditingController();

  String selectedMethod = 'Bank BCA';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

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
          'Top Up Saldo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔥 CARD INFO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: AppColors.cardGrey,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    'Saldo Saat Ini',
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
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      Expanded(
                        child: _infoCard(
                          title: 'Minimum',
                          value: 'Rp50.000',
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _infoCard(
                          title: 'Biaya Admin',
                          value: 'Gratis',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // 🔥 INPUT NOMINAL
            const Text(
              'Nominal Top Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                hintText: 'Masukkan nominal',

                prefixText: 'Rp ',

                filled: true,
                fillColor: AppColors.cardGrey,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 26),

            // 🔥 QUICK NOMINAL
            const Text(
              'Pilih Cepat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 14),

            Wrap(
              spacing: 10,
              runSpacing: 10,

              children: [

                _quickButton('100000'),
                _quickButton('250000'),
                _quickButton('500000'),
                _quickButton('1000000'),
              ],
            ),

            const SizedBox(height: 30),

            // 🔥 PAYMENT METHOD
            const Text(
              'Metode Pembayaran',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 14),

            _paymentMethod(
              title: 'Bank BCA',
              icon: Icons.account_balance,
            ),

            const SizedBox(height: 12),

            _paymentMethod(
              title: 'Bank Mandiri',
              icon: Icons.account_balance_wallet,
            ),

            const SizedBox(height: 12),

            _paymentMethod(
              title: 'E-Wallet',
              icon: Icons.wallet,
            ),

            const SizedBox(height: 40),

            // 🔥 BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {

                  showDialog(
                    context: context,

                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        title: const Text(
                          'Top Up Berhasil',
                        ),

                        content: Text(
                          'Permintaan top up sebesar Rp ${nominalController.text} berhasil dikirim.',
                        ),

                        actions: [

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryNavy,

                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),

                child: const Text(
                  'Ajukan Top Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔥 INFO CARD
  Widget _infoCard({
    required String title,
    required String value,
  }) {

    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 QUICK BUTTON
  Widget _quickButton(String nominal) {

    return GestureDetector(
      onTap: () {
        setState(() {
          nominalController.text = nominal;
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: AppColors.primaryNavy,
          ),
        ),

        child: Text(
          'Rp ${_formatNominal(nominal)}',

          style: const TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 🔥 PAYMENT METHOD
  Widget _paymentMethod({
    required String title,
    required IconData icon,
  }) {

    final isSelected = selectedMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = title;
        });
      },

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE8EDFF)
              : Colors.white,

          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: isSelected
                ? AppColors.primaryNavy
                : Colors.grey.shade300,
          ),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: AppColors.primaryNavy,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  // 🔥 FORMAT NOMINAL
  String _formatNominal(String number) {

    return number.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}