import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
  String _buttonText = "Input Nomor Voucher Masal"; // Default teks tombol
  bool _isInjecting = false; // Status untuk proses injeksi voucher
  final TextEditingController _voucherStartController = TextEditingController();
  final TextEditingController _voucherEndController = TextEditingController();
  final TextEditingController _voucherAmountController = TextEditingController();

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
  ];

  void _updateVoucherAmount() {
    final start = int.tryParse(_voucherStartController.text) ?? 0;
    final end = int.tryParse(_voucherEndController.text) ?? 0;

    if (end >= start) {
      final amount = end - start + 1; // Menghitung jumlah voucher
      _voucherAmountController.text = amount.toString();
    } else {
      _voucherAmountController.text = '0'; // Reset jika input tidak valid
    }
  }



  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';
    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: AppBar(
        backgroundColor: const Color(0xfffaf9f6),
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
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 60,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_buttonText == "Input Nomor Voucher Masal") {
                    // Menampilkan modal input
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: const Color(0xfffaf9f6),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                              const Text(
                                'Nomor Seri Voucher Awal',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                  color: Color(0xff353E43),
                                ),
                              ),
                              TextField(
                                controller: _voucherStartController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _updateVoucherAmount(),
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan Nomor Seri Awal',
                                  hintStyle: TextStyle(
                                    color: Color(0xff909EAE),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Nomor Seri Voucher Akhir',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                  color: Color(0xff353E43),
                                ),
                              ),
                              TextField(
                                controller: _voucherEndController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _updateVoucherAmount(),
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan Nomor Seri Akhir',
                                  hintStyle: TextStyle(
                                    color: Color(0xff909EAE),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Jumlah Voucher',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                  color: Color(0xff353E43),
                                ),
                              ),
                              TextField(
                                controller: _voucherAmountController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: 'Jumlah Voucher',
                                  hintStyle: TextStyle(
                                    color: Color(0xff909EAE),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_voucherAmountController.text != '0' &&
                                          _voucherAmountController.text.isNotEmpty) {
                                        setState(() {
                                          _buttonText =
                                          'Inject ${_voucherAmountController.text} Voucher';
                                        });
                                      }
                                      Navigator.pop(context); // Tutup modal
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffECB709),
                                    ),
                                    child: const Text(
                                      'Simpan',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    // Proses injeksi voucher
                    setState(() {
                      _isInjecting = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        _isInjecting = false;
                        _buttonText = "Input Nomor Voucher Masal"; // Reset tombol
                      });

                      // Menampilkan QuickAlert
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Berhasil!',
                        text: 'Voucher berhasil di-inject!',
                        confirmBtnText: 'OK',
                        confirmBtnColor: const Color(0xffECB709),
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFfaf9f6),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                  side: const BorderSide(color: Color(0xffECB709), width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  _isInjecting ? "Injecting..." : _buttonText,
                  style: const TextStyle(
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
