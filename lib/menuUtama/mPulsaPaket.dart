import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:white_label/transaksipay.dart';
import '../menuSaldo/mSaldo.dart';

class PulsaPaketScreen extends StatefulWidget {
  const PulsaPaketScreen({super.key});

  @override
  _PulsaPaketScreenState createState() => _PulsaPaketScreenState();
}

class _PulsaPaketScreenState extends State<PulsaPaketScreen> {
  int _selectedPromoIndex = 0;
  final TextEditingController _phoneController = TextEditingController();
  bool _isSaldoVisible = true;
  String? _provider; // Tambahkan variabel untuk menyimpan nama provider


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
                      // Navigate to SaldoPage when the add icon is tapped
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneNumberField(screenSize),
            const SizedBox(height: 8.0), // Beri jarak
            if (_provider != null) // Tampilkan provider jika ada
              Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Text(
                  ' $_provider',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Color(0xff909EAE),
                  ),
                ),
              ),
            const SizedBox(height: 8.0), // Beri jarak
            // Selalu tampilkan TabBarWidget, tapi kontennya bergantung pada nomor ponsel
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
                provider: _provider, // Tambahkan provider
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
                // Cek 3 digit pertama untuk menentukan provider
                if (value.length >= 3) {
                  String prefix = value.substring(0, 3);
                  switch (prefix) {
                    case '085':
                      _provider = 'INDOSAT';
                      break;
                    case '081':
                      _provider = 'TELKOMSEL';
                      break;
                    case '087':
                      _provider = 'XL';
                      break;
                    case '088':
                    case '082':
                      _provider = 'SMARTFREN';
                      break;
                    case '089':
                      _provider = 'TRI';
                      break;
                    case '083':
                      _provider = 'AXIS';
                      break;
                    default:
                      _provider = null; // Jika tidak cocok
                      break;
                  }
                } else {
                  _provider = null; // Reset provider jika input kurang dari 3 karakter
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
  final String? provider;

  const TabBarWidget({
    super.key,
    required this.selectedPromoIndex,
    required this.onPromoSelected,
    required this.tabTitles,
    required this.isPhoneNumberEmpty,
    required this.provider, // Terima provider
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
                    _buildPulsaTabContent(selectedPromoIndex, onPromoSelected, context, provider),
                    _buildSmsTelponTabContent(selectedPromoIndex, onPromoSelected),
                    _buildInternetTabContent(selectedPromoIndex, onPromoSelected),
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

  Widget _buildPulsaTabContent(int selectedPromoIndex, ValueChanged<int> onPromoSelected, BuildContext context, String? provider) {
    // Daftar tombol promosi berdasarkan provider
    List<String> menuButtons = [];

    if (provider == 'INDOSAT') {
      menuButtons = ['PROMO!', 'Nasional', 'Masa Aktif','Bonus+'];
    } else if (provider == 'TELKOMSEL') {
      menuButtons = ['Paketan', 'Internet', 'Nelpon'];
    } else if (provider == 'XL') {
      menuButtons = ['Paket XL', 'Internet', 'Paket Nelpon'];
    } else if (provider == 'SMARTFREN') {
      menuButtons = ['Paket Smartfren', 'Masa Aktif', 'Promo'];
    } else if (provider == 'TRI') {
      menuButtons = ['Paket 3', 'Internet', 'Nelpon'];
    } else if (provider == 'AXIS') {
      menuButtons = ['Paket AXIS', 'Internet', 'Promo'];
    } else {
      return Center(
        child: Text(
          'Provider tidak dikenali',
          style: TextStyle(color: Color(0xff909EAE)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Menambahkan SingleChildScrollView untuk scroll horizontal
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: menuButtons.asMap().entries.map((entry) {
                int index = entry.key;
                String text = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildPromoButton(text, selectedPromoIndex == index, () {
                    onPromoSelected(index);
                  }),
                );
              }).toList(),
            ),
          ),
          // Konten tambahan berdasarkan provider
          if (provider == 'INDOSAT') ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Tambahkan widget konten tambahan jika diperlukan
              ],
            ),
            const SizedBox(height: 10),
            // Menampilkan konten sesuai dengan tombol yang dipilih
            if (selectedPromoIndex == 0) _buildPulsaCards(context),
            if (selectedPromoIndex == 1) _buildNasionalContent(context),
          ],
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
                _buildPaketCard(context, '15.000', 'IP15 -', '14.720', '14.980', 'Tidak menambah masa aktif', isNew: false),
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
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            originalPrice,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff909EAE),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xff909EAE)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: kodeproduk,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff353E43)),
                            ),
                            TextSpan(
                              text: hargaJual,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Color(0xffECB709),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        info,
                        style: const TextStyle(
                          fontSize: 9,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff909EAE),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isNew)
              Positioned(
                bottom: 3,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
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
                _buildNasionalCard(context,'25.000', 'IP25 -',' 24.750', 'Masa Aktif +3 Hari', isNew: true),
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

  Widget _buildNasionalCard(BuildContext context, String nominal, String kodeproduk, String hargaJual, String info, {bool isNew = false}) {
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
                elevation: 0, // Elevasi kartu diset ke 0 karena bayangan diatur oleh BoxShadow
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
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: kodeproduk,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: Color(0xff353E43),
                              ),
                            ),
                            TextSpan(
                              text: hargaJual,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Color(0xffECB709),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        info,
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff909EAE),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Menambahkan tanda NEW jika isNew adalah true
            if (isNew)
              Positioned(
                bottom: 4.0,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xffC70000) : const Color(0xffFAF9F6),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2, // Menambahkan elevasi untuk bayangan
        shadowColor: Colors.black.withOpacity(0.6), // Warna bayangan
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xff353E43),
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          fontSize: 13, // Ukuran teks yang disesuaikan
        ),
      ),
    );
  }

  Widget _buildSmsTelponTabContent(int selectedPromoIndex,
      ValueChanged<int> onPromoSelected) {
    // Daftar tombol promosi berdasarkan provider
    List<String> menuButtons = [];

    if (provider == 'INDOSAT') {
      menuButtons = ['Nelpon!', 'SMS'];
    } else if (provider == 'TELKOMSEL') {
      menuButtons = ['FLASH SALE', 'Nelpon', 'SMS'];
    } else if (provider == 'XL') {
      menuButtons = ['Double Bonus', 'Nelpon', 'Sms'];
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Ubah menjadi start
            children: menuButtons
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              String text = entry.value;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0), // Menambah sedikit ruang antara tombol
                child: _buildMenuButton(text, selectedPromoIndex == index, () {
                  onPromoSelected(index);
                }),
              );
            }).toList(),
          ),
          // Konten tambahan berdasarkan provider
          if (provider == 'INDOSAT') ...[
            const SizedBox(height: 10), // Jarak sebelum konten nasional
            // Menampilkan konten sesuai dengan tombol yang dipilih
            if (selectedPromoIndex == 0) _buildNelponContent(),
            if (selectedPromoIndex == 1) _buildSmsContent(),
          ],
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
                    'Unlimited Nelpon+',
                    '/1 Hari',
                    'ITLP1',
                    '+3 Poin',
                    '3.900',
                    '3.276',
                    'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketNelponCard(
                    'Unlimited Nelpon+',
                    '/1 Hari',
                    'ITLP1',
                    '+3 Poin',
                    '',
                    '3.276',
                    'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain',
                    isNew: true),
                const SizedBox(height: 10),
                _buildPaketNelponCard(
                    'Unlimited Nelpon+',
                    '/1 Hari',
                    'ITLP1',
                    '+3 Poin',
                    '',
                    '3.276',
                    'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain',
                    isClosed: true),
                const SizedBox(height: 10),
                _buildPaketNelponCard(
                    'Unlimited Nelpon+',
                    '/1 Hari',
                    'ITLP1',
                    '+3 Poin',
                    '',
                    '3.276',
                    'Unlimited nelpon ke IM3 dan Tri, 10 Menit ke Operator Lain'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaketNelponCard(String paket, String hari, String kodeproduk, String poin, String originalPrice, String newPrice, String info, {bool isNew = false, bool isClosed = false}) {
    Color textColor = isClosed ? const Color(0xFF353E43) : Color(0xff353E43);
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
                  color: Color(0xffECB709).withOpacity(0.2), // Shadow color with opacity
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // Position of shadow
                ),
              ],
            ),
            child: Card(
              elevation: isClosed ? 0 : 0, // Reduce elevation if closed
              shadowColor: Color(0xffECB709).withOpacity(0.8),
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
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: hari,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff353E43),
                                          fontWeight: FontWeight.w200,
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
                                            fontFamily: 'Poppins',
                                            color: Color(0xff353E43),
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      TextSpan(
                                        text: poin,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff353E43),
                                          fontWeight: FontWeight.w600,
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
                                      color: Color(0xff909EAE),
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Color(0xff909EAE)
                                  ),
                                ),
                                Text(
                                  newPrice,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: isClosed
                                        ? textColor.withOpacity(0.5)
                                        : Color(0xffECB709),
                                    fontWeight: FontWeight.w700,
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
                              color: Color(0xff909EAE),
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins'
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
                          color: const Color(0xFF909EAE).withOpacity(0.8), // Overlay warna
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
                          color: const Color(0xff353E43),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
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

  Widget _buildSmsContent() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPaketSMSCard(
                    '400 SMS ', ' / 7 Hari', 'SMS5  +3 Poin', '5.310',
                    '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketSMSCard(
                    '400 SMS ', ' / 7 Hari', 'SMS5  +3 Poin', '5.310',
                    '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketSMSCard(
                    '400 SMS ', ' / 7 Hari', 'SMS5  +3 Poin', '5.310',
                    '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
                const SizedBox(height: 10),
                _buildPaketSMSCard(
                    '400 SMS ', ' / 7 Hari', 'SMS5  +3 Poin', '5.310',
                    '300 SMS ke Sesama Indosat, 100 SMS ke Operator Lain'),
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
      height: 100,
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
                                style: const TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff353E43)),
                              ),
                              TextSpan(
                                text: hari,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff353E43),
                                  fontWeight: FontWeight.w300, // Regular text
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
                                style: const TextStyle(color: Color(0xff353E43),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                              const TextSpan(
                                text: '\n', // Newline
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: info,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff909EAE),
                                  fontWeight: FontWeight.w300, // Make sure this is not bold
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
    );
  }

  Widget _buildMenuButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xffC70000) : const Color(0xffFAF9F6),
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
          color: isSelected ? Colors.white : const Color(0xff353E43),
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          fontSize: 13, // Ukuran teks yang disesuaikan
        ),
      ),
    );
  }
  }

