import 'package:flutter/material.dart';

class InjectVoucherSatuanScreen extends StatefulWidget {
  const InjectVoucherSatuanScreen({super.key});

  @override
  _InjectVoucherSatuanScreenState createState() => _InjectVoucherSatuanScreenState();
}

class _InjectVoucherSatuanScreenState extends State<InjectVoucherSatuanScreen> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();
  String? selectedProvider;

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';
    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: AppBar(
        backgroundColor: const Color(0XFFfaf9f6),
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
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman SaldoPage
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
        toolbarHeight: 60,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field Input Nomor Seri Voucher
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0XFFfaf9f6),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
                ),
                hintText: 'Nomor Seri Voucher',
                hintStyle: const TextStyle(
                  color: Color(0xff909EAE),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mic, color: Color(0xffECB709)),
                      onPressed: () {
                        // Logika untuk input suara
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner_outlined, color: Color(0xffECB709)),
                      onPressed: () {
                        // Logika untuk scanner kode QR
                      },
                    ),
                  ],
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF363636),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown untuk memilih provider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Provider Voucher',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    color: Color(0xff353E43),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xffFAF9F6), // Tambahkan warna latar belakang untuk shadow
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15), // Warna shadow dengan opacity
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0.1), // Posisi shadow (x, y)
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedProvider,
                    hint: const Text('Pilih Provider'),
                    underline: Container(), // Menghilangkan underline bawaan
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProvider = newValue;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Axis',
                        child: Row(
                          children: [
                            Image.asset('assets/axis.png', width: 20, height: 20), // Logo provider Axis
                            const SizedBox(width: 8),
                            const Text('Axis'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Telkomsel',
                        child: Row(
                          children: [
                            Image.asset('assets/telkomsel.png', width: 20, height: 20), // Logo provider Telkomsel
                            const SizedBox(width: 8),
                            const Text('Telkomsel'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Indosat',
                        child: Row(
                          children: [
                            Image.asset('assets/indosat.png', width: 20, height: 20), // Logo provider Indosat
                            const SizedBox(width: 8),
                            const Text('Indosat'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Jarak antara Row dan Divider
            Divider(
              color: Color(0xffECB709), // Warna oranye
              thickness: 2, // Ketebalan divider
              indent: 0, // Tidak ada indentasi di awal
              endIndent: 0, // Tidak ada indentasi di akhir
            ),
            Expanded(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // Logika untuk Inject Voucher Satuan
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xfffaf9f6),
                  ),
                  child: Text(
                    'Inject Voucher Satuan',
                    style: TextStyle(
                      color: Color(0xff909EAE),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
