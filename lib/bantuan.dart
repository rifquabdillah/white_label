import 'package:flutter/material.dart';

import 'account.dart';
import 'historyTransaction.dart';
import 'main.dart';

class mBantuan extends StatefulWidget {
  const mBantuan({super.key});

  @override
  mBantuanState createState() => mBantuanState();
}

class mBantuanState extends State<mBantuan> {
  int _selectedIndex = 3 ;


  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        // Tentukan halaman tujuan berdasarkan indeks
        Widget targetPage;
        switch (index) {
          case 0:
            targetPage = const MyHomePage(title: 'Home');
            break;
          case 1:
            targetPage = const HistoryPage(transactions: []);
            break;
          case 2:
            targetPage = const AccountPage();
            break;
          case 3:
            targetPage = const mBantuan();
            break;
          default:
            return;
        }

        // Animasi selalu masuk dari kiri ke kanan
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => targetPage,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0); // Animasi selalu dari kiri
              const end = Offset.zero; // Selesai di posisi normal
              const curve = Curves.easeInOut; // Transisi smooth

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );

        // Perbarui indeks yang dipilih
        _selectedIndex = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: AppBar(
        backgroundColor: const Color(0xff34C759),
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff353E43),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff353E43)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNewContent(context),
            const SizedBox(height: 100),
            _buildHeaderText(),

            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.chat_outlined,
              color: Colors.green,
              title: 'Hubungi Customer Officer',
              subtitle: 'Mulai percakapan dengan petugas Customer Service 24 jam kami',
            ),
            _buildInfoCard(
              icon: Icons.help_outline,
              color: Colors.blue,
              title: 'Solusi Cepat',
              subtitle: 'Lihat daftar jawaban dari pertanyaan yang sering ditanyakan',
            ),
            _buildInfoCard(
              icon: Icons.info,
              color: Colors.amber,
              title: 'Channel Informasi',
              subtitle: 'Tetap up to date dengan informasi terbaru dari kanal resmi kami',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffecb709),
        tooltip: 'Shopping Cart',
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 35.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 88.9,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // Align icons to the left
            children: [
              _buildIconWithText(Icons.home_filled, "Beranda ", 0),
              // Pass index 0
              _buildIconWithText(
                  Icons.access_time_filled_rounded, "History", 1),
              // Pass index 1
              _buildIconWithText(Icons.person_rounded, "Akun", 2),
              // Pass index 2
              _buildIconWithText(Icons.headset_mic_outlined, "Bantuan", 3),
              // Pass index 3
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(IconData icon, String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 1.0),
      // Adjust horizontal padding as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align items to the top
        children: [
          // Add the orange indicator line at the top
          if (_selectedIndex == index) // Use if for cleaner syntax
            Container(
              width: 30.0, // Adjust width as needed
              height: 1.5, // Thin line
              color: Colors.orange, // Orange color for the indicator
            ),
          IconButton(
            onPressed: () => _onItemTapped(index),
            // Call _onItemTapped with the index
            icon: Icon(
              icon,
              color: _selectedIndex == index ? const Color(0xff353e43) : Colors
                  .grey, // Change color based on selection
              size: 30.0,
            ),
          ),

          Text(
            text,
            style: TextStyle(
              color: _selectedIndex == index ? const Color(0xff353e43) : Colors
                  .grey, // Change color based on selection
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    return Center(
      child: SizedBox(
        width: double.infinity, // Pastikan teks memiliki batas untuk melipat
        child: Text(
          'Bagaimana kami bisa membantu kamu hari ini?',
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Poppins',
            color: Color(0xff353E43),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
          softWrap: true, // Mengizinkan teks terpotong menjadi beberapa baris
        ),
      ),
    );
  }


  Widget _buildNewContent(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xff34C759),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              ' ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: const Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ikon dalam kotak persegi beradius
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color, // Latar belakang solid dengan warna sesuai parameter
                borderRadius: BorderRadius.circular(10), // Radius untuk kotak persegi
              ),
              child: Icon(icon, color: Colors.white, size: 24), // Ikon berwarna putih di tengah
            ),
            const SizedBox(width: 16),
            // Teks detail
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xFF353E43),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                      color: Color(0xFF909EAE),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
