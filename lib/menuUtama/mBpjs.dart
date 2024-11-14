import 'package:flutter/material.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/backend/produk.dart';
import 'package:white_label/transaksipay.dart';
import 'package:quickalert/quickalert.dart';

import '../menuSaldo/mSaldo.dart';

class BpjsScreen extends StatefulWidget {
  const BpjsScreen({super.key});

  @override
  _BpjsScreenState createState() => _BpjsScreenState();
}

class _BpjsScreenState extends State<BpjsScreen> {
  int _selectedBpjsIndex = 0;
  final TextEditingController _phoneController = TextEditingController();
  bool _isSaldoVisible = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
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
                      _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons
                          .visibility_off,
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
          toolbarHeight: 60,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize),
            const SizedBox(height: 0),
            BpjsTabBarWidget(
                selectedBpjsIndex: _selectedBpjsIndex,
                onBpjsSelected: (index) {
                  setState(() {
                    _selectedBpjsIndex = index;
                  });
                },
                phoneController: _phoneController,
                phoneNumber: _phoneController.text// Diteruskan ke widget tab bar
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 16.0),
      child: TextField(
        controller: _phoneController,
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
          hintText: 'Masukkan nomor handphone',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.mic, color: Color(0xffECB709)),
                // Icon for voice input
                onPressed: () async {
                  await NativeChannel.instance.startSpeechRecognition();
                },
              ),
              IconButton(
                icon: const Icon(
                    Icons.contacts_sharp, color: Color(0xffECB709)),
                // Icon for contacts
                onPressed: () async {
                  await NativeChannel.instance.getContact();
                },
              ),
            ],
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: _phoneController.text.isEmpty
              ? FontWeight.normal
              : FontWeight.w600,
          color: _phoneController.text.isEmpty ? Colors.grey : const Color(
              0xFF363636),
        ),
      ),
    );
  }
}

class BpjsTabBarWidget extends StatefulWidget {
  final int selectedBpjsIndex;
  final ValueChanged<int> onBpjsSelected;
  final TextEditingController phoneController;
  final String phoneNumber;

  const BpjsTabBarWidget({
    super.key,
    required this.selectedBpjsIndex,
    required this.onBpjsSelected,
    required this.phoneController,
    required this.phoneNumber
  });

  @override
  _BpjsTabBarWidgetState createState() => _BpjsTabBarWidgetState();
}

class _BpjsTabBarWidgetState extends State<BpjsTabBarWidget> {
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
      'TAGIHANBPJS',
      null,
    );
    return result;
  }

  // Method to fetch the tagihan details
  Future<Map<String, dynamic>> _fetchTagihan() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchTagihan(
        'BYRBPJS',
        'kodeproduk:ASRBPJSKSH/tanggal:20241107154828/idpel1:002084934205/idpel2:/idpel3:/nominal:105000/admin:2500/id_outlet:SP390394/pin:------/ref1:CEK90335191/ref2:462139944/ref3:/status:00/keterangan:Success/fee:-1550/saldo_terpotong:105950/sisa_saldo:8063531/total_bayar:107500/no_va_keluarga:8888802084934205/jml_keluarga:3/no_hp:/no_ref:/nama_pelanggan:ALI KANZAKI ROKHMANI/periode:1'
    );
    return result; // Return the fetched result
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
                    'BPJS',
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
            child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!['Pembayaran BPJS'] ?? [];
                  return _buildDataCard(context, data);
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(BuildContext context, List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(fontSize: 14.0),
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
            if (widget.phoneController.text.isEmpty) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Oops...',
                text: 'Silakan isi nomor BPJS terlebih dahulu.',
              );
            } else {
              // Ambil data tagihan ketika tombol OK ditekan
              final data = await _fetchTagihan();
              // Pass data ke layar TransaksiPay
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransaksiPay(
                        params: {
                          'Nama': item['namaProduk'] ?? 'Unknown',
                          'Kode Produk': 'BYRBPJS',
                          'Nomor Tagihan': widget.phoneNumber,
                          'Periode Bayar': data['periode']?.toString() ??
                              'Unknown',
                          'Nama Pelanggan': data['namaPelanggan'] ?? 'Unknown',
                          'Jumlah Keluarga': data['jumlahKeluarga'],
                          'Tagihan': (data['tagihan'] is num
                              ? (data['tagihan'] as num).toInt()
                              : 0).toString(),
                          'Admin': (data['admin'] is num
                              ? (data['admin'] as num).toInt()
                              : 0).toString(),
                          'Total Tagihan': (data['jumlahTagihan'] is num
                              ? (data['jumlahTagihan'] as num).toInt()
                              : 0).toString(),
                          'description': item['detailProduk'] ??
                              'No description available',
                        },
                      ),
                ),
              );
            }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['namaProduk'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['kodeProduk'] ?? 'No description available',
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}