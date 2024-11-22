import 'package:flutter/material.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/backend/produk.dart';
import 'package:white_label/transaksipay.dart';
import 'package:quickalert/quickalert.dart';

import '../menuSaldo/mSaldo.dart';

class PlnScreen extends StatefulWidget {
  const PlnScreen({super.key});

  @override
  _PlnScreenState createState() => _PlnScreenState();
}

class _PlnScreenState extends State<PlnScreen> {
  int _selectedPlnIndex = 0;
  final TextEditingController _customerNumberController = TextEditingController();
  bool _isSaldoVisible = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const String saldo = '2.862.590';
    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SaldoPageScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF909EAE),
                        borderRadius: BorderRadius.circular(4),
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
          toolbarHeight: 60,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerNumberField(screenSize),
            const SizedBox(height: 0),
            PlnTabBarWidget(
                selectedPlnIndex: _selectedPlnIndex,
                onPlnSelected: (index) {
                  setState(() {
                    _selectedPlnIndex = index;
                  });
                },
                customerNumberController: _customerNumberController,
                customerNumber: _customerNumberController.text
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerNumberField(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 16.0),
      child: TextField(
        controller: _customerNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0XFFfaf9f6),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          hintText: 'Masukkan nomor pelanggan PLN',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.mic, color: Color(0xffECB709)),
                onPressed: () async {
                  await NativeChannel.instance.startSpeechRecognition();
                },
              ),
              IconButton(
                icon: const Icon(Icons.contacts_sharp, color: Color(0xffECB709)),
                onPressed: () async {
                  await NativeChannel.instance.getContact();
                },
              ),
            ],
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: _customerNumberController.text.isEmpty
              ? FontWeight.normal
              : FontWeight.w600,
          color: _customerNumberController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
        ),
      ),
    );
  }
}

class PlnTabBarWidget extends StatefulWidget {
  final int selectedPlnIndex;
  final ValueChanged<int> onPlnSelected;
  final TextEditingController customerNumberController;
  final String customerNumber;

  const PlnTabBarWidget({
    super.key,
    required this.selectedPlnIndex,
    required this.onPlnSelected,
    required this.customerNumberController,
    required this.customerNumber
  });

  @override
  _PlnTabBarWidgetState createState() => _PlnTabBarWidgetState();
}

class _PlnTabBarWidgetState extends State<PlnTabBarWidget> {
  late Future<Map<String, List<Map<String, dynamic>>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchData() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchProduk(
      null,
      'TAGIHANPLN',
      null,
    );
    return result;
  }

  Future<Map<String, dynamic>> _fetchTagihan() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchTagihan(
        'BYRPLN',
        'kodeproduk:PLNPASCH/tanggal:20241108093429/idpel1:538740190050/idpel2:/idpel3:/nominal:342570/admin:3000/id_outlet:SP390394/pin:------/ref1:CEK90408159/ref2:462614781/ref3:/status:00/keterangan:TRANSAKSI SUKSES/fee:-2689/saldo_terpotong:342881/sisa_saldo:6766087/total_bayar:345570/jml_bulan:1/tarif:R1M/daya:900/ref:/stanawal:83540/stanakhir:38/infoteks:/nama_pelanggan:NURDIN/periode:202411'
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: const Color(0xfffaf9f6),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'PLN',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffFDF7E6), // Menambahkan warna latar belakang pada konten
              child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching data'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!['Pembayaran Tagihan PLN'] ?? [];
                    return _buildDataCard(context, data);
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildDataCard(BuildContext context, List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(16.0), // Jarak pada semua sisi
        decoration: BoxDecoration(
          color: const Color(0xffFAF9F6),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna bayangan
              blurRadius: 5, // Radius blur
              spreadRadius: 2, // Radius penyebaran
              offset: const Offset(0, 2), // Posisi bayangan (x, y)
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return GestureDetector(
          onTap: () async {
            if (widget.customerNumberController.text.isEmpty) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Oops...',
                text: 'Silakan isi nomor pelanggan PLN terlebih dahulu.',
              );
            } else {
              final fetchedData = await _fetchTagihan();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransaksiPay(
                    params: {
                      'Nama': item['namaProduk'] ?? 'Unknown',
                      'Kode Produk': item['kodeProduk'],
                      'Nomor Tagihan': widget.customerNumberController.text,
                      'Nama Pelanggan': fetchedData['namaPelanggan'],
                      'Tipe Meteran': fetchedData['tipeMeteran'],
                      'Jumlah Bulan': fetchedData['bulan'],
                      'Periode': fetchedData['periode'],
                      'Daya': fetchedData['daya'],
                      'Tagihan': (fetchedData['tagihan'] as num?)?.toInt().toString() ?? '0',
                      'Admin': (fetchedData['admin'] as num?)?.toInt().toString() ?? '0',
                      'Total Tagihan': (fetchedData['jumlahTagihan'] as num?)?.toInt().toString() ?? '0',
                      'description': item['detailProduk'] ?? 'No description available',
                    },
                  ),
                ),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Jarak pada sisi atas, bawah, kanan, dan kiri
            decoration: BoxDecoration(
              color: const Color(0xffFAF9F6),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10), // Warna bayangan
                  blurRadius: 2, // Radius blur
                  spreadRadius: 3, // Radius penyebaran
                  offset: const Offset(0, 0), // Posisi bayangan (x, y)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['namaProduk'] ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['kodeProduk'] ?? 'No description available',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}