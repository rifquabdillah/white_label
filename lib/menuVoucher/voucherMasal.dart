import 'package:flutter/material.dart';

import 'injectSatuan.dart';

class VoucherMasalScreen extends StatefulWidget {
  const VoucherMasalScreen({super.key});

  @override
  _VoucherMasalScreenState createState() => _VoucherMasalScreenState();
}

class _VoucherMasalScreenState extends State<VoucherMasalScreen> {
  bool _isSaldoVisible = true;
  String? selectedProvider;
  String? selectedFilter;
  TextEditingController _phoneController = TextEditingController(); // Controller for TextField
  List<Map<String, dynamic>> data = [
    {
      'namaProduk': 'Voucher Pulsa',
      'kodeProduk': 'VP123',
      'hargaJual': 100000,
      'hargaCoret': 150000,
      'detailProduk': 'Voucher Pulsa 100K',
      'masaAktif': '30 Hari',
    },
    {
      'namaProduk': 'Voucher Data',
      'kodeProduk': 'VD456',
      'hargaJual': 50000,
      'hargaCoret': 70000,
      'detailProduk': 'Voucher Data 5GB',
      'masaAktif': '15 Hari',
    },
    // Add more sample data if needed
  ];

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
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Replaced TextField with ElevatedButton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: ElevatedButton(
                onPressed: () {
                  // Show Modal Bottom Sheet instead of AlertDialog
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: const Color(0xfffaf9f6), // Match the app's background color
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Input Nomor Voucher Masal",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xff353E43),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              color: Color(0xff909EAE), // Set color for the underline
                              thickness: 1.5, // Set thickness of the divider
                            ),
                            const SizedBox(height: 10),

                            // Label and TextField for Nomor Seri Voucher
                            const Text(
                              'Nomor Seri Voucher Awal',  // Add label here
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: Color(0xff353E43),
                                fontStyle: FontStyle.italic,  // Making the text italic
                              ),
                            ),

                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0XFFFAF9F6),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffFAF9F6), width: 2.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffFAF9F6), width: 2.0),
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
                                        // Logic for voice input
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.qr_code_scanner_outlined, color: Color(0xffECB709)),
                                      onPressed: () {
                                        // Logic for QR scanner
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
                            const SizedBox(height: 10),

                            // Label and TextField for Nomor Seri Voucher (Second one)
                            const Text(
                              'Nomor Seri Voucher',  // Add label here
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xff353E43),
                              ),
                            ),
                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0XFFFAF9F6),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffFAF9F6), width: 2.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffFAF9F6), width: 2.0),
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
                                        // Logic for voice input
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.qr_code_scanner_outlined, color: Color(0xffECB709)),
                                      onPressed: () {
                                        // Logic for QR scanner
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
                            const SizedBox(height: 10),

                            // Label and TextField for Jumlah Voucher
                            const Text(
                              'Jumlah Voucher',  // Add label here
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xff353E43),
                              ),
                            ),
                            TextField(
                              controller: _phoneController, // Add your controller here
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0XFFfaf9f6),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
                                ),
                                hintText: 'Jumlah Voucher',
                                hintStyle: const TextStyle(
                                  color: Color(0xff909EAE),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff909EAE),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF363636),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // "Batalkan" Text with Underline and Yellow Color
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Center the button
                              children: [
                                // "Batalkan" Text with Underline and Yellow Color
                                TextButton(
                                  onPressed: () {
                                    // Add your cancel logic here
                                  },
                                  child: const Text(
                                    'Batalkan',
                                    style: TextStyle(
                                      color: Color(0xffECB709), // Yellow color
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline, // Underline text
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20), // Add spacing between Batalkan and Input button
                                // "Input" Button with increased size
                                ElevatedButton(
                                  onPressed: () {
                                    // Add your input logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffECB709), // Yellow color for the button
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0), // Increase size
                                    textStyle: const TextStyle(
                                      fontSize: 14, // Change the font size here
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  child: const Text(
                                    'Input',
                                    style: TextStyle(
                                      color: Colors.white, // Change the text color here
                                    ),
                                  ),
                                )

                              ],
                            )

                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFfaf9f6), // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                  side: BorderSide(color: Color(0xffECB709), width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Adjust the radius value here
                  ),
                ),
                child: const Text(
                  'Nomor Seri Voucher',
                  style: TextStyle(
                    color: Color(0xffECB709),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Row(
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
                      color: Color(0xffFAF9F6),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0.1),
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      value: selectedProvider,
                      hint: const Text('Pilih Provider'),
                      underline: Container(),
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
                              Image.asset('assets/axis.png', width: 20, height: 20),
                              const SizedBox(width: 8),
                              const Text('Axis'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Telkomsel',
                          child: Row(
                            children: [
                              Image.asset('assets/telkomsel.png', width: 20, height: 20),
                              const SizedBox(width: 8),
                              const Text('Telkomsel'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Indosat',
                          child: Row(
                            children: [
                              Image.asset('assets/indosat.png', width: 20, height: 20),
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
            ),
            const SizedBox(height: 10),
            Divider(
              color: Color(0xffECB709),
              thickness: 2,
            ),
            FilterWidget(), // Insert the filter widget
            _buildDataCard(data), // Add the data display function here
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

  // Function to build the data card
  Widget _buildDataCard(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Tidak ada voucher yang tersedia.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        var item = data[index];
        return _buildDataCardItem(item);
      },
    );
  }

  Widget _buildDataCardItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        // Navigation to voucher detail screen can go here
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          color: const Color(0xffFAF9F6),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['namaProduk'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 5),
                Text(item['kodeProduk']),
                const SizedBox(height: 5),
                Text('Harga Jual: ${item['hargaJual']}'),
                Text('Harga Coret: ${item['hargaCoret']}'),
                const SizedBox(height: 5),
                Text('Detail Produk: ${item['detailProduk']}'),
                Text('Masa Aktif: ${item['masaAktif']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
