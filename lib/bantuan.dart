import 'package:flutter/material.dart';

class mBantuan extends StatefulWidget {
  const mBantuan({super.key});

  @override
  mBantuanState createState() => mBantuanState();
}

class mBantuanState extends State<mBantuan> {
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
            const SizedBox(height: 30),
            _buildHeaderText(),

            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.chat,
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
    );
  }

  Widget _buildHeaderText() {
    return Center(
      child: Text(
        'Bagaimana kami bisa membantu kamu hari ini?',
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Poppins',
          color: Color(0xff353E43),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNewContent(BuildContext context) {
    return Container(
      height: 115,
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

  Widget _buildInfoCard({required IconData icon, required Color color, required String title, required String subtitle}) {
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
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
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
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
