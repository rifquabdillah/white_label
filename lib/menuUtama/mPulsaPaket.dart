import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/backend/produk.dart';
import 'package:white_label/transaksipay.dart';
import '../menuSaldo/mSaldo.dart';

class PulsaPaketScreen extends StatefulWidget {
  const PulsaPaketScreen({super.key,});

  @override
  _PulsaPaketScreenState createState() => _PulsaPaketScreenState();
}

class Product {
  final String kodeProduk;
  final List<String> namaProduk;
  final String hargaJual;

  Product({required this.kodeProduk, required this.namaProduk, required this.hargaJual});
}

class _PulsaPaketScreenState extends State<PulsaPaketScreen> {
  Map<String, List<Map<String, dynamic>>>? _fetchedData;
  bool isDataFetched = false; // Untuk melacak apakah data sudah di-fetch
  String? selectedFilter;
  bool isNumberFilled = false; // Asumsikan ini mengatur status nomor yang diisi
  final ScrollController _scrollController = ScrollController();
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
  late FocusNode _focusNode;
  static const String saldo = '2.862.590'; // Consider using localization// Initial height percentage for TabBarWidget

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Set the phone number callback
    NativeChannel.instance.setPhoneNumberCallback(updatePhoneNumber);
    NativeChannel.instance.setSpeechRecognitionCallback(updatePhoneNumber);

    // Listen for focus changes to adjust the TabBar height
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // When keyboard is shown
        setState(() {
          // Adjust as necessary for your layout
        });
      } else {
        // When keyboard is hidden
        setState(() {
          // Fullscreen
        });
      }
    });
  }

  void updatePhoneNumber(String phoneNumber) {
    setState(() {
      _phoneController.text = phoneNumber; // Update the TextField with the cleaned number
      _updateSelectedProvider(phoneNumber); // Update the provider based on the cleaned number // Update the TextField with the selected phone number
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent overflow when keyboard appears
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
                    saldo,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle visibility of saldo
                      });
                    },
                    child: const Icon(Icons.remove_red_eye, color: Color(0xff909EAE)),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SaldoPageScreen()),
                      );
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
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPhoneNumberField(screenSize),
              const SizedBox(height: 8.0),
              // Check if a provider is selected
              if (selectedProvider.isNotEmpty && !selectedProvider.containsKey('null'))
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(
                    selectedProvider.values.first.toString(),
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
                child: TabBarWidget(
                  selectedPromoIndex: 0, // Update as needed
                  onPromoSelected: (index) {
                    setState(() {
                      // Update selected promo index
                    });
                  },
                  tabTitles: ['Pulsa', 'SMS/Nelpon', 'Internet'],
                  isPhoneNumberEmpty: _phoneController.text.isEmpty,
                  selectedProvider: selectedProvider,
                  activeFilters: {},
                  phoneNumber: _phoneController.text
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 16.0),
      child: TextField(
        focusNode: _focusNode,
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
                icon: const Icon(Icons.mic, color: Color(0xffECB709)), // Icon for voice input
                onPressed: () async {
                  await NativeChannel.instance.startSpeechRecognition();
                },
              ),
              IconButton(
                icon: const Icon(Icons.contacts_sharp, color: Color(0xffECB709)), // Icon for contacts
                onPressed: () async {
                  await NativeChannel.instance.getContact();
                },
              ),
            ],
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: _phoneController.text.isEmpty ? FontWeight.normal : FontWeight.w600,
          color: _phoneController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
        ),
        onChanged: (value) {
          _updateSelectedProvider(value);
        },
      ),
    );
  }

  void _updateSelectedProvider(String value) {
    if (value.length >= 4) {
      String prefix = value.substring(0, 4);
      String? providerName = prefixProviderMap[prefix];
      selectedProvider = providerName != null ? {prefix: providerName} : {'null': 'null'};
    } else {
      selectedProvider = {'null': 'null'};
    }
    setState(() {});
  }
}

class TabBarWidget extends StatefulWidget {
  final int selectedPromoIndex;
  final ValueChanged<int> onPromoSelected;
  final List<String> tabTitles;
  final bool isPhoneNumberEmpty;
  final Map<String, String>? selectedProvider;
  final Set<String> activeFilters;
  final String phoneNumber;  // Updated parameter name

