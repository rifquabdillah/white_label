import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Referral Markup App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReferallMarkupScreen(), // Set the home screen to the ReferallMarkupScreen
    );
  }
}

class ReferallMarkupScreen extends StatefulWidget {
  const ReferallMarkupScreen({super.key});

  @override
  _ReferallMarkupScreenState createState() => _ReferallMarkupScreenState();
}

class _ReferallMarkupScreenState extends State<ReferallMarkupScreen> {
// Controller for phone input
  final TextEditingController _phoneController = TextEditingController();

  // Daftar produk dan jenis produknya dengan detail
  final Map<String, List<Map<String, String>>> _productTypes = {
    'Pulsa by.U Promo': [
      {
        'name': 'Pulsa by.U 5.000',
        'code': 'BYUP5',
        'price': '5.173',
        'status': 'Open',
      },
      {
        'name': 'Pulsa by.U 10.000',
        'code': 'BYUP10',
        'price': '10.345',
        'status': 'Open',
      },
      {
        'name': 'Pulsa by.U 20.000',
        'code': 'BYUP20',
        'price': '20.690',
        'status': 'Closed',
      },
      {
        'name': 'Pulsa by.U 50.000',
        'code': 'BYUP50',
        'price': '51.725',
        'status': 'Open',
      },
    ],

    'Pulsa by.U': [
      {
        'name': 'Jenis 1',
        'code': 'XYZ1',
        'price': '1.000',
        'status': 'Closed',
      },
    ],
    'Pulsa Telkomsel Promo': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa Telkomsel Nasional': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa Telkomsel Premium': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa XL - AXIS Regular': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa XL - AXIS Super Promo': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa Indosat Mixed with TP': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa Indosat Nasional': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa Smartfren': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Pulsa Tri Nasional': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
    'Tambah Masa Aktif Kartu AXIS': [
      {
        'name': 'Jenis 1',
        'code': 'TELK1',
        'price': '2.000',
        'status': 'Open',
      },
    ],
  };

  // Track the expanded state of each product
  final Set<String> _expandedProducts = {};

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: const Color(0XFFfaf9f6),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              toolbarHeight: 60,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize), // Kolom input nomor telepon
            const SizedBox(height: 16), // Space between input and new content
            _buildNewContent(), // New content below the phone number field
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(Size screenSize) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding around the container
      decoration: BoxDecoration(
        color: const Color(0XFFfaf9f6), // Background color for the container
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 1, // How much the shadow spreads
            blurRadius: 5, // Softness of the shadow
            offset: const Offset(0, 2), // Position of the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, bottom: 8.0),
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0XFFfaf9f6),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff353E43), width: 2.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff353E43), width: 2.0),
                ),
                hintText: 'Cari Produk',
                hintStyle: const TextStyle(
                  color: Color(0xff909EAE),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search,size: 30, color: Color(0xff909EAE)),
                      onPressed: () {
                        // Tambahkan logika untuk menangani input suara di sini
                      },
                    ),
                  ],
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: _phoneController.text.isEmpty
                    ? FontWeight.w400
                    : FontWeight.w600,
                color: _phoneController.text.isEmpty
                    ? Color(0xff909EAE)
                    : const Color(0xFF363636),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // Add the text below the phone number field
          Padding(
            padding: const EdgeInsets.only(left: 0.0, bottom: 16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Kode Referral : ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff909EAE), // Color for the initial text
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: 'DAFTAR',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xffECB709), // Change this to yellow
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      // Remove horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), // Space between title and content
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.7,
            // Set height to 70% of screen height
            width: double.infinity,
            // Set to fill the available width
            padding: const EdgeInsets.symmetric(horizontal: 0),
            // No horizontal padding
            child: SingleChildScrollView( // Use SingleChildScrollView for scrolling
              child: Column(
                children: _productTypes.keys.map((productName) {
                  return _buildProdukItem(productName);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProdukItem(String productName) {
    bool isExpanded = _expandedProducts.contains(productName);

    return Container(
      width: 380,
      // Sama seperti lebar produkItem
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      // Jarak antar item produk
      padding: const EdgeInsets.all(4.0),
      // Padding di dalam kontainer
      decoration: BoxDecoration(
        color: const Color(0xFFf0f0f0), // Warna latar belakang yang serupa
        borderRadius: BorderRadius.circular(8.0), // Sudut membulat
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0), // Posisi bayangan
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Align items vertically to the center
            children: [
              Expanded(
                child: Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down_outlined,
                  size: 40,
                  color: const Color(0xff909EAE),
                ),
                onPressed: () {
                  setState(() {
                    if (isExpanded) {
                      _expandedProducts.remove(productName);
                    } else {
                      _expandedProducts.add(productName);
                    }
                  });
                },
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 0), // Space between title and details
            ..._buildProductDetail(_productTypes[productName]!)
          ],
        ],
      ),
    );
  }

  List<Widget> _buildProductDetail(List<Map<String, String>> productDetails) {
    return productDetails.asMap().map((index, detail) {
      // Determine the background color based on the index
      Color backgroundColor = (index % 2 == 0) ? Color(0xFFCBD6E4) : Color(
          0xFFD7E1EE);

      return MapEntry(
        index,
        Container(
          // Set width to fill the available space
          width: double.infinity,
          // Change width to double.infinity
          margin: const EdgeInsets.symmetric(vertical: 0.0),
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          // Only vertical padding
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan nama produk
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    detail['name'] ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Menampilkan kode produk
                  Text(
                    detail['code'] ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color(0xff909EAE),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between code and price
                  // Menampilkan harga produk
                  Text(
                    detail['price'] ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color(0xff353E43),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: detail['status'] == 'OPEN' ? Colors.green : Color(
                          0xff198754),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      detail['status'] ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).values.toList(); // Convert the map values back to a list
  }
}

