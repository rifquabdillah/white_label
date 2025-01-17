import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/menuSaldo/mSaldo.dart';
import 'detailTransaksi.dart';

class DetailProsesTransaksi extends StatefulWidget {
  const DetailProsesTransaksi({super.key});

  @override
  _DetailProsesTransaksiState createState() => _DetailProsesTransaksiState();
}

class _DetailProsesTransaksiState extends State<DetailProsesTransaksi> {
  bool _isSaldoVisible = true;
  bool _isLoading = true; // Variable to control loading animation

  @override
  void initState() {
    super.initState();
    // Simulate a loading process for 5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false; // Set loading to false after 5 seconds
      });
      // Navigate to DetailTransaksiSukses after loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DetailTransaksi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: const Color(0xffFDF7E6),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Saldo ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF353E43),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    _isSaldoVisible ? saldo : '********',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
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
                      _isSaldoVisible
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off,
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
      body: Container(
        height: 1000,
        margin: const EdgeInsets.only(top: 2.0, right: 18.0, left: 0.0), // Jarak antara AppBar dan Container
        decoration: BoxDecoration(
          color: Color(0xFFFAF9F6), // Set the desired background color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna bayangan
              spreadRadius: 1, // Radius penyebaran bayangan
              blurRadius: 8, // Radius blur untuk efek bayangan
              offset: const Offset(0, 4), // Posisi bayangan (horizontal, vertical)
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna bayangan atas
              spreadRadius: 0, // Radius penyebaran bayangan
              blurRadius: 8, // Radius blur untuk efek bayangan
              offset: const Offset(0, -4), // Posisi bayangan ke atas
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pulsa Telkomsel Reguler',
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 4.0),
              const Text(
                '10.000',
                style: TextStyle(fontSize: 24, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
              ),
              const Text(
                'Masa aktif +15 hari',
                style: TextStyle(fontWeight: FontWeight.w200, fontFamily: 'Poppins', color: Color(0xff909EAE)),
              ),
              const SizedBox(height: 16.0),
              _buildDetailRow('Kode Produk', 'S10'),
              _buildDetailRow(
                'Nomor Tujuan',
                '0812 2126 0284',
                isHighlighted: true,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '0812 2126 0284'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nomor Tujuan disalin ke clipboard!')),
                  );
                },
              ),
              _buildDetailRow('Status', 'Dalam Proses', isSuccess: true),
              _buildDetailRow('Tanggal Status', '18/09/2024 13:37:43'),
              _buildDetailRow('Saldo Awal', '547.885'),
              _buildDetailRow('Saldo Akhir', '522.760'),
              _buildDetailRow('Harga Produk', '10.125'),
              const SizedBox(height: 16.0),
              const Text(
                '#89535525 R# trx S10.082240000201 sedang diproses. Mohon ditunggu @16:40. Sld 522.760-512.635=10.125',
                style: TextStyle(fontSize: 12, color: Color(0xff909EAE)),
              ),
              const SizedBox(height: 20.0),
              if (_isLoading) // Display loading animation if _isLoading is true
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (!_isLoading) // Alternatively, you can display other widgets here
                const Text(
                  'Proses selesai!', // Message to show after loading is complete
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String label,
      String value,
      {bool isHighlighted = false, bool isSuccess = false, VoidCallback? onTap}
      ) {
    return GestureDetector(
      onTap: onTap, // Handle tap action
      child: Column(
        children: [
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: Color(0xff353E43),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: isHighlighted
                      ? Color(0xffECB709)
                      : isSuccess
                      ? Color(0xff198754)
                      : Color(0xff353E43),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
