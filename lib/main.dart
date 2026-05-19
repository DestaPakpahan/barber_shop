import 'package:flutter/material.dart';

// Pages
import 'pages/load_page.dart';

// Screens
import 'screens/wallet_screen.dart';
import 'screens/tarik_saldo_screen.dart';
import 'screens/riwayat_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/edit_profil_screen.dart';
import 'screens/password_screen.dart';
import 'screens/system_fee_screen.dart';

void main() {
  runApp(const BaberApp());
}

class BaberApp extends StatelessWidget {
  const BaberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baber',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB800),
        ),
      ),

      home: const LoadPage(),

      routes: {
        '/wallet': (context) => const WalletScreen(),
        '/tarik-saldo': (context) => const TarikSaldoScreen(),
        '/riwayat': (context) => const RiwayatScreen(),
        '/profil': (context) => const ProfilScreen(),
        '/edit-profil': (context) => const EditProfilScreen(),
        '/ubah-password': (context) => const PasswordScreen(),
        '/system-fee': (context) => const SystemFeeScreen(),
      },
    );
  }
}
