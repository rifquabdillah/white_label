import 'package:flutter/material.dart';

import '../menuSaldo/mSaldo.dart';
import 'mSpesialDealProduct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpecialDealsPage(),
    );
  }
}

class SpecialDealsPage extends StatefulWidget {
  @override
  _SpecialDealsPageState createState() => _SpecialDealsPageState();
}

class _SpecialDealsPageState extends State<SpecialDealsPage> {
  bool _isSaldoVisible = true;
  final String saldo = '2.862.590'; // Menyimpan saldo

  // Define colors for specific titles
  Color _getColorForSubtitle(String subtitle) {
    switch (subtitle) {
      case 'Pulsa Indosat':
        return Color(0xffECB709); // Kuning
      case 'Indosat Gift 15 GB':
        return Color(0xffF57C00); // Oranye
      case 'XL':
      case 'DANA':
        return Color(0xff1976D2); // Biru
      case 'Telkomsel':
      case 'Kode':
        return Color(0xffC70000); // Merah
      case 'Tri':
        return Color(0xff353E43); // Hitam
      default:
        return Colors.grey; // Warna default
    }
  }

  // Sample data for the cards
  final List<Map<String, String>> data = [
    {'title': 'Potongan hingga 1.700', 'subtitle': 'Pulsa Indosat'},
    {'title': 'Cashback 5%', 'subtitle': 'Indosat Gift 15 GB'},
    {'title': 'Promo Telkomsel', 'subtitle': 'Telkomsel'},
    {'title': 'Promo Telkomsel', 'subtitle': 'Kode'},
    {'title': 'Promo XL', 'subtitle': 'XL'},
    {'title': 'Promo Tri', 'subtitle': 'Tri'},
    {'title': 'Promo DANA', 'subtitle': 'DANA'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfaf9f6),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildDealList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFECB709),
      title: _buildAppBarTitle(),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      toolbarHeight: 60, // Menyesuaikan tinggi AppBar
      elevation: 0, // Menghilangkan bayangan
    );
  }

  Row _buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Saldo ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFFFAF9F6),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              _isSaldoVisible ? saldo : '********',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFAF9F6),
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
                color: const Color(0xFFFAF9F6),
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
                  color: Color(0xffFAF9F6), // Warna latar belakang abu-abu
                  borderRadius: BorderRadius.circular(4), // Menambahkan sedikit lengkungan pada sudut
                ),
                child: Icon(
                  Icons.add,
                  color: Color(0xffECB709),
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFECB709),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)), // Optional: Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 8.0, // Spread radius
            offset: const Offset(0, 4), // Offset for the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'SPECIAL DEALS HARI INI',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              color: Color(0xffFAF9F6),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Bisa jadi inspirasi cuan tambahan buat kamu',
            style: TextStyle(
              color: Color(0xffFAF9F6),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  // Remove the Expanded widget
  ListView _buildDealList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Disable scrolling for the list view
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final color = _getColorForSubtitle(item['subtitle'] ?? ''); // Get color based on subtitle
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: color, // Gunakan warna dari fungsi
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: Color(0xffFAF9F6), // Tetap gunakan warna netral untuk leading
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              title: Text(
                item['title'] ?? 'No Title', // Use a default value if title is null
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFAF9F6),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                item['subtitle'] ?? 'No Subtitle', // Use a default value if subtitle is null
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  color: Color(0xffFAF9F6),
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mSpesialDealProduct()),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xffFAF9F6),
                ),
              ),

            ),
          ),
        );
      },
    );
  }
}
