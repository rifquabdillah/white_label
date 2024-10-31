import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/transaksipay.dart';

class PulsaPaketScreen extends StatefulWidget {
  const PulsaPaketScreen({super.key,});

  @override
  _PulsaPaketScreenState createState() => _PulsaPaketScreenState();
}

class _PulsaPaketScreenState extends State<PulsaPaketScreen> {
  int _selectedPromoIndex = 0;
  int _activeContentIndex = 0; // Variabel untuk menyimpan konten yang aktif
  final TextEditingController _phoneController = TextEditingController();
  bool _isSaldoVisible = true;
  final Map<String, String> prefixProviderMap = {
    '0852': 'TELKOMSEL',
    '0853': 'TELKOMSEL',
    '0811': 'TELKOMSEL',
    '0812': 'TELKOMSEL',
    '0813': 'TELKOMSEL',
    '0821': 'TELKOMSEL',
    '0822': 'TELKOMSEL',
    '0823': 'TELKOMSEL',
    '0851': 'TELKOMSEL',
    '0855': 'INDOSAT',
    '0856': 'INDOSAT',
    '0857': 'INDOSAT',
    '0858': 'INDOSAT',
    '0814': 'INDOSAT',
    '0815': 'INDOSAT',
    '0816': 'INDOSAT',
    '0817': 'XL',
    '0818': 'XL',
    '0819': 'XL',
    '0859': 'XL',
    '0877': 'XL',
    '0878': 'XL',
    '0832': 'AXIS',
    '0833': 'AXIS',
    '0838': 'AXIS',
    '0895': 'THREE',
    '0896': 'THREE',
    '0897': 'THREE',
    '0898': 'THREE',
    '0899': 'THREE',
    '0881': 'SMARTFREN',
    '0882': 'SMARTFREN',
    '0883': 'SMARTFREN',
    '0884': 'SMARTFREN',
    '0885': 'SMARTFREN',
    '0886': 'SMARTFREN',
    '0887': 'SMARTFREN',
    '0888': 'SMARTFREN',
    '0889': 'SMARTFREN',
  };
  late Map<String, String> selectedProvider = {'null': 'null'};
  Set<String> _activeFilters = {};

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
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
                      _isSaldoVisible ? Icons.remove_red_eye : Icons
                          .visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.add, color: Colors.grey),
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
            // Beri jarak
            if (!selectedProvider.containsKey('null')) // Tampilkan provider jika ada
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
            // Beri jarak
            // Selalu tampilkan TabBarWidget, tapi kontennya bergantung pada nomor ponsel
            // Inside your build method in PulsaPaketScreen
            Expanded(
              child: TabBarWidget(
                selectedPromoIndex: _selectedPromoIndex,
                onPromoSelected: (index) {
                  setState(() {
                    _selectedPromoIndex = index;
                  });
                },
                tabTitles: ['Pulsa', 'SMS/Nelpon', 'Internet'],
                isPhoneNumberEmpty: _phoneController.text.isEmpty,
                selectedProvider: selectedProvider,
                activeFilters: _activeFilters, // Pass active filters here
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
                    icon: const Icon(Icons.mic, color: Color(0xFFecb709)),
                    onPressed: () {
                      // Handle voice input logic here
                    },
                  ),
                  const SizedBox(width: 2),
                  IconButton(
                    icon: const Icon(Icons.contacts, color: Color(0xFFecb709)),
                    onPressed: () {
                      // Handle opening contacts logic here
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
  }
}

class TabBarWidget extends StatelessWidget {
  final int selectedPromoIndex;
  final ValueChanged<int> onPromoSelected;
  final List<String> tabTitles;
  final bool isPhoneNumberEmpty;
  final Map<String, String>? selectedProvider;
  final Set<String> activeFilters;

  const TabBarWidget({
    super.key,
    required this.selectedPromoIndex,
    required this.onPromoSelected,
    required this.tabTitles,
    required this.isPhoneNumberEmpty,
    required this.selectedProvider,
    required this.activeFilters, // Pass active filters here
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
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
                tabs: tabTitles.map((title) => Tab(text: title)).toList(),
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xfffdf7e6),
                child: TabBarView(
                  children: isPhoneNumberEmpty
                      ? [
                    _buildEmptyContent(),
                    _buildEmptyContent(),
                    _buildEmptyContent(),
                  ]
                      : [
                    _buildPulsaTabContent(
                        selectedPromoIndex,
                        onPromoSelected,
                        selectedProvider),
                    _buildSmsTelponTabContent(
                        selectedPromoIndex,
                        onPromoSelected,
                        selectedProvider),
                    _buildInternetTabContent(
                        selectedPromoIndex,
                        onPromoSelected,
                        selectedProvider),
                  ],
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
        'PULSA & PAKET',
        style: TextStyle(color: Color(0xff909EAE)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPulsaTabContent(int selectedPromoIndex,
      ValueChanged<int> onPromoSelected,
      Map<String, String>? selectedProvider) {
    // Similar to _buildPulsaTabContent but with different promo buttons for Internet
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildPulsaTabContent")
        ],
      ),
    );
  }


  Widget _buildSmsTelponTabContent(int selectedPromoIndex,
      ValueChanged<int> onPromoSelected,
      Map<String, String>? selectedProvider) {
    // Similar to _buildPulsaTabContent but with different promo buttons for Internet
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildSmsTelponTabContent")
        ],
      ),
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchData(String methodName) async {
    return await NativeChannel.instance.getPulsaPaketProduk(
      '${selectedProvider?.keys.first}',
      methodName,
    );
  }

  Widget _buildInternetTabContent(int selectedPromoIndex,
      ValueChanged<int> onPromoSelected,
      Map<String, String>? selectedProvider) {
    // Similar to _buildPulsaTabContent but with different promo buttons for Internet
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildInternetTabContent")
        ],
      ),
    );
  }


  Widget _buildFilterButtons(String methodName) {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: _fetchData(methodName),
      builder: (BuildContext context, AsyncSnapshot<Map<String, List<Map<String, dynamic>>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final data = snapshot.data ?? {};

        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Row(
              children: data.keys.map((key) {
                return _buildFilterButtonCard(key, data.keys.toList().indexOf(key));
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterButtonCard(String label, int index) {
    // Check if the current button is the active one
    bool isActive = activeFilters.isNotEmpty && activeFilters.first == label;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0), // Increased margin for better spacing
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: isActive ? Color(0xffC70000) : Color(0xffFAF9F6), // Change color based on state
        ),
        onPressed: () {
          // Update the active filter to allow only one active filter at a time
          if (!isActive) {
            activeFilters.clear(); // Clear previous active filters
            activeFilters.add(label); // Set the current label as the active filter
          }
          onPromoSelected(index); // Notify parent about the selection change
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isActive ? Colors.white : Colors.black, // Change text color based on state
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }






  Widget _buildProductCard(BuildContext context, String namaProduk,
      String masaAktif, String kodeProduk, int hargaJual,
      String detailProduk) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman TransaksiPay
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TransaksiPay(
                  nominal: hargaJual.toString(),
                  // If nominal is an int, leave it as is.
                  kodeproduk: kodeProduk,
                  hargaJual: hargaJual.toString(),
                  // Convert to string here
                  description: 'Deskripsi produk di sini',
                  originalPrice: 'originalPrice',
                  info: detailProduk,
                  transactionType: 'Pulsa',
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0), // Vertical margin
        child: SizedBox(
          width: 400,
          height: 200,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              Card(
                elevation: 1, // Higher elevation for neon effect
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row( // Row to arrange price on the right
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: namaProduk,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff353E43),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' / ', // Separator line
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(
                                          0xff909EAE), // Same color as namaProduk
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$masaAktif Hari',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff353E43),
                                      fontWeight: FontWeight
                                          .w100, // Regular text
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Space between name and code/info
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: kodeProduk,
                                    style: const TextStyle(
                                      color: Color(0xff353E43),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Space between name and code/info
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: detailProduk,
                                    style: const TextStyle(
                                      color: Color(0xff909EAE),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Spacer or Expanded to push price to the right
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Vertically centered
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // Align price to the right
                        children: [
                          Text(
                            hargaJual.toString(),
                            // Convert hargaJual to string for display
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Color(0xffECB709),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