Widget _buildInternetTabContent(int selectedPromoIndex, ValueChanged<int> onPromoSelected) {
  // Similar to _buildPulsaTabContent but with different promo buttons for Internet
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        _buildInternetCard()
      ],
    ),
  );
}

const platform = MethodChannel('com.example.white_label/native');

Future<List<Map<String, dynamic>>> _fetchDataFromNative() async {
  try {
    final List<dynamic> result = await platform.invokeMethod('_buildInternetTabContent');
    print('Data received from native: $result'); // Print the raw data from the native call

    // Convert each item in the list to Map<String, dynamic>
    return result.map((item) {
      return Map<String, dynamic>.from(item as Map); // Explicit cast
    }).toList();
  } on PlatformException catch (e) {
    print('Failed to get data: ${e.message}'); // Print the error
    throw 'Failed to get data: ${e.message}'; // Handle error
  }
}

Widget _buildInternetCard() {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: _fetchDataFromNative(), // Call the native method
    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Loading indicator
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // Handle error
      } else {
        final products = snapshot.data ?? [];
        print('Data displayed in widget: $products'); // Print the data before displaying

        return SizedBox(
          width: 400,
          height: 600.0, // Set height constraint for the scroll area
          child: SingleChildScrollView(
            child: Column(
              children: products.map((product) {
                return _buildProductCard(
                  context, // Pass context here
                  product['namaProduk'] ?? 'N/A',
                  product['masaAktif'] ?? 'N/A',
                  product['kodeProduk'] ?? 'N/A',
                  product['hargaJual'] ?? 'N/A',
                  product['detailProduk'] ?? 'N/A',
                );
              }).toList(),
            ),
          ),
        );

      }
    },
  );
}

Widget _buildProductCard(BuildContext context,String namaProduk, String masaAktif, String kodeProduk, String hargaJual, String detailProduk) {
  return GestureDetector(
    onTap: () {
      // Navigasi ke halaman TransaksiPay
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransaksiPay(
            nominal: hargaJual,
            kodeproduk: kodeProduk,
            hargaJual: hargaJual,
            description: 'Deskripsi produk di sini', // Sesuaikan deskripsi ini
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
        height: 125,
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
                                    fontSize: 20, // Same font size as namaProduk for consistency
                                    color: Color(0xff909EAE), // Same color as namaProduk
                                  ),
                                ),
                                TextSpan(
                                  text: '$masaAktif Hari', // Append " hari" to masaAktif
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff353E43),
                                    fontWeight: FontWeight.w100, // Regular text
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5), // Space between name and code/info
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
                                // Space between code and info
                              ],
                            ),
                          ),
                          const SizedBox(height: 5), // Space between name and code/info
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
                                // Space between code and info
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
                          hargaJual,
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
