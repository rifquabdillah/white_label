import 'package:flutter/material.dart';
import 'package:white_label/transaksipay.dart';

import '../menuSaldo/mSaldo.dart';

class mPertagasScreen extends StatefulWidget {
  const mPertagasScreen({super.key});

  @override
  _mPertagasScreenState createState() => _mPertagasScreenState();
}

class _mPertagasScreenState extends State<mPertagasScreen> {
  int _selectedPromoIndex = 0;
  bool _isSaldoVisible = true; // Controller for phone input
  final TextEditingController _phoneController = TextEditingController();

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const String saldo = '2.862.590'; // Menyimpan saldo
    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Stack(
          children: [
            AppBar(
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
                            _isSaldoVisible =
                            !_isSaldoVisible; // Toggle visibility
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
              // Menambahkan toolbarHeight untuk menyesuaikan tinggi AppBar
              toolbarHeight: 60,
              elevation: 0, // Menghilangkan bayangan
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0), // Menghilangkan padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize), // Kolom input nomor telepon
            const SizedBox(height: 0), // Spacing
            TabBarWidget(
              selectedPromoIndex: _selectedPromoIndex,
              onPromoSelected: (index) {
                setState(() {
                  _selectedPromoIndex = index; // Update indeks yang dipilih
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
          padding: const EdgeInsets.only(left: 26.0, bottom: 16.0), // Menghilangkan padding kanan
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0XFFfaf9f6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff909EAE), width: 2.0),
              ),
              hintText: 'Nomor Pertagas',
              hintStyle: const TextStyle(
                color: Color(0xff909EAE),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, color: Color(0xffECB709)),
                    onPressed: () {
                      // Tambahkan logika untuk menangani input suara di sini
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.contacts, color: Color(0xffECB709)),
                    onPressed: () {
                      // Tambahkan logika untuk membuka kontak di sini
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
              color: _phoneController.text.isEmpty ? Color(0xff909EAE) : const Color(0xFF363636),
            ),
            onChanged: (value) {
              setState(() {
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
                    'Pertagas',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xff353E43),
                    ),
                  ),
                ),
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Color(0xffECB709),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView( // Wrap the Container in SingleChildScrollView
              child: Container(
                color: const Color(0xfffdf7e6),
                child: _buildPertagasTab(selectedPromoIndex, onPromoSelected, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPertagasTab(int selectedPromoIndex, ValueChanged<int> onPromoSelected, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 6.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0), // Menambahkan padding horizontal
            child: Row(
              children: [
                _buildPromoButton('PERTAGAS', 0),
                const SizedBox(width: 5),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Show content based on the selected promo index
          if (selectedPromoIndex == 0)
            _buildPertagasCards(context) // Pass context to _buildTokenPromoCards
        ],
      ),
    );
  }

  Widget _buildPertagasCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPertagasOptionCard(context, '20.000', 'PR20 - ', '21.760', '', 'Token Pertagas', isClosed: true),
              const SizedBox(height: 10),
              _buildPertagasOptionCard(context, '100.000', 'PR100 - ', '101.765', '', 'Token Pertagas'),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPertagasOptionCard(context, '20.000', 'PP20 - ', '19.975', '20.035', 'Proses mungkin agak lambat'),
              const SizedBox(height: 10),
              _buildPertagasOptionCard(context, '20.000', 'PP20 - ', '19.975', '20.035', 'Proses mungkin agak lambat'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPertagasOptionCard(BuildContext context, String nominal, String kodeProduk, String hargaJual, String originalPrice, String info, {bool isNew = false, bool isClosed = false}) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TransaksiPay page jika tidak ditutup
        if (!isClosed) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransaksiPay(
                params: {
                  'nominal': nominal,
                  'kodeProduk': kodeProduk,
                  'hargaJual': hargaJual,
                  'description': 'Deskripsi produk di sini', // Change this as necessary
                  'originalPrice': originalPrice,
                  'info': info,
                  'transactionType': 'Pertagas',
                  'namaPemilik': 'Chandra Yadi', // New field
                  'tipeMeteran': 'RT1', // New field
                  'selectedData': {}, // New field
                },
              ),
            ),
          );
        }
      },
      child: SizedBox(
        width: 190,
        height: 100,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffECB709).withOpacity(0.2), // Warna bayangan
                    spreadRadius: 0, // Mengatur radius penyebaran
                    blurRadius: 2, // Mengatur blur
                    offset: const Offset(0, 0), // Posisi bayangan
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nominal,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isClosed ? Color(0xff353E43)  : Color(0xff353E43) , // Warna teks berubah jadi hitam jika closed
                            ),
                          ),
                          Text(
                            originalPrice,
                            style: TextStyle(
                              fontSize: 14,
                              color: isClosed ? Color(0xff353E43) : Color(0xff909EAE), // Warna teks berubah jadi hitam jika closed
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: kodeProduk,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: isClosed ? Color(0xff353E43) :  Color(0xff909EAE), // Warna teks berubah jadi hitam jika closed
                              ),
                            ),
                            TextSpan(
                              text: hargaJual,
                              style: TextStyle(
                                fontSize: 14,
                                color: isClosed ?Color(0xff353E43) : Color(0xffECB709), // Warna teks berubah jadi hitam jika closed
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        info,
                        style: TextStyle(
                          fontSize: 8,
                          color: isClosed ? Color(0xff353E43) : Color(0xff909EAE), // Warna teks berubah jadi hitam jika closed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isNew)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffC70000),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            if (isClosed)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF909EAE).withOpacity(0.7), // Overlay warna
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            if (isClosed)
              Positioned(
                bottom: 1,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xff353e43),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        onPromoSelected(index);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPromoIndex == index ? Color(0xffC70000) : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6, // Menambahkan elevasi untuk bayangan
        shadowColor: Colors.black.withOpacity(0.6), // Warna bayangan
      ),
      child: Text(
        text,
        style: TextStyle(
            color: selectedPromoIndex == index ? Colors.white : Color(0xff353E43),
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600  // Ubah warna teks jika aktif
        ),
      ),
    );
  }


}
