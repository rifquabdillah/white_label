import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/menuSaldo/detailTukarKomisi.dart';
import '../menuTransaksi/mutasiMenu.dart';
import 'mSaldo.dart';

class tukarKomisi extends StatefulWidget {
  final String storeName; // Add this line

  const tukarKomisi({super.key, required this.storeName}); // Update the constructor

  @override
  _tukarKomisiState createState() => _tukarKomisiState();
}

class _tukarKomisiState extends State<tukarKomisi> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();
  final DateTime transferLimitDateTime = DateTime(2024, 10, 24, 17, 40);

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
          ),
          child: AppBar(
            backgroundColor: Color(0xffFAF9F6),
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
                        _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons
                            .visibility_off,
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0),
          _buildNewContent(context),
          const SizedBox(height: 101),
          _buildTukarKomisiField(),
        ],
      ),

    );
  }

  Widget _buildNewContent(BuildContext context) {
    String paymentCode = '328.025'; // Kode bayar yang akan disalin

    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: const Color(0xffFAF9F6), // Set the background color here
        borderRadius: BorderRadius.circular(0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0,
            blurRadius: 5, // Blur radius for shadow effect
            offset: const Offset(0, 4), // Position of the shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16), // Add padding for better spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Jumlah komisi kamu sekarang:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: const Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              paymentCode,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: const Color(0xff353E43),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }


  Widget _buildTukarKomisiField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFDF7E6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff353E43), width: 2.0),
              ),
              hintText: 'Tukar Komisi ke Saldo',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: _phoneController.text.isEmpty ? FontWeight.normal : FontWeight.w600,
              color: _phoneController.text.isEmpty ?Color(0xff353E43) : const Color(0xFF363636),
            ),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: 10),
        _buildButtonDeposit(context),
      ],
    );
  }

  Widget _buildButtonDeposit(BuildContext context) => Center(
    child: Column(
      children: [
        SizedBox(
          width: 355,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => detailTukarKomisi(transactionId: '')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffecb709),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Tukarkan Komisi',
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

