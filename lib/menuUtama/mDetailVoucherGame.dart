import 'package:flutter/material.dart';

import '../menuSaldo/mSaldo.dart';

class mDetaiVoucherGame extends StatefulWidget {
  const mDetaiVoucherGame({super.key, required String gameTitle});

  @override
  mDetaiVoucherGameState createState() => mDetaiVoucherGameState();
}

class mDetaiVoucherGameState extends State<mDetaiVoucherGame> {
  int _selectedPromoIndex = 0;
  bool _isSaldoVisible = true; // Controller for phone input
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const String saldo = '2.862.590'; // Store balance

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
            TabBarWidget(
              selectedPromoIndex: _selectedPromoIndex,
              onPromoSelected: (index) {
                setState(() {
                  _selectedPromoIndex = index; // Update selected index
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
              hintText: 'ID GAME',
              hintStyle: const TextStyle(
                color: Color(0xff909EAE),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, color: Color(0xffECB709)),
                    onPressed: () {
                      // Logic to handle voice input
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.contacts, color: Color(0xffECB709)),
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

class TabBarWidget extends StatelessWidget {
  final int selectedPromoIndex;
  final ValueChanged<int> onPromoSelected;

  const TabBarWidget({
    super.key,
    required this.selectedPromoIndex,
    required this.onPromoSelected,
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
                    'Voucher Games',
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
                child: _buildPromoTab(selectedPromoIndex, onPromoSelected, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoTab(int selectedPromoIndex, ValueChanged<int> onPromoSelected, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (selectedPromoIndex == 0)
            _buildPromoGrid(context, 'Voucher Games!')
          else if (selectedPromoIndex == 1)
            _buildPromoGrid(context, 'Voucher Games'),
        ],
      ),
    );
  }

  Widget _buildPromoGrid(BuildContext context, String promoType) {
    final promoItems = [
      {
        'title': 'Promo Card 1',
        'priceCoret': 'Rp 150.000',
        'price': 'Rp 100.000',
        'detail': 'Masa aktif 30 hari'
      },
      {
        'title': 'Promo Card 2',
        'priceCoret': 'Rp 200.000',
        'price': 'Rp 150.000',
        'detail': 'Masa aktif 60 hari'
      },
      {
        'title': 'Promo Card 2',
        'priceCoret': 'Rp 200.000',
        'price': 'Rp 150.000',
        'detail': 'Masa aktif 60 hari'
      },
      {
        'title': 'Promo Card 2',
        'priceCoret': 'Rp 200.000',
        'price': 'Rp 150.000',
        'detail': 'Masa aktif 60 hari'
      },
      // Add more items as needed
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dua card dalam satu baris
        crossAxisSpacing: 8.0, // Jarak horizontal antar card
        mainAxisSpacing: 8.0, // Jarak vertikal antar card
        childAspectRatio: 3 / 2, // Rasio lebar dan tinggi (contoh lebih pendek)
      ),
      itemCount: promoItems.length,
      itemBuilder: (context, index) {
        final item = promoItems[index];
        return _buildPromoCard(
          context,
          item['title'] ?? '',
          item['price'] ?? '',
          item['detail'] ?? '',
        );
      },
    );
  }

    Widget _buildPromoCard(BuildContext context, String title, String price, String detail) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // Warna transparan untuk container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Warna bayangan
            offset: const Offset(0, 4), // Posisi bayangan
            blurRadius: 8.0, // Mengaburkan bayangan
            spreadRadius: 2.0, // Menyebarkan bayangan
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        color: const Color(0xffFAF9F6), // Warna latar belakang card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
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
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Color(0xff353E43),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    color: Color(0xffECB709),

                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff353E43),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    detail,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff909EAE),
                    ),
                  ),
                  const Icon(Icons.info, color: Color(0xffECB709), size: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
