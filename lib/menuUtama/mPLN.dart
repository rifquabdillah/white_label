import 'package:flutter/material.dart';

import '../menuSaldo/mSaldo.dart';

// Model for BPJS item
class PlnItem {
  final String produk;
  final String description;
  final String originalPrice;
  final String info;

  PlnItem({
    required this.produk,
    required this.description,
    required this.originalPrice,
    required this.info,
  });
}

// Main BPJS screen
class mPLNScreen extends StatefulWidget {
  const mPLNScreen({super.key});

  @override
  _BpjsScreenState createState() => _BpjsScreenState();
}

class _BpjsScreenState extends State<mPLNScreen> {
  int _selectedBpjsIndex = 0; // Track selected tab index
  final TextEditingController _phoneController = TextEditingController();
  bool _isSaldoVisible = true; // Controller for balance visibility

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
                        _isSaldoVisible = !_isSaldoVisible; // Toggle visibility
                      });
                    },
                    child: Icon(
                      _isSaldoVisible ? Icons.remove_red_eye : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to SaldoPage when the add icon is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SaldoPageScreen()), // Replace with your SaldoPage
                      );
                    },
                    child: const Icon(Icons.add, color: Color(0xFFFAF9F6)),
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
          elevation: 0, // Remove shadow
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize), // Phone number input field
            const SizedBox(height: 0),
            BpjsTabBarWidget(
              selectedBpjsIndex: _selectedBpjsIndex,
              onBpjsSelected: (index) {
                setState(() {
                  _selectedBpjsIndex = index; // Update selected index
                });
              },
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
          padding: const EdgeInsets.only(left: 26.0, bottom: 16.0),
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
              hintText: 'Nomor PLN',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.orange),
                    onPressed: () {
                      // Logic to handle voice input
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.contacts, color: Colors.orange),
                    onPressed: () {
                      // Logic to open contacts
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
              color: _phoneController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}

// Tab bar widget for BPJS items
class BpjsTabBarWidget extends StatelessWidget {
  final int selectedBpjsIndex;
  final ValueChanged<int> onBpjsSelected;

  const BpjsTabBarWidget({
    super.key,
    required this.selectedBpjsIndex,
    required this.onBpjsSelected,
  });

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
            child: SingleChildScrollView(
              child: Container(
                color: const Color(0xfffdf7e6),
                child: _buildBpjsTab(selectedBpjsIndex, onBpjsSelected, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBpjsTab(int selectedBpjsIndex, ValueChanged<int> onBpjsSelected, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 6.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (selectedBpjsIndex == 0)
            _buildBpjsCards(context)
          // Add more conditions for additional tabs if needed
        ],
      ),
    );
  }

  Widget _buildBpjsCards(BuildContext context) {
    List<PlnItem> bpjsItems = _fetchBpjsItems();
    return Column(
      children: [
        for (var item in bpjsItems)
          _buildBpjsCard(context, item),
      ],
    );
  }

  Widget _buildBpjsCard(BuildContext context, PlnItem item) {
    return GestureDetector(
      onTap: () {
        // Add navigation or action for BPJS card tap
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: item.produk,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff353E43),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(item.description),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.originalPrice,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: Color(0xffECB709),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey), // Add arrow icon if needed
                ],
              ),
              const SizedBox(height: 4.0),
            ],
          ),
        ),
      ),
    );
  }

  List<PlnItem> _fetchBpjsItems() {
    return [
      PlnItem(produk: 'PLN 1', description: 'Deskripsi 1', originalPrice: '100.000', info: 'Info 1'),
      PlnItem(produk: 'PLN 2', description: 'Deskripsi 2', originalPrice: '200.000', info: 'Info 2'),
      PlnItem(produk: 'PLN 3', description: 'Deskripsi 3', originalPrice: '300.000', info: 'Info 3'),
      PlnItem(produk: 'PLN 4', description: 'Deskripsi 3', originalPrice: '300.000', info: 'Info 3'),
      PlnItem(produk: 'PLN 5', description: 'Deskripsi 3', originalPrice: '300.000', info: 'Info 3'),
      PlnItem(produk: 'PLN 6', description: 'Deskripsi 3', originalPrice: '300.000', info: 'Info 3'),
      PlnItem(produk: 'PLN 7', description: 'Deskripsi 3', originalPrice: '300.000', info: 'Info 3'),
      PlnItem(produk: 'PLN 8', description: 'Deskripsi 3', originalPrice: '300.000', info: 'Info 3'),


    ];
  }
}
