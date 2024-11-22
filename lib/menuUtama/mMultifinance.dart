import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/backend/produk.dart';
import 'package:white_label/transaksipay.dart';

import '../menuSaldo/mSaldo.dart';

class mMultifinance extends StatefulWidget {
  const mMultifinance({super.key,});

  @override
  _mMultifinanceScreenState createState() => _mMultifinanceScreenState();
}

class Product {
  final String kodeProduk;
  final List<String> namaProduk;
  final String hargaJual;

  Product({required this.kodeProduk, required this.namaProduk, required this.hargaJual});
}

class _mMultifinanceScreenState extends State<mMultifinance> {
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
                      _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off,
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
                  tabTitles: ['Multifinance'],
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
              hintText: 'Masukkan Nomor Multifinance',
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
                tabs: widget.tabTitles.map((title) => Tab(text: title)).toList(),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xffFDF7E6),
                child: TabBarView(
                  children: widget.isPhoneNumberEmpty
                      ? [_buildEmptyContent()]
                      : [_buildMultifinanceTabContent()],
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
        'MULTIFINANCE',
        style: TextStyle(color: Color(0xff909EAE)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMultifinanceTabContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildMultifinanceTabContent"),
        ],
      ),
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchData() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchProduk(
        '${widget.selectedProvider?.keys.first}',
        'TAGIHANMULTIFINANCE',
        ''
    );
    return result; // Return the fetched result
  }


  Widget _buildFilterButtons(String methodName) {
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
              _buildDataCard(selectedFilter, data[selectedFilter]!),
          ],
        );
      },
    );
  }

  Widget _buildFilterButtonCard(String key) {
    final isActive = _activeFilters.contains(key);
    return GestureDetector(
      onTap: () {
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
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isActive ? Color(0xffC70000) : Color(0xffFAF9F6),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Color of the shadow
              spreadRadius: 1, // Spread of the shadow
              blurRadius: 5, // Blur radius of the shadow
              offset: Offset(0, 3), // Offset of the shadow (x, y)
            ),
          ],
        ),
        child: Text(
          key,
          style: TextStyle(
            color: isActive ? Colors.white : Color(0xff353E43),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard(String? key, List<Map<String, dynamic>> data) {
    // Print to debug the incoming data
    print('data: $data');

    // Check if the data list is empty
    if (data.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xffFAF9F6),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 0), // Bayangan merata di setiap sisi
            ),
          ],
        ),
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
      height: MediaQuery.of(context).size.height * 0.6, // Set a height to allow scrolling
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
                      'Detail': item['detail'] ?? 'No Detail Available',
                      'Kode Produk': item['kodeProduk'],
                      'Nomor Tujuan': widget.phoneNumber,
                      'Harga Produk': item['hargaJual'].toString()
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0), // Margin for spacing between cards
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent color for container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    offset: Offset(0, 4), // Shadow position
                    blurRadius: 8.0, // Blur the shadow
                    spreadRadius: 2.0, // Spread the shadow
                  ),
                ],
              ),
              child: Card(
                color: const Color(0xffFAF9F6), // Card background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
                        children: [
                          Expanded(
                            child: Text(
                              item['namaProduk'] ?? 'Unknown', // Display product name
                              style: const TextStyle(
                                color: Color(0xff353E43),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Space between product name and original price
                          Text(
                            ' ${item['hargaCoret']?.toString() ?? '0'}', // Display original price
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff909EAE),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xff909EAE),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ' ${item['kodeProduk'] ?? 'Unknown'}', // Display product code
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              color: Color(0xff353E43),
                            ),
                          ),
                          const SizedBox(width: 8), // Space between kodeProduk and the dash
                          const Text(
                            '-', // Dash separator
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(width: 8), // Space between the dash and hargaJual
                          Text(
                            ' ${item['hargaJual'].toString()}', // Display selling price
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xffECB709),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ' ${item['detail'] ?? 'No active period available'}', // Display active period or description
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
