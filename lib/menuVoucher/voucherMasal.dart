import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../backend/produk.dart';
import '../transaksipay.dart';
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

            _buildFilterButtons(), // Add the data display function here
             // Add the data display function here
          ],
        ),
      ),
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchData() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchProduk(
        '',
        'INJECTVOUCHERMASAL',
        ''
    );

    return result;
  }

  Widget _buildFilterButtons() {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, List<Map<String, dynamic>>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final data = snapshot.data ?? {};

        List<Widget> filterWidgets = [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: data.keys.map((key) {
                  return _buildFilterButtonCard(key);
                }).toList(),
              ),
            ),
          ),
        ];

        if (selectedFilter != null && data.containsKey(selectedFilter)) {
          filterWidgets.add(_buildDataCard(selectedFilter, data[selectedFilter]!));
        }

        return Column(
          children: filterWidgets,
        );
      },
    );
  }

  Widget _buildFilterButtonCard(String label) {
    bool isActive = selectedFilter == label;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: isActive ? Color(0xffC70000) : Color(0xffFAF9F6),
        ),
        onPressed: () {
          setState(() {
            selectedFilter = isActive ? null : label;
          });

        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  String? extractPembagian(String inputString, String key) {
    // Step 1: Remove the trailing '|'
    if (inputString.endsWith('|')) {
      inputString = inputString.substring(0, inputString.length - 1);
    }

    // Step 2: Split the string by '|'
    List<String> pairs = inputString.split('|');

    // Step 3: Iterate through each pair to find the key and return its value
    for (String pair in pairs) {
      List<String> keyValue = pair.split('=');
      if (keyValue.length == 2 && keyValue[0] == key) {
        return keyValue[1];  // Return the value of the specific key
      }
    }

    // Return null or empty string if the key is not found
    return null;
  }


  Widget _buildDataCard(String? key, List<Map<String, dynamic>> data) {
    // Print to debug the incoming data
    print('data: $data');

    // Check if the data flist is empty
    if (data.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',  // Display message when there's no data
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      );
    }
    return Container( // Use a container to control the height
      height: MediaQuery.of(context).size.height * 0.60, // Set a height to allow scrolling
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransaksiPay(
                    params: {
                      'Key': key,
                      'Nama': item['namaProduk'] ?? 'Unknown',
                      'Masa Aktif': item['masaAktif'] ?? 'Unknown',
                      'Detail': item['detail'] ?? 'Gada Detail',
                      'Kode Produk': item['kodeProduk'],
                      'Kuota Utama': extractPembagian(item['pembagian'], 'utama') ?? '',
                      'Kuota Khusus 4G': extractPembagian(item['pembagian'], '4g') ?? '',
                      'Kuota Malam': extractPembagian(item['pembagian'], 'malam') ?? '',
                      'Kuota App': extractPembagian(item['pembagian'], 'apps') ?? '',
                      'Deskripsi': 'Ganteng' ?? 'blabla',
                      'Kuota Lokal': extractPembagian(item['pembagian'], 'lokal') ?? '',
                      'Kuota OMG': extractPembagian(item['pembagian'], 'omg') ?? '',
                      'Kuota Nelpon Sesama': extractPembagian(item['pembagian'], 'nelpsama') ?? '',
                      'Kuota Nelpon Semua': extractPembagian(item['pembagian'], 'nelpsemua') ?? '',
                      'Kuota SMS Sesama': extractPembagian(item['pembagian'], 'smssama') ?? '',
                      'Kuota SMS Semua': extractPembagian(item['pembagian'], 'smssemua') ?? '',
                      'Harga Produk': item['hargaJual'].toString()
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0), // Margin untuk jarak antar card
              child: Card(
                elevation: 2,
                color: const Color(0xffFAF9F6), // Warna latar belakang card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
                        children: [
                          Expanded( // Allow the product name to take available space
                            child: Text(
                              item['namaProduk'] ?? 'Unknown', // Display product name
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                            ),
                          ),
                          const SizedBox(width: 8), // Space between product name and original price
                          Text(
                            ' ${item['hargaCoret']?.toString() ?? '0'}', // Display original price
                            style: const TextStyle(fontSize: 14, color: Color(0xff909EAE), fontWeight: FontWeight.w400, fontFamily: 'Poppins', decoration: TextDecoration.lineThrough, decorationColor: Color(0xff909EAE)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
                        children: [
                          Text(
                            ' ${item['kodeProduk'] ?? 'Unknown'}', // Display product code
                            style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(width: 8), // Space between kodeProduk and the dash
                          const Text(
                            '-', // Dash as a separator
                            style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(width: 8), // Space between the dash and hargaJual
                          Text(
                            ' ${item['hargaJual'].toString()}', // Display selling price
                            style: const TextStyle(fontSize: 14, color: Color(0xffECB709), fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ' ${item['detail'] ?? 'No active period available'}', // Display active period
                        style: const TextStyle(fontSize: 12, color: Color(0xff909EAE)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
