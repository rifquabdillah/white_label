import 'package:flutter/material.dart';
import 'package:white_label/menuSaldo/detailKirimSaldo.dart';
import '../menuTransaksi/mutasiMenu.dart';
import 'mSaldo.dart';

class kirimSaldo extends StatefulWidget {
  const kirimSaldo({super.key});

  @override
  _kirimSaldoState createState() => _kirimSaldoState();
}

class _kirimSaldoState extends State<kirimSaldo> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFFfaf9f6), // Background color of the AppBar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2), // Position of the shadow
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
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
                          _isSaldoVisible = !_isSaldoVisible;
                        });
                      },
                      child: Icon(
                        _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off,
                        color: const Color(0xff909EAE),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SaldoPageScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF909EAE), // Warna latar belakang abu-abu
                          borderRadius: BorderRadius.circular(4), // Menambahkan sedikit lengkungan pada sudut
                        ),
                        child: Icon(
                          Icons.add,
                          color: Color(0xffFAF9F6),
                          size: 18,
                        ),
                      ),
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
          ),
        ),
      ),

      body: SingleChildScrollView( // Wrap the body content in a SingleChildScrollView
        padding: const EdgeInsets.all(0), // Remove vertical and horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Space between input and new content
            _buildNewContent(),
            const SizedBox(height: 16),
            _buildKirimSaldoField(),
            const SizedBox(height: 40),
            _buildButtonKirimSaldo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNewContent() {
    return Padding(
      padding: const EdgeInsets.all(16), // Add some padding around the content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kirim Saldo ke Downline',
            style: TextStyle(
              fontSize: 16, // Customize the font size
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color(0xff353E43), // Customize text color
            ),
          ),
      ]
    ),
    );
  }

  Widget _buildKirimSaldoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label for the first TextField
        Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: const Text(
            'Mau kirim ke siapa?',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic, // Set fontStyle to italic
              color: Color(0xFF353E43),
            ),
          ),

        ),
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFDF7E6),
                        border: InputBorder.none, // Remove the default underline
                        hintText: 'Kode Member/No HP',
                        hintStyle: const TextStyle(color: Color(0xff909EAE)),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: _phoneController.text.isEmpty ? FontWeight.normal : FontWeight.w600,
                        color: _phoneController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 8), // Spacing between the TextField and the buttons
                  IconButton(
                    icon: const Icon(Icons.mic, color: Color(0xFFecb709)),
                    onPressed: () {
                      // Handle voice input logic here
                    },
                  ),
                  const SizedBox(width: 2), // Small spacing between mic and contacts button
                  IconButton(
                    icon: const Icon(Icons.contacts, color: Color(0xFFecb709)),
                    onPressed: () {
                      // Handle opening contacts logic here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8), // Spacing between the Row and the underline
              Container(
                height: 2.0, // Height of the underline
                color: Colors.grey, // Color of the underline
                width: double.infinity, // Make it full width
              ),
            ],
          ),
        ),


        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: const Text(
            'Berapa yang mau dikirim?',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.italic, // Set fontStyle to italic
              color: Color(0xFF353E43),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFDF7E6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: 'Jumlah Saldo',
              hintStyle: const TextStyle(color:Color(0xff909EAE)),
            ),
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF363636),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonKirimSaldo(BuildContext context) => Center(
    child: Column(
      children: [
        SizedBox(
          width: 355,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => detailKirimSaldo(transactionId: '')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffecb709),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Kirim Saldo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // Spasi antara tombol dan teks
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MutasiMenu()),
            );
          },
          child: const Text(
            'Lihat riwayat mutasi saldo',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xffECB709),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',// Warna teks
              decoration: TextDecoration.underline,
              decorationColor: Color(0xffECB709), // Garis bawah pada teks
            ),
          ),
        ),
      ],
    ),
  );
}
