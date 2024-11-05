import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../main.dart';
import 'cetakFaktur.dart';
import 'cetakFakturToken.dart';

class TransaksiPay extends StatefulWidget {
  @override
  _TransaksiPayState createState() => _TransaksiPayState();
}

class _TransaksiPayState extends State<TransaksiPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfdf7e6),
      appBar: AppBar(
        title: const Text('Transaksi Pay'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Detail Transaksi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Get the current date and time in the desired format (no seconds included)
                    String now = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KonfirmasiTransaksi(
                          kodeProduk: '', // Example product code
                          namaProduk: '', // Example product name
                          nomorTujuan: '', // Example destination number
                          tglTransaksi: now, // Pass the formatted date and time
                          hargaJual: '', // Example price
                        ),
                      ),
                    );
                  },
                  child: const Text('KIRIM TRANSAKSI BERHASIL'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KonfirmasiTransaksi extends StatefulWidget {
  final String kodeProduk;
  final String namaProduk;
  final String nomorTujuan;
  final String tglTransaksi;

  KonfirmasiTransaksi({
    required this.kodeProduk,
    required this.namaProduk,
    required this.nomorTujuan,
    required this.tglTransaksi,
    required String hargaJual,
  });

  @override
  _KonfirmasiTransaksiState createState() => _KonfirmasiTransaksiState();
}

class _KonfirmasiTransaksiState extends State<KonfirmasiTransaksi> {
  String _hargaJual = '7.000';
  bool isTokenListrik = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfdf7e6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 35.0,
        backgroundColor: const Color(0xFFfaf9f6),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 4),
            _buildTransactionDetails(context),
            const SizedBox(height: 20),
            _buildActionButtons(context),
            const Spacer(),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFfaf9f6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, -0),
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Image.asset(
            'assets/logo_sukses.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            'ALHAMDULILLAH!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Transaksi kamu sudah berhasil dikirim dan sedang diproses',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFfdf7e6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ferry Febrian Negara',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 10),
          _buildTransactionDetailRow('Tanggal Transaksi', DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(widget.tglTransaksi))),
          const SizedBox(height: 8),
          _buildTransactionDetailRow('Kode Produk', widget.kodeProduk),
          const SizedBox(height: 8),
          _buildTransactionDetailRow('Nama Produk', widget.namaProduk),
          const SizedBox(height: 8),
          _buildTransactionDetailRow('Nomor Tujuan', widget.nomorTujuan),
          _buildTransactionDetailRowWithEdit(context, 'Harga Jual', _hargaJual, isBold: true, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: Color(0xff909EAE),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetailRowWithEdit(BuildContext context, String title, String value, {bool isBold = false, Color color = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w400 : FontWeight.w400,
            color: Color(0xff909EAE),
          ),
        ),
        const SizedBox(width: 150),
        IconButton(
          icon: Icon(Icons.edit, color: Color(0xffECB709)),
          onPressed: () {
            _editHarga(context, value);
          },
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
                color: Color(0xffECB709),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _editHarga(BuildContext context, String currentHarga) {
    TextEditingController _controller = TextEditingController(text: currentHarga);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ubah Harga Jual'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Masukkan harga baru'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hargaJual = _controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffECB709),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (isTokenListrik) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CetakFakturToken()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CetakFaktur()));
              }
            },
            child: const Text(
              'Buat Faktur',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins', color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: '',)),
        );
      },
      child: const Text(
        'Kembali ke Beranda',
        style: TextStyle(
          color: Color(0xff353E43),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xff353E43),
        ),
      ),
    );
  }
}
