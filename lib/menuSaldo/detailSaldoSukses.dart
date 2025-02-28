import 'package:flutter/material.dart';
import '../main.dart';
import 'mSaldo.dart';

class detailSaldo extends StatefulWidget {
  const detailSaldo({super.key, required String transactionId});

  @override
  _detailSaldooState createState() => _detailSaldooState();
}

class _detailSaldooState extends State<detailSaldo> {
  bool _isSaldoVisible = true;
  final DateTime transferLimitDateTime = DateTime(2024, 10, 24, 17, 40);

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF9F6),
        title: Row(
          children: [
            const Text(
              'Saldo ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Color(0xFF4e5558)),
            ),
            const SizedBox(width: 10.0),
            Text(
              _isSaldoVisible ? saldo : '********',
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10.0),
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
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView( // Agar layar tidak overflow
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildNewContent(),
              const SizedBox(height: 10),
              _buildTicketDetails(),
              const SizedBox(height: 20),
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewContent() {
    return Container(
      width: double.infinity, // Agar lebar maksimal
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffFAF9F6),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 0, blurRadius: 5, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Tiket sukses, saldo sudah ditambahkan',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xff909EAE)),
          ),
          const SizedBox(height: 5),
          const Text(
            '2.500.375',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Color(0xff198754)),
          ),
          const SizedBox(height: 10),
          const Text(
            'Pada tanggal 24/10/2024 10:26:28',
            style: TextStyle(fontSize: 12, color: Color(0xff353E43), fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTicketDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Nomor Tiket', '#688548'),
        _buildDetailRow('Tanggal Tiket', '24/10/2024 10:21:13'),
        _buildDetailRow('Saldo Awal', '161.575'),
        _buildDetailRow('Deposit Masuk', '2.500.375'),
        _buildDetailRow('Saldo Akhir', '2.661.950'),
        _buildDetailRow('Bank Penerima', 'BCA - 280 186 8888'),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible( // Supaya teks tidak keluar layar
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: Color(0xff909EAE), fontSize: 14),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins', color: Color(0xff353E43), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

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
          style: TextStyle(color: Color(0xff353E43), fontSize: 14, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
