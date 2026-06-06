import 'package:flutter/material.dart';
import 'topup_detail_page.dart';

class TopupRequestPage extends StatelessWidget {
  const TopupRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          'Permintaan Top Up',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _requestCard(
            context,
            ownerName: 'Owner Toko A',
            amount: 'Rp500.000',
            status: 'Pending',
          ),

          const SizedBox(height: 14),

          _requestCard(
            context,
            ownerName: 'Owner Toko B',
            amount: 'Rp1.200.000',
            status: 'Pending',
          ),

          const SizedBox(height: 14),

          _requestCard(
            context,
            ownerName: 'Owner Toko C',
            amount: 'Rp850.000',
            status: 'Approved',
          ),
        ],
      ),
    );
  }

  Widget _requestCard(
    BuildContext context, {
    required String ownerName,
    required String amount,
    required String status,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TopupDetailPage(
              ownerName: ownerName,
              amount: amount,
              status: status,
            ),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          children: [

            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: const Color(0xFFE8EDFF),
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.account_balance_wallet,
                color: Color(0xFF002583),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    ownerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              decoration: BoxDecoration(
                color: _statusColor(status).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                status,
                style: TextStyle(
                  color: _statusColor(status),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {

      case 'Approved':
        return Colors.green;

      case 'Rejected':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }
}