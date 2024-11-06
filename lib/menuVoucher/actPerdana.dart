import 'package:flutter/material.dart';
import 'package:white_label/transaksipay.dart';

import '../menuSaldo/mSaldo.dart';

class ActPerdanaScreen extends StatefulWidget {
  const ActPerdanaScreen({super.key});

  @override
  _ActPerdanaState createState() => _ActPerdanaState();
}

class _ActPerdanaState extends State<ActPerdanaScreen> {
  int _selectedPromoIndex = 0;
  bool _isSaldoVisible = true; // Controller for phone input
  final TextEditingController _phoneController = TextEditingController();

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const String saldo = '2.862.590'; // Menyimpan saldo
    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: const Color(0XFFfaf9f6),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Saldo ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF4e5558),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        _isSaldoVisible ? saldo : '********',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 25.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSaldoVisible =
                            !_isSaldoVisible; // Toggle visibility
                          });
                        },
                        child: Icon(
                          _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () {
                          // Navigate to SaldoPage when the add icon is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SaldoPageScreen()), // Replace with your SaldoPage
                          );
                        },
                        child: const Icon(Icons.add, color:  Color(0xff909EAE)),
                      ),
                    ],
                  ),
                ],
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // Menambahkan toolbarHeight untuk menyesuaikan tinggi AppBar
              toolbarHeight: 60,
              elevation: 0, // Menghilangkan bayangan
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0), // Menghilangkan padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize), // Kolom input nomor telepon
            const SizedBox(height: 0), // Spacing
          ],
        ),
      ),
    );
  }


  Widget _buildPhoneNumberField(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26.0, bottom: 16.0), // Menghilangkan padding kanan
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0XFFfaf9f6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
              ),
              hintText: 'Nomor Pertagas',
              hintStyle: const TextStyle(
                  color: Color(0xff909EAE),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, color: Color(0xffECB709)),
                    onPressed: () {
                      // Tambahkan logika untuk menangani input suara di sini
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner_outlined, color: Color(0xffECB709)),
                    onPressed: () {
                      // Tambahkan logika untuk membuka kontak di sini
                    },
                  ),
                ],
              ),
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: _phoneController.text.isEmpty
                  ? FontWeight.normal
                  : FontWeight.w600,
              color: _phoneController.text.isEmpty ? Color(0xff909EAE) : const Color(0xFF363636),
            ),
            onChanged: (value) {
              setState(() {
              });
            },
          ),
        ),
      ],
    );
  }
}


