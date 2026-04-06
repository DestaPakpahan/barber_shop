import 'package:flutter/material.dart';
import '../widgets/cabang_card.dart'; 

class DaftarCabangPage extends StatelessWidget {

  const DaftarCabangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Cabang',
          style: TextStyle(
            color: Color(0xFF1A367C), 
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Nama Cabang',
                suffixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF1A367C)),
                ),
              ),
            ),
          ),
          
          // List Cabang
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                CabangCard(
                  name: 'Barber King',
                  address: 'Sendangadi, Kab. Sleman',
                  logoPath: 'https://via.placeholder.com/150',
                ),
                CabangCard(
                  name: 'Barber King',
                  address: 'Jl. Taman Siswa, Wirogunan, Yogyakarta',
                  logoPath: 'https://via.placeholder.com/150',
                ),
                CabangCard(
                  name: 'Urban Cut',
                  address: 'Jl. Letjen S. Parman, Banjarsari',
                  logoPath: 'https://via.placeholder.com/150',
                ),
                  CabangCard(
                    name: 'Urban Cut',
                    address: 'Jl. Affandi, Condongcatur, Kec. Depok, Kabupaten Sleman',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'The Gentle Cut',
                    address: 'Rejowinangun Selatan, Kec. Magelang Selatan',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'The Gentle Cut',
                    address: 'Sabrangs, Gunungpring, Kec. Muntilan',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Bass Cuts',
                    address: 'Jl. Gandekan, Sosromenduran, Gedong Tengen, Kota Yogyakarta',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Bass Cuts',
                    address: 'Jl. Parangtritis, Brontokusuman, Mergangsan, Kota Yogyakarta',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Barberin',
                    address: 'Jl. Madukoro Raya, Kec. Semarang Barat',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Potong Boss',
                    address: 'Krikil, Walitelon Selatan, Kec. Sidorejo',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Gentleman Room',
                    address: 'Sabrangs, Gunungpring, Kec. Muntilan',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Gentelman Room',
                    address: 'Sendangadi, Kab. Sleman',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Pangkas Kita', 
                    address: 'Jl. Taman Siswa, Wirogunan, Yogyakarta',
                    logoPath: 'https://via.placeholder.com/150'
                  ),
                  CabangCard(
                    name: 'Barber Yuk',
                    address: 'Jl. Letjen S. Parman, Banjarsari',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Pangkas Nusantara',
                    address: 'Jl. Affandi, Condongcatur, Kec. Depok, Kabupaten Sleman',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Pangkas Jogja',
                    address: 'Rejowinangun Selatan, Kec. Magelang Selatan',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Sudut Barber',
                    address: 'Sabrangs, Gunungpring, Kec. Muntilan',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                  CabangCard(
                    name: 'Sudut Barber',
                    address: 'Jl. Gandekan, Sosromenduran, Gedong Tengen, Kota Yogyakarta',
                    logoPath: 'https://via.placeholder.com/150',
                  ),
                ],
            ),
          ),
        ],
      ),
    );
  }
}