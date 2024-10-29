import 'package:flutter/material.dart';
import '../main.dart';
import 'mSaldo.dart';

class detailKirimSaldo extends StatefulWidget {
  const detailKirimSaldo({super.key, required String transactionId});

  @override
  _detailKirimSaldoState createState() => _detailKirimSaldoState();
}

class _detailKirimSaldoState extends State<detailKirimSaldo> {
  bool _isSaldoVisible = true;
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
                          MaterialPageRoute(builder: (context) =>
                              SaldoPageScreen()),
                        );
                      },
                      child: const Icon(Icons.add, color: Color(0xff909EAE)),
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
          _buildNewContent(),
          const SizedBox(height: 10),
          _buildKirimSaldoDetails(),
          _buildActionButtons(context),
          const SizedBox(height: 330),
          _buildBackButton(context),// Add this line to call the new method
        ],
      ),
    );
  }

  Widget _buildNewContent() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xffFAF9F6), // Set the background color here
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
              'Saldo berhasil dikirim sebesar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              '200.000',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Color(0xff198754),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Pada tanggal 24/10/2024 10:26:28',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff353E43),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center, // This is optional for centering
            ),
          )
        ],
      ),
    );
  }

  Widget _buildKirimSaldoDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Status Pengiriman', 'Sukses', Color(0xff198754)), // Set the color to green
          _buildDetailRow('Tanggal Pengiriman', '24/10/2024 10:26:28'),
          _buildDetailRow('Penerima Saldo', '0812 2126 0284'),
          _buildDetailRow('Nominal Pengiriman', '200.000'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Add vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Color(0xff909EAE),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: valueColor ?? Color(0xff353E43), // Use provided color or default to dark color
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Mengatur semua elemen ke sebelah kanan
      children: [
        TextButton.icon(
          onPressed: () {
            // Implement sharing functionality here
          },
          icon: const Icon(Icons.share_outlined, color: Color(0xffECB709)),
          label: const Text(
            'Bagikan',
            style: TextStyle(color: Color(0xffECB709), fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8), // Jarak antara tombol Bagikan dan Cetak Faktur
        Padding(
          padding: const EdgeInsets.only(right: 10), // Padding untuk menggeser tombol ke kiri
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffECB709), // Warna tombol
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Ukuran tombol
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Radius sudut tombol
              ),
            ),
            onPressed: () {
              // Implement "Cetak Faktur" functionality here
            },
            child: const Text(
              'Cetak Faktur',
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.white), // Mengatur ukuran dan gaya teks
            ),
          ),
        ),
      ],
    );
  }

  // Tombol kembali ke halaman utama
  Widget _buildBackButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
          );
        },
        child: const Text(
          'Kembali ke Beranda',
          style: TextStyle(
            color: Color(0xff353E43),
            fontSize: 14,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff353E43),
          ),
        ),
      ),
    );
  }


}
