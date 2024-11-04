import 'package:flutter/material.dart';

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
            Navigator.pop(context); // Navigate back when tapped
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KonfirmasiTransaksi(), // Navigasi ke halaman KonfirmasiTransaksi
                      ),
                    );
                  },
                  child: const Text('KIRIM TRANSAKSI BERHASIL'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('KIRIM TRANSAKSI GAGAL'),
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
  @override
  _KonfirmasiTransaksiState createState() => _KonfirmasiTransaksiState();
}

class _KonfirmasiTransaksiState extends State<KonfirmasiTransaksi> {
  String _hargaJual = '7.000'; // Variabel hargaJual
  bool isTokenListrik = true; // Set true if transaction type is Token Listrik

  // Data untuk transaksi
  final Map<String, dynamic> transaksiData = {
    'pulsa': {'kodeProduk': 'IP5', 'namaProduk': 'Indosat Promo Mixed'},
    'token': {'kodeProduk': 'TLK20', 'namaProduk': 'Token Listrik'},
  };

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
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFfaf9f6),
                borderRadius: BorderRadius.circular(0),
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
              margin: const EdgeInsets.all(0),
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
            ),
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

  Widget _buildTransactionDetails(BuildContext context) {
    // Dapatkan data produk berdasarkan jenis transaksi
    String kodeProduk = isTokenListrik ? transaksiData['token']['kodeProduk'] : transaksiData['pulsa']['kodeProduk'];
    String namaProduk = isTokenListrik ? transaksiData['token']['namaProduk'] : transaksiData['pulsa']['namaProduk'];

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
          _buildTransactionDetailRow('Tanggal Transaksi', '23/09/2024 13:00:21'),
          const SizedBox(height: 8),
          _buildTransactionDetailRow('Kode Produk', kodeProduk), // Menggunakan kode produk yang diambil dari data
          const SizedBox(height: 8),
          _buildTransactionDetailRow('Nama Produk', namaProduk), // Menggunakan nama produk yang diambil dari data
          const SizedBox(height: 8),
          _buildTransactionDetailRow('Nomor Tujuan', '0856 2244 866'),
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
        const SizedBox(width: 150), // Jarak antara teks dan ikon
        IconButton(
          icon: Icon(Icons.edit, color: Color(0xffECB709)), // Ikon edit
          onPressed: () {
            _editHarga(context, value); // Panggil fungsi edit harga
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
                Navigator.of(context).pop(); // Tutup dialog tanpa menyimpan perubahan
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                String newHarga = _controller.text;
                setState(() {
                  _hargaJual = newHarga; // Update _hargaJual dengan harga baru
                });
                Navigator.of(context).pop(); // Tutup dialog setelah menyimpan perubahan
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
              backgroundColor: const Color(0xffECB709), // Warna tombol
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Ukuran tombol
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Radius sudut tombol
              ),
            ),
            onPressed: () {
              // Check the transaction type and navigate accordingly
              if (isTokenListrik) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CetakFakturToken()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CetakFaktur()),
                );
              }
            },
            child: const Text(
              'Cetak Faktur',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins', color: Colors.white), // Mengatur ukuran dan gaya teks
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
          MaterialPageRoute(builder: (context) => MyHomePage(title: '',)), // Ganti dengan halaman MyHomePage
        );
      },
      child: const Text(
        'Kembali ke Beranda',
        style: TextStyle(
            color: Color(0xff353E43),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,// Warna hitam untuk teks
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff353E43)// Garis bawah (underline) untuk teks
        ),
      ),
    );
  }
}
