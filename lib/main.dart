import 'package:flutter/material.dart';

// Pages
import 'pages/load_page.dart';

// Screens
import 'pages/wallet.dart';
import 'pages/tarik_saldo.dart';
import 'pages/riwayat.dart';
import 'pages/profil.dart';
import 'pages/edit_profil.dart';
import 'pages/password.dart';
import 'pages/system_fee.dart';

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
        '/wallet': (context) => const Wallet(),
        '/tarik-saldo': (context) => const TarikSaldo(),
        '/riwayat': (context) => const Riwayat(),
        '/profil': (context) => const Profil(),
        '/edit-profil': (context) => const EditProfil(),
        '/ubah-password': (context) => const Password(),
        '/system-fee': (context) => const SystemFee(),
      },
    );
  }
}
