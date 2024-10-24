import 'package:flutter/material.dart';
import 'menuTransaksi/konfirmasiTransaksi.dart';

class TransaksiPay extends StatefulWidget {
  final String nominal;
  final String kodeproduk;
  final String namaPemilik;
  final String tipeMeteran;
  final String dayaMeteran;
  final String hargaJual;
  final String description;
  final String originalPrice;
  final String info;
  final String transactionType;

  const TransaksiPay({
    super.key,
    required this.nominal,
    required this.kodeproduk,
    this.namaPemilik = 'Kastari',
    this.tipeMeteran = 'R1M',
    this.dayaMeteran = '990VA',
    required this.hargaJual,
    required this.description,
    required this.originalPrice,
    required this.info,
    required this.transactionType,
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
                          _isSaldoVisible ? Icons.remove_red_eye : Icons.visibility_off,
                          color: Color(0xff909EAE),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Icon(Icons.add, color: Color(0xff909EAE)),
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
                  color: Color(0xffFAF9F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.transactionType == 'TokenListrik'
                          ? 'Token PLN Premium SN Full'
                          : 'Pulsa Indosat Promo Mixed with Pulsa Transfer',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      widget.nominal,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 0.0),
                    Text(
                      widget.info,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        color: Color(0xff909EAE),
                        fontWeight: FontWeight.w200
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    if (widget.kodeproduk.isNotEmpty)
                      _buildLabeledRow('Kode Produk', widget.kodeproduk.replaceAll(' - ', ''), // Clean up the string
                      ),

                    if (widget.transactionType == 'TokenListrik') ...[
                      const SizedBox(height: 0.0),
                      // Only show the Nama Pemilik row if it's not empty
                      if (widget.namaPemilik.isNotEmpty)
                        _buildLabeledRow('Nama Pemilik', widget.namaPemilik),

                      const SizedBox(height: 0.0),

                      // Only show the Tipe Meteran row if it's not empty
                      if (widget.tipeMeteran.isNotEmpty)
                        _buildLabeledRow('Tipe Meteran', widget.tipeMeteran),

                      const SizedBox(height: 0.0),

                      // Only show the Daya Meteran row if it's not empty
                      if (widget.dayaMeteran.isNotEmpty)
                        _buildLabeledRow('Daya Meteran', widget.dayaMeteran),
                    ],

                    const SizedBox(height: 0.0),

// Only show the Poin row if it's not empty or show it as empty
                    _buildLabeledRow('Poin', '-'), // Assuming you want it to be empty, not '-'

                    const SizedBox(height: 0.0),

                    _buildLabeledRow('Nomor Tujuan', '0856 2244 866', isBold: true),
                    const SizedBox(height: 0.0),

                    _buildLabeledRow('Harga Produk', widget.hargaJual, isBold: true, textColor: const Color(0xffecb709)),
                    const SizedBox(height: 0.0),

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
                      fontSize: 10.0,
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
                              builder: (context) => KonfirmasiTransaksi(),
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
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
              value.isNotEmpty ? value : '', // Avoid showing '-' if value is empty
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                color: textColor ?? Colors.black,
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