  const TabBarWidget({
    super.key,
    required this.selectedPromoIndex,
    required this.onPromoSelected,
    required this.tabTitles,
    required this.isPhoneNumberEmpty,
    required this.selectedProvider,
    required this.activeFilters,
    required this.phoneNumber,  // Updated constructor
  });

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  String? selectedFilter; // To keep track of the selected filter
  Map<String, List<Product>> filteredProducts = {}; // Declare filteredProducts
  late ScrollController _scrollController; // Declare ScrollController
  bool isNumberFilled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // Initialize the ScrollController
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }


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
                color: const Color(0xfffdf7e6),
                child: TabBarView(
                  children: widget.isPhoneNumberEmpty
                      ? [
                    _buildEmptyContent(),
                    _buildEmptyContent(),
                    _buildEmptyContent(),
                  ]
                      : [
                    _buildPulsaTabContent(),
                    _buildSmsTelponTabContent(),
                    _buildInternetTabContent(),
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

  Widget _buildPulsaTabContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildPulsaTabContent", isPulsa: true), // Set isPulsa to true
        ],
      ),
    );
  }

  Widget _buildSmsTelponTabContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildSmsTelponTabContent"),
        ],
      ),
    );
  }

  Widget _buildInternetTabContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildFilterButtons("_buildInternetTabContent"),
        ],
      ),
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchData(
      String methodName,
      String? catatan
      ) async {
    // Fetch data from the API
    var tipe = '';
    switch (methodName) {
      case '_buildPulsaTabContent':
        tipe = 'PULSA';
        break;

      case '_buildSmsTelponTabContent':
        tipe = 'NELPSMS';
        break;

      case '_buildInternetTabContent':
        tipe = 'INTERNET';
        break;
    }

    print("tipe: $tipe");
    var produkInstance = Produk();
    var result = await produkInstance.fetchProduk(
        '${widget.selectedProvider?.keys.first}',
        tipe,
        catatan
    );

    // Assuming the result is already in the required format
    return result; // Return the fetched result
  }

  Widget _buildFilterButtons(String methodName, {bool isPulsa = false}) {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: _fetchData(methodName, null),
      builder: (BuildContext context, AsyncSnapshot<Map<String, List<Map<String, dynamic>>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final data = snapshot.data ?? {};

        // Cek apakah nomor baru saja diisi
        if (isNumberFilled && selectedFilter == null && data.isNotEmpty) {
          setState(() {
            selectedFilter = data.keys.first; // Aktifkan tombol pertama
          });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: data.keys.map((key) {
                    return _buildFilterButtonCard(key);
                  }).toList(),
                ),
              ),
            ),
            if (selectedFilter != null && data.containsKey(selectedFilter))
              isPulsa ? _buildDataPulsaCard(selectedFilter, data[selectedFilter]!) : _buildDataCard(selectedFilter, data[selectedFilter]!),
          ],
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

          _scrollController.jumpTo(
            _scrollController.position.pixels + 100,
          );
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
                      'Nomor Tujuan': widget.phoneNumber,
                      'Harga Produk': item['hargaJual'].toString()
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0), // Margin untuk jarak antar card
              decoration: BoxDecoration(
                color: Colors.transparent, // Pastikan warna transparan untuk container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Warna bayangan
                    offset: Offset(0, 4), // Posisi bayangan
                    blurRadius: 8.0, // Mengaburkan bayangan
                    spreadRadius: 2.0, // Menyebarkan bayangan
                  ),
                ],
              ),
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

  Widget _buildDataPulsaCard(String? key, List<Map<String, dynamic>> data) {
    print('data: $data');
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

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom (2 kolom)
          crossAxisSpacing: 8.0, // Jarak horizontal antar item
          mainAxisSpacing: 8.0, // Jarak vertikal antar item
          childAspectRatio: 3 / 2, // Rasio aspek untuk setiap item
        ),
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
                      'Kode Produk': item['kodeProduk'],
                      'Nomor Tujuan': widget.phoneNumber,
                      'Harga Produk': item['hargaJual'].toString() // Map kosong, sesuaikan sesuai kebutuhan
                    },
                  ),
                ),
              );

            },
            child: Card(
              margin: const EdgeInsets.all(4.0),
              elevation: 2,
              color: Color(0xffFAF9F6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['namaProduk'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ' ${item['hargaCoret']?.toString() ?? '0'}',
                          style: const TextStyle(fontSize: 12, color: Color(0xff909EAE), fontWeight: FontWeight.w400, fontFamily: 'Poppins', decoration: TextDecoration.lineThrough, decorationColor: Color(0xff909EAE)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          ' ${item['kodeProduk'] ?? 'Unknown'}',
                          style: const TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '-',
                          style: TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ' ${item['hargaJual'].toString()}',
                          style: const TextStyle(fontSize: 12, color: Color(0xffECB709), fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ' ${item['detail'] ?? 'No active period available'}',
                      style: const TextStyle(fontSize: 10, color: Color(0xff909EAE)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}