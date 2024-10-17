import 'package:flutter/material.dart';
import 'package:white_label/transaksipay.dart';

class PulsaPaketScreen extends StatefulWidget {
  const PulsaPaketScreen({super.key});

  @override
  _PulsaPaketScreenState createState() => _PulsaPaketScreenState();
}

class _PulsaPaketScreenState extends State<PulsaPaketScreen> {
  int _selectedPromoIndex = 0;
  final TextEditingController _phoneController = TextEditingController();
  bool _isSaldoVisible = true;

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
            const SizedBox(height: 0), // Remove if not necessary
            // Wrap TabBarWidget with Expanded
            if (_phoneController.text.isNotEmpty)
              Expanded(
                child: TabBarWidget(
                  selectedPromoIndex: _selectedPromoIndex,
                  onPromoSelected: (index) {
                    setState(() {
                      _selectedPromoIndex = index;
                    });
                  },
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
              fontWeight: _phoneController.text.isEmpty ? FontWeight.normal : FontWeight.w600,
              color: _phoneController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
            ),
            onChanged: (value) {
              setState(() {
// Show/hide TabBar content based on input
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
    return DefaultTabController(
      length: 3, // Change this to match your tabs count
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Change to min to avoid extra space
          children: [
            const SizedBox(
              width: double.infinity,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.orange,
                tabs: [
                  Tab(text: 'Pulsa'),
                  Tab(text: 'SMS/Nelpon'),
                  Tab(text: 'Internet'),
                ],
              ),
            ),
            Expanded( // Use Expanded instead of fixed height SizedBox
              child: Container(
                color: const Color(0xfffdf7e6),
                child: TabBarView(
                  children: [
                    _buildPulsaTabContent(
                        selectedPromoIndex, onPromoSelected, context),
                    _buildSmsTelponTabContent(
                        selectedPromoIndex, onPromoSelected),
                    _buildInternetTabContent(
                        selectedPromoIndex, onPromoSelected),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildPulsaTabContent(int selectedPromoIndex, ValueChanged<int> onPromoSelected, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 6.0, left: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildPromoButton('PROMO!', 0),
              const SizedBox(width: 5),
              _buildPromoButton('Nasional', 1),
              const SizedBox(width: 5),
              _buildPromoButton('Masa Aktif', 2),
            ],
          ),
          const SizedBox(height: 20),
          // Show content based on the selected promo index
          if (selectedPromoIndex == 0)
            _buildPulsaCards(context) // Pass context to _buildPulsaCards
          else if (selectedPromoIndex == 1)
            _buildNasionalContent(context) // Call the method for Nasional button content
          else if (selectedPromoIndex == 2)
              _buildPromoCards('Masa Aktif', 'Paket dengan masa aktif panjang!', ['Paket E', 'Paket F']),
        ],
      ),
    );
  }

  Widget _buildPulsaCards(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPaketCard(context, '5.000', 'IP5 - ', '5.280', '5.310', 'Tidak menambah masa aktif'),
                const SizedBox(height: 10),
                _buildPaketCard(context, '15.000', 'IP15 -', '14.720', '14.980', 'Tidak menambah masa aktif', isNew: true),
                const SizedBox(height: 10),
                _buildPaketCard(context, '25.000', 'IP25 -', '24.750', '24.904', 'Tidak menambah masa aktif'),
                const SizedBox(height: 10),
                _buildPaketCard(context, '35.000', 'IP35 -', '34.710', '35.710', 'Tidak menambah masa aktif'),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPaketCard(context, '10.000', 'IP10 -', '10.225', '10.310', 'Tidak menambah masa aktif'),
                const SizedBox(height: 10),
                _buildPaketCard(context, '20.000', 'IP20 -', '19.740', '19.900', 'Tidak menambah masa aktif'),
                const SizedBox(height: 10),
                _buildPaketCard(context, '30.000', 'IP30 -', '29.120', '29.220', 'Tidak menambah masa aktif'),
                const SizedBox(height: 10),
                _buildPaketCard(context, '40.000', 'IP40 -', '39.920', '40.120', 'Tidak menambah masa aktif'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaketCard(BuildContext context, String nominal, String kodeproduk, String hargaJual, String originalPrice, String info, {bool isNew = false}) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman TransaksiPay
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransaksiPay(
              nominal: nominal,
              kodeproduk: kodeproduk,
              hargaJual: hargaJual,
              description: 'Deskripsi produk di sini', // Sesuaikan deskripsi ini
              originalPrice: originalPrice,
              info: info,
              transactionType: 'Pulsa',
            ),
          ),
        );
      },
      child: SizedBox(
        width: 190,
        height: 100,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // Warna latar belakang kartu
                borderRadius: BorderRadius.circular(12), // Sudut membulat pada kartu
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2), // Warna bayangan dengan opasitas
                    spreadRadius: 0, // Spread radius untuk ukuran bayangan
                    blurRadius: 3, // Blur radius untuk kelembutan bayangan
                    offset: const Offset(0, 0), // Offset untuk posisi bayangan
                  ),
                ],
              ),
              child: Card(
                elevation:0, // Elevasi kartu diset ke 0 karena bayangan diatur oleh BoxShadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Sudut membulat
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            originalPrice,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
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
                              text: kodeproduk,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            TextSpan(
                              text: hargaJual,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        info,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
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
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
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
        backgroundColor: selectedPromoIndex == index ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6, // Menambahkan elevasi untuk bayangan
        shadowColor: Colors.black.withOpacity(0.6), // Warna bayangan
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedPromoIndex == index ? Colors.white : Colors.black, fontWeight: FontWeight.w600,// Ubah warna teks jika aktif
        ),
      ),
    );
  }

  Widget _buildPromoCards(String title, String subtitle, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            ...items.map((item) => Text(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildNasionalContent(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNasionalCard(context,'5.000', 'IP5 -',' 5.280', 'Masa Aktif +3 Hari'),
                const SizedBox(height: 10),
                _buildNasionalCard(context,'15.000', 'IP15 -',' 14.720', 'Masa Aktif +3 Hari'),
                const SizedBox(height: 10),
                _buildNasionalCard(context,'25.000', 'IP25 -',' 24.750', 'Masa Aktif +3 Hari'),
                const SizedBox(height: 10),
                _buildNasionalCard(context,'35.000', 'IP35 -',' 34.710', 'Masa Aktif +3 Hari'),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNasionalCard(context,'10.000', 'IP10 -',' 10.225','Masa Aktif +3 Hari'),
                const SizedBox(height: 10),
                _buildNasionalCard(context,'20.000', 'IP20 -',' 19.740','Masa Aktif +3 Hari'),
                const SizedBox(height: 10),
                _buildNasionalCard(context,'30.000', 'IP30 -',' 29.120', 'Masa Aktif +3 Hari'),
                const SizedBox(height: 10),
                _buildNasionalCard(context,'40.000', 'IP40 -',' 39.920','Masa Aktif +3 Hari'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNasionalCard(BuildContext context, String nominal, String kodeproduk, String hargaJual, String info) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TransaksiPay page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransaksiPay(
              nominal: nominal,
              kodeproduk: kodeproduk,
              hargaJual: hargaJual,
              description: 'Deskripsi produk di sini', // You can change this to the relevant description
              originalPrice: 'Rp 100.000', // Add the original price or pass as needed
              info: info,
              transactionType: 'Pulsa',
            ),
          ),
        );
      },
      child: SizedBox(
        width: 190,
        height: 100,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // Warna latar belakang kartu
                borderRadius: BorderRadius.circular(12), // Sudut membulat pada kartu
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2), // Warna bayangan dengan opasitas
                    spreadRadius: 0, // Spread radius untuk ukuran bayangan
                    blurRadius: 3, // Blur radius untuk kelembutan bayangan
                    offset: const Offset(0, 0), // Offset untuk posisi bayangan
                  ),
                ],
              ),
              child: Card(
                elevation:0, // Elevasi kartu diset ke 0 karena bayangan diatur oleh BoxShadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Sudut membulat
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: kodeproduk,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            TextSpan(
                              text: hargaJual,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        info,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmsTelponTabContent(int selectedPromoIndex, ValueChanged<int> onPromoSelected) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildNelponButton('Nelpon', 0),
              const SizedBox(width: 5),
              _buildSmsButton('SMS', 1),
            ],
          ),
          const SizedBox(height: 20),
          // Show content based on the selected promo index
          if (selectedPromoIndex == 0)
            _buildNelponContent()
          else if (selectedPromoIndex == 1)
            _buildSmsContent() // Call the method for Nasional button content
        ],
      ),
    );
  }

  Widget _buildNelponContent() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPaketNelponCard(
                    'Unlimited Nelpon+', '/1 Hari', 'ITLP1', '+3 Poin', '3.900', '3.276', 'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketNelponCard(
                    'Unlimited Nelpon+', '/1 Hari', 'ITLP1', '+3 Poin', '', '3.276', 'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain', isNew: true),
                const SizedBox(height: 10),
                _buildPaketNelponCard(
                    'Unlimited Nelpon+', '/1 Hari', 'ITLP1', '+3 Poin', '', '3.276', 'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain', isClosed: true),
                const SizedBox(height: 10),
                _buildPaketNelponCard(
                    'Unlimited Nelpon+', '/1 Hari', 'ITLP1', '+3 Poin', '', '3.276', 'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaketNelponCard(String paket, String hari, String kodeproduk, String poin, String originalPrice, String newPrice, String info, {bool isNew = false, bool isClosed = false}) {
    Color textColor = isClosed ? const Color(0xFF353E43) : Colors.black;
    return SizedBox(
      width: 400,
      height: 105,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2), // Shadow color with opacity
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // Position of shadow
                ),
              ],
            ),
            child: Card(
              elevation: isClosed ? 0 : 0, // Reduce elevation if closed
              shadowColor: Colors.orangeAccent.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Paket dan Hari digabung dalam satu baris menggunakan RichText
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: paket,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: hari,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: textColor.withOpacity(0.7),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: kodeproduk,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: textColor.withOpacity(0.6),
                                        ),
                                      ),
                                      TextSpan(
                                        text: poin,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: textColor.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  originalPrice,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: textColor.withOpacity(0.5),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  newPrice,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isClosed
                                        ? textColor.withOpacity(0.5)
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          info,
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isNew)
                    Positioned(
                      top: 75,
                      right: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'New',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
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
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
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

  Widget _buildNelponButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        onPromoSelected(index);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPromoIndex == index ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6, // Menambahkan elevasi untuk bayangan
        shadowColor: Colors.black.withOpacity(0.6), // Warna bayangan
      ),
      child: Text(
        text,
        style: TextStyle(
            color: selectedPromoIndex == index ? Colors.white : Colors.black, fontWeight: FontWeight.w600  // Ubah warna teks jika aktif
        ),
      ),
    );
  }

  Widget _buildSmsContent() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPaketSMSCard ('400 SMS ',' / 7 Hari', 'SMS5  +3 Poin', '5.310', '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketSMSCard('400 SMS ',' / 7 Hari', 'SMS5  +3 Poin', '5.310', '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketSMSCard('400 SMS ',' / 7 Hari', 'SMS5  +3 Poin', '5.310', '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketSMSCard('400 SMS ',' / 7 Hari', 'SMS5  +3 Poin', '5.310', '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaketSMSCard(String produk, String hari, String description, String originalPrice, String info) {
    return SizedBox(
      width: 400,
      height: 95,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2), // Shadow color with opacity
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // Position of shadow
                ),
              ],
            ),
          ),
          Card(
            elevation: 0, // Higher elevation for neon effect
            shadowColor: Colors.orange.shade400, // Orange shadow with opacity
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
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
                                text: produk,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              TextSpan(
                                text: hari,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal, // Regular text
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: description,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const TextSpan(
                                text: '\n', // Newline
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: info,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal, // Make sure this is not bold
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
                    mainAxisAlignment: MainAxisAlignment.center, // Vertically centered
                    crossAxisAlignment: CrossAxisAlignment.end, // Align price to the right
                    children: [
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildSmsButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        onPromoSelected(index);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPromoIndex == index ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6, // Menambahkan elevasi untuk bayangan
        shadowColor: Colors.black.withOpacity(0.3), // Warna bayangan
      ),
      child: Text(
        text,
        style: TextStyle(
            color: selectedPromoIndex == index ? Colors.white : Colors.black, fontWeight: FontWeight.w400 // Ubah warna teks jika aktif
        ),
      ),
    );
  }

  Widget _buildInternetTabContent(int selectedPromoIndex, ValueChanged<int> onPromoSelected) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildInternetButton('Freedom', 0, selectedPromoIndex, onPromoSelected),
              const SizedBox(width: 5),
              _buildInternetButton('Combo', 1, selectedPromoIndex, onPromoSelected),
            ],
          ),
          const SizedBox(height: 20),
          // Show content based on the selected promo index
          if (selectedPromoIndex == 0)
            _buildFreedomContent()
          else if (selectedPromoIndex == 1)
            _buildComboContent() // Call the method for Combo button content
        ],
      ),
    );
  }

  Widget _buildFreedomContent() {
    return Expanded(
      child: SingleChildScrollView( // Tambahkan SingleChildScrollView untuk scroll
        child: Column(
          children: [
            _buildPaketInternetCard(
                '1 GB ', '/30 Hari', 'IF1G', '', '10.000', 'Kuota full tanpa pembagian'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '2 GB ', '/30 Hari', 'IF1', '', '16.400', 'Kuota full tanpa pembagian'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '3 GB', '/30 Hari', 'IF2', '+3 Poin', '19.850', 'Kuota full tanpa pembagian'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '4 GB ', '/30 Hari', 'IF4', '', '26.900', 'Kuota full tanpa pembagian'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '5.5 GB ', '/30 Hari', 'IF5', '', '30.950', 'Kuota full tanpa pembagian'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '7 GB ', '/30 Hari', 'IF7', '', '34.650', 'Kuota full tanpa pembagian'),
          ],
        ),
      ),
    );
  }

  Widget _buildComboContent() {
    return Expanded(
      child: SingleChildScrollView( // Tambahkan SingleChildScrollView agar bisa di-scroll
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildPaketInternetCard(
                '6 GB + Nelpon', '/30 Hari', 'IFC6', '', '33.750',
                '4 GB Utama, 2GB Malam, 5000 Menit Nelpon Sesama, 5 Menit Nelpon Operator Lain'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '10 GB + Nelpon', '/30 Hari', 'IFC10', '', '45.650',
                '7 GB Utama, 3 GB Malam, 5000 Menit Nelpon Sesama, 10 Menit Nelpon Operator Lain'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '12 GB', '/30 Hari', 'IDM', '+3 Poin', '65.575',
                '2 GB Utama, Pembagian kuota lihat detail produk'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '20 GB + Nelpon', '/30 Hari', 'IFC20', '', '70.971',
                '15 GB Utama, 5 GB Malam, 5000 Menit Nelpon Sesama, 20 Menit Nelpon Operator Lain'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '30 GB + Nelpon', '/30 Hari', 'IFC30', '', '91.874',
                '23 GB Utama, 7 GB Malam, 5000 Menit Nelpon Sesama, 20 Menit Nelpon Operator Lain'),
            const SizedBox(height: 10),
            _buildPaketInternetCard(
                '30 GB + Nelpon', '/30 Hari', 'IDL', '', '70.971',
                '23 GB Utama, 5 GB Malam, Unlimited Nelpon Sesama'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaketInternetCard(String paket, String hari, String kodeproduk, String poin, String price, String info, {bool isNew = false, bool isClosed = false}) {
    Color textColor = isClosed ? const Color(0xFF353E43) : Colors.black;
    return SizedBox(
      width: 400,
      height: 105,
      child: Stack(
        children: [
          // Shadow and rounded corners container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2), // Shadow color with opacity
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // Position of shadow
                ),
              ],
            ),
          ),
          // Main card content
          Card(
            elevation: isClosed ? 0 : 0,
            shadowColor: Colors.orangeAccent.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(  // Ubah ke Row untuk distribusi vertikal lebih fleksibel
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: paket,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: hari,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: textColor.withOpacity(0.7),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: kodeproduk,
                                    style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.6)),
                                  ),
                                  if (poin.isNotEmpty)
                                    TextSpan(
                                      text: poin,
                                      style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.8), fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info,
                              style: TextStyle(fontSize: 8, color: textColor.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                      // Spacer untuk mendorong harga ke kanan dan ditengah secara vertikal
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Vertikal tengah
                        crossAxisAlignment: CrossAxisAlignment.end,  // Di kanan
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 18,
                              color: isClosed ? textColor.withOpacity(0.5) : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isNew)
                  Positioned(
                    top: 78,
                    right: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                if (isClosed)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF909EAE).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternetButton(String text, int index, int selectedPromoIndex, ValueChanged<int> onPromoSelected) {
    return ElevatedButton(
      onPressed: () {
        onPromoSelected(index);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPromoIndex == index ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedPromoIndex == index ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }



}