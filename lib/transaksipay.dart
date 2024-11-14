import 'package:flutter/material.dart';
import 'package:white_label/menuSaldo/mSaldo.dart';

import 'menuTransaksi/konfirmasiTransaksi.dart';

class TransaksiPay extends StatefulWidget {
  final Map<String, dynamic> params;

  const TransaksiPay({
    super.key,
    required this.params,
  });

  @override
  _TransaksiPayState createState() => _TransaksiPayState();
}

class _TransaksiPayState extends State<TransaksiPay> {
  bool _isSaldoVisible = true;

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: const Color(0xfffdf7e6),
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
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xfffdf7e6),
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffFAF9F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    Text(
                      widget.params['Key'] ?? '',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8.0), // Space between Key and Nama-Masa Aktif row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.params['Nama'] ?? '',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8.0), // Space after Nama
                         Text(
                          _bodoh(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Color(0xff909EAE),
                          ),
                        ),
                        const SizedBox(width: 8.0), // Space after separator
                        Text(
                          widget.params['Masa Aktif'] ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            color: Color(0xff353E43),
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    _buildDynamicDataRows(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Kamu hemat 350 untuk transaksi ini',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              color: const Color(0xfffdf7e6),
              child: Column(
                children: [
                  const Text(
                    'Pastikan detail sudah sesuai, transaksi yang dikirim tidak bisa dibatalkan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'Poppins',
                      color: Color(0xff353E43),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KonfirmasiTransaksi(params: widget.params),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xffecb709),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        child: const Text('KIRIM TRANSAKSI'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  String _bodoh() {
    if (widget.params.containsKey('Masa Aktif')) {
      return '|';
    } else {
      return '';
    }
  }

  Widget _buildDynamicDataRows() {
    List<Widget> rows = [];
    widget.params.forEach((key, value) {
      if (value.runtimeType != int && value != null && value.isNotEmpty) {
        if (key != 'Key' && key != 'Nama' && key != 'Masa Aktif' && key != 'Detail') {
          if (key == 'Deskripsi') {
            // Handle Deskripsi as clickable text
            rows.add(_buildClickableLabeledRow(key, value));
          } else {
            rows.add(_buildLabeledRow(key, value));
          }
        }
      }
    });
    return Column(children: rows);
  }


  Widget _buildLabeledRow(String label, String value, {bool isBold = false, Color? textColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              value.isNotEmpty ? value : '',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                color: textColor ?? const Color(0xff353E43),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
      ],
    );
  }

// Special handler for Deskripsi to make it clickable
  Widget _buildClickableLabeledRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Define the action for when Deskripsi is clicked
                // You can navigate, show a dialog, or any other action
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Deskripsi Details'),
                      content: Text(value),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
                child: GestureDetector(
                  onTap: () {
                    // Define the action for when the text is clicked
                    // You can navigate, show a dialog, or any other action
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Cek Detail'),
                          content: const Text('Here are the details...'), // You can customize the content here
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Cek Detail',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffECB709), // Indicate it is clickable
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xffECB709),// Underline the text
                    ),
                  ),
                )

            ),
          ],
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
