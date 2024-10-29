import 'package:flutter/material.dart';

import '../menuSaldo/mSaldo.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
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
              hintText: 'Nomor Telepon',
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
                    'Promo',
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
      padding: const EdgeInsets.only(top: 6.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (selectedPromoIndex == 0)
            _buildPromoCards(context, 'Promo!')
          else if (selectedPromoIndex == 1)
            _buildPromoCards(context, 'Voucher Games'),
        ],
      ),
    );
  }

  Widget _buildPromoCards(BuildContext context, String promoType) {
    return Column(
      children: [
        _buildPromoCard(context, 'Promo Card 1', promoType),
        const SizedBox(height: 10),
        _buildPromoCard(context, 'Promo Card 2', promoType),
      ],
    );
  }

  Widget _buildPromoCard(BuildContext context, String title, String promoType) {
    return GestureDetector(
      onTap: () {
        // Add navigation or action for promo card tap

      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title),
        ),
      ),
    );
  }

}

