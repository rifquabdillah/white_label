import 'package:flutter/material.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/backend/produk.dart';
import 'package:white_label/transaksipay.dart';
import 'package:quickalert/quickalert.dart';
import '../menuSaldo/mSaldo.dart';

class mMultifinance extends StatefulWidget {
  const mMultifinance({super.key});

  @override
  mMultifinanceState createState() => mMultifinanceState();
}

class mMultifinanceState extends State<mMultifinance> {
  int _selectedPascaBayarIndex = 0;
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
            PascaBayarTabBarWidget(
                selectedPascaBayarIndex: _selectedPascaBayarIndex,
                onPascaBayarSelected: (index) {
                  setState(() {
                    _selectedPascaBayarIndex = index;
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
          hintText: 'Nomor Multifinance',
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

class PascaBayarTabBarWidget extends StatefulWidget {
  final int selectedPascaBayarIndex;
  final ValueChanged<int> onPascaBayarSelected;
  final TextEditingController customerNumberController;
  final String customerNumber;

  const PascaBayarTabBarWidget({
    super.key,
    required this.selectedPascaBayarIndex,
    required this.onPascaBayarSelected,
    required this.customerNumberController,
    required this.customerNumber
  });

  @override
  _PertagasTabBarWidgetState createState() => _PertagasTabBarWidgetState();
}

class _PertagasTabBarWidgetState extends State<PascaBayarTabBarWidget> {
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
      'TAGIHANPERTAGAS',
      null,
    );
    return result;
  }

  Future<Map<String, dynamic>> _fetchTagihan(
      String kodeProduk
      ) async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchTagihan(
        kodeProduk,
        '"group_produk":"GAS","produk":"PERTAGAS","tipe_trx":"TAGIHAN","id_produk":"GAS","idpel1":"2771090003","idpel2":"R1","response_code":"00","keterangan":"SUCCESS","timeout":"0","nominal":"21788","nominal_admin":"2500","jml_bln":"-'
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
                    'MULTIFINANCE',
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
                  final data = snapshot.data!['Bayar Tagihan Pertamina GAS'] ?? [];
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
            if (widget.customerNumberController.text.isEmpty) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Oops...',
                text: 'Silakan isi nomor Multifinance terlebih dahulu.',
              );
            } else {
              // Directly proceed to TransaksiPay if customer number is already filled
              // Fetch the tagihan details when "OK" button is pressed
              final data = await _fetchTagihan(item['kodeProduk']);
              // Pass the retrieved data to the TransaksiPay screen
              print('data: $data');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransaksiPay(
                        params: {
                          'Nama': item['namaProduk'] ?? 'Unknown',
                          'Kode Produk': item['kodeProduk'],
                          'Nomor Tagihan': widget.customerNumberController.text,
                          'Nama Pelanggan': data['namaPelanggan'] ,
                          'Tipe Meteran': data['tipeMeteran'],
                          'Jumlah Bulan': data['bulan'],
                          'Periode': data['periode'],
                          'Daya': data['daya'],
                          'Tagihan': (data['tagihan'] is num ? (data['tagihan'] as num).toInt() : 0).toString(),
                          'Admin': (data['admin'] is num ? (data['admin'] as num).toInt() : 0).toString(),
                          'Total Tagihan': (data['jumlahTagihan'] is num ? (data['jumlahTagihan'] as num).toInt() : 0).toString(),
                          'description': item['detailProduk'] ?? 'No description available',
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