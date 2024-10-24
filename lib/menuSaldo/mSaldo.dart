import 'package:flutter/material.dart';
import 'package:white_label/menuSaldo/transferBank.dart';

class SaldoPageScreen extends StatefulWidget {
  const SaldoPageScreen({super.key});

  @override
  _SaldoPageScreenState createState() => _SaldoPageScreenState();
}

class _SaldoPageScreenState extends State<SaldoPageScreen> {
// Controller for phone input
  bool _isSaldoVisible = true;
  // Daftar produk dan jenis produknya dengan detail
  final Map<String, List<Map<String, String>>> _productTypes = {
    'Transfer Bank via Tiket Deposit': [
    ],

    'Alfamart Indomaret via Plasamall': [

    ],
    'Tukar Komisi': [

    ],
    'Redeem Poin': [

    ],
  };
  // Track the expanded state of each product
  final Set<String> _expandedProducts = {};

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const String saldo = '2.862.590';
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFFfaf9f6), // Background color of the AppBar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2), // Position of the shadow
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Set background transparent for shadow effect
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
                          MaterialPageRoute(builder: (context) => SaldoPageScreen()), // Replace with your SaldoPage
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // Input field for phone number
            const SizedBox(height: 16), // Space between input and new content
            _buildNewContent(), // New content below the phone number field
          ],
        ),
      ),
    );
  }

  Widget _buildNewContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), // Space between title and content
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            // Set height to 70% of screen height
            width: double.infinity,
            // Set to fill the available width
            padding: const EdgeInsets.symmetric(horizontal: 0),
            // No horizontal padding
            child: Column(
              children: _productTypes.keys.map((productName) {
                return _buildProdukItem(productName);
              }).toList(),
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFf0f0f0),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (productName == 'Transfer Bank via Tiket Deposit') {
                      // Navigate to TransferBankScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const transferBankScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                  color: const Color(0xff909EAE),
                ),
                onPressed: null, // Disable interaction
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 0),
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
            ],
          ),
        ),
      );
    }).values.toList(); // Convert the map values back to a list
  }
}

