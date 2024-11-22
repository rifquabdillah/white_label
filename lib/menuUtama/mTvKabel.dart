import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/backend/produk.dart';
import 'package:white_label/transaksipay.dart';

import '../menuSaldo/mSaldo.dart';

class mTvKabelScreen extends StatefulWidget {
  const mTvKabelScreen({super.key,});

  @override
  mTvKabelScreenState createState() => mTvKabelScreenState();
}

class Product {
  final String kodeProduk;
  final List<String> namaProduk;
  final String hargaJual;

  Product({required this.kodeProduk, required this.namaProduk, required this.hargaJual});
}

class mTvKabelScreenState extends State<mTvKabelScreen> {
  int _selectedPromoIndex = 0;
  final TextEditingController _phoneController = TextEditingController();
  bool _isSaldoVisible = true;
  final Map<String, String> prefixProviderMap = {
    // Define your provider prefix mappings
  };
  late Map<String, String> selectedProvider = {'null': 'null'};
  Set<String> _activeFilters = {};
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const String saldo = '2.862.590'; // Consider using localization
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
                      _isSaldoVisible ? Icons.remove_red_eye : Icons.visibility_off,
                      color: Color(0xff909EAE),
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
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize),
            const SizedBox(height: 8.0),
            if (!selectedProvider.containsKey('null'))
              Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Text(
                  ' ${selectedProvider.values.first.toString()}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Color(0xff909EAE),
                  ),
                ),
              ),
            const SizedBox(height: 8.0),
            Expanded(
              child: TokenTabBarWidget(
                  selectedPromoIndex: _selectedPromoIndex,
                  onPromoSelected: (index) {
                    setState(() {
                      _selectedPromoIndex = index;
                    });
                  },
                  tabTitles: ['Tv Kabel'],
                  isPhoneNumberEmpty: _phoneController.text.isEmpty,
                  selectedProvider: selectedProvider,
                  activeFilters: _activeFilters,
                  phoneNumber: _phoneController.text
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0XFFfaf9f6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff353E43), width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff353E43), width: 3.0),
              ),
              hintText: 'Masukkan Nomor Tv Kabel',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              setState(() {
                if (value.length >= 4) {
                  String prefix = value.substring(0, 4);
                  if (prefixProviderMap.containsKey(prefix)) {
                    selectedProvider = {prefix: prefixProviderMap[prefix]!};
                  } else {
                    selectedProvider = {'null': 'null'};
                  }
                } else {
                  selectedProvider = {'null': 'null'};
                }
              });
            },
          ),
        ),
      ],
    );
  }}

class TokenTabBarWidget extends StatefulWidget {
  final int selectedPromoIndex;
  final ValueChanged<int> onPromoSelected;
  final List<String> tabTitles;
  final bool isPhoneNumberEmpty;
  final Map<String, String>? selectedProvider;
  final String phoneNumber;

  const TokenTabBarWidget({
    super.key,
    required this.selectedPromoIndex,
    required this.onPromoSelected,
    required this.tabTitles,
    required this.isPhoneNumberEmpty,
    required this.selectedProvider, required Set<String> activeFilters,
    required this.phoneNumber,
  });

  @override
  _TokenTabBarWidgetState createState() => _TokenTabBarWidgetState();
}

class _TokenTabBarWidgetState extends State<TokenTabBarWidget> {
  Set<String> _activeFilters = {}; // Declare the active filters set
  String? selectedFilter; // Declare selected filter

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabTitles.length,
      child: Container(
        color: const Color(0xfffaf9f6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: TabBar(
                labelColor: const Color(0xff353E43),
                unselectedLabelColor: const Color(0xff909EAE),
                indicatorColor: const Color(0xffECB709),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                tabs: widget.tabTitles.map((title) => Tab(text: title))
                    .toList(),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xfffdf7e6),
                child: TabBarView(
                  children: widget.isPhoneNumberEmpty
                      ? [_buildEmptyContent()]
                      : [_buildTvKabelTabContent()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyContent() {
    return Center(
      child: Text(
        'TV KABEL',
        style: TextStyle(color: Color(0xff909EAE)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchTagihan(String kodeProduk) async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchTagihan(
        kodeProduk,
        'group_produk:TV BERLANGGANAN/produk:CBN/tipe_trx:BAYAR/id_produk:TVCBN/idpel1:30124154/idpel2:/response_code:00/keterangan:Success/timeout:0/nominal:254190/nominal_admin:0/jml_bln:-'
    );
    return result;
  }

  Widget _buildTvKabelTabContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildTvKabelTabContent"),
        ],
      ),
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchData() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchProduk(
        '${widget.selectedProvider?.keys.first}',
        'TAGIHANTVKABEL',
        ''
    );
    return result; // Return the fetched result
  }


  Widget _buildFilterButtons(String methodName) {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: _fetchData(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, List<Map<String, dynamic>>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final data = snapshot.data ?? {};
        return Column(
          children: [
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
            if (selectedFilter != null && data.containsKey(selectedFilter))
              _buildDataCard(context, data[selectedFilter]!),
          ],
        );
      },
    );
  }

  Widget _buildFilterButtonCard(String key) {
    final isActive = _activeFilters.contains(key);

    return Container(
      margin: const EdgeInsets.all(8.0), // Margin untuk spasi antar tombol
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2, // Tinggi elevasi tombol
          backgroundColor: isActive ? const Color(0xffC70000) : const Color(0xffFAF9F6),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Padding di dalam tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Radius sudut tombol
          ),
        ),
        onPressed: () {
          setState(() {
            if (isActive) {
              _activeFilters.remove(key);
              selectedFilter = null;
            } else {
              _activeFilters.clear();
              _activeFilters.add(key);
              selectedFilter = key;
            }
          });
        },
        child: Text(
          key,
          style: TextStyle(
            fontSize: 13, // Ukuran font
            color: isActive ? Colors.white : const Color(0xff353E43), // Warna teks
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
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

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            // Membuat ListView menyusut agar tidak mengambil ruang yang tidak perlu
            physics: NeverScrollableScrollPhysics(),
            // Menonaktifkan scroll ListView jika sudah di dalam SingleChildScrollView
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return GestureDetector(
                onTap: () async {
                  if (widget.phoneNumber.isEmpty) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oopss...',
                      text: 'Silakan isi nomor pelanggan PDAM terlebih dahulu.',
                    );
                  } else {
                    final data = await _fetchTagihan(item['kodeProduk']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TransaksiPay(
                              params: {
                                'Nama': item['namaProduk'] ?? 'Unknown',
                                'Kode Produk': item['kodeProduk'],
                                'Nomor Tagihan': widget.phoneNumber,
                                'Nama Pelanggan': data['namaPelanggan'],
                                'Tipe Meteran': data['tipeMeteran'],
                                'Jumlah Bulan': data['bulan'],
                                'Periode': data['periode'],
                                'Daya': data['daya'],
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
                        offset: Offset(0, 0), // Bayangan merata di semua sisi
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Card(
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
