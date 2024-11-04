import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/menuSaldo/mSaldo.dart';
import 'package:white_label/menuTransaksi/cetakFakturToken.dart';

import 'cetakFaktur.dart';

class DetailTransaksi extends StatefulWidget {
  const DetailTransaksi({super.key});

  @override
  _DetailTransaksiState createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  bool _isSaldoVisible = true;

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
      body: Container(
        height: 1000,
        margin: const EdgeInsets.only(top: 2.0, right: 0.0, left: 0.0), // Jarak antara AppBar dan Container
        decoration: BoxDecoration(
          color: Color(0xFFFAF9F6), // Set the desired background color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna bayangan
              spreadRadius: 1, // Radius penyebaran bayangan
              blurRadius: 8, // Radius blur untuk efek bayangan
              offset: Offset(0, 4), // Posisi bayangan (horizontal, vertical)
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna bayangan atas
              spreadRadius: 0, // Radius penyebaran bayangan
              blurRadius: 8, // Radius blur untuk efek bayangan
              offset: Offset(0, -4), // Posisi bayangan ke atas
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Telkomsel Data Nominal',
                style: TextStyle(fontSize: 14,fontFamily: 'Poppins', fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 4.0),
              const Text(
                '5 GB | 30 Hari',
                style: TextStyle(fontSize: 24,fontFamily: 'Poppins', fontWeight: FontWeight.w700),
              ),
              const Text(
                '2 GB utama, 2 GB jaringan 4G, 1 GB apps',
                style: TextStyle(fontWeight: FontWeight.w200, fontFamily: 'Poppins', color: Color(0xff909EAE)),
              ),
              const SizedBox(height: 16.0),
              _buildDetailRow('Tanggal Transaksi', '18/09/2024 13:37:28'),
              _buildDetailRow('Kode Produk', 'TD25'),
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
              _buildDetailRow('Status', 'Sukses', isSuccess: true),
              _buildDetailRow('Tanggal Status', '18/09/2024 13:37:43'),
              _buildDetailRow('Saldo Awal', '547.885'),
              _buildDetailRow('Saldo Akhir', '522.760'),
              _buildDetailRow('Harga Produk', '25.125'),
              _buildDetailRow('Harga Jual', '28.000'),
              _buildDetailRow('Profit', '2.875'),
              _buildDetailRow(
                'Kode SN',
                '03589200001570588332',
                isHighlighted: true,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '03589200001570588332'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kode SN disalin ke clipboard!')),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                '#Alhamdulillah #89535525 R# Trx TD25.081221260284 SUKSES. SN/Ref: 03589200001570588332. Sld 547.885-25.125=522760 @18/09 13:37:28 18/10 13:37:43 Trx ke-0! #BNI CLOSE',
                style: TextStyle(fontSize: 12, color: Color(0xff909EAE)),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Handle share invoice
                    },
                    icon: const Icon(Icons.share, color: Color(0xffECB709)),
                    label: const Text(
                      'Bagikan',
                      style: TextStyle(color: Color(0xffECB709), fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CetakFaktur()), // Replace with your CetakFaktur widget
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffcb12b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cetak Faktur',
                      style: TextStyle(color: Color(0xffFAF9F6), fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                    ),
                  ),

                ],
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
