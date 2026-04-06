import 'package:flutter/material.dart';
import 'pages/load_page.dart';

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
      home: const LoadPage(),
    );
  }
}
