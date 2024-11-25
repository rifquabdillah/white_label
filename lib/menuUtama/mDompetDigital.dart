import 'package:flutter/material.dart';
import 'package:white_label/backend/nativeChannel.dart';
import 'package:white_label/menuUtama/mDetailDompetDigital.dart';
import '../menuSaldo/mSaldo.dart';
import 'mDetailVoucherGame.dart';
import 'package:white_label/backend/produk.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class mDompetDigital extends StatefulWidget {
  @override
  mDompetDigitalScreenState createState() => mDompetDigitalScreenState();
}

class mDompetDigitalScreenState extends State<mDompetDigital> {
  bool _isSaldoVisible = true;
  late PageController _pageController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
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
                      _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons
                          .visibility_off,
                      color: const Color(0xff909EAE),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaldoPageScreen()),
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
        ),
      ),
      body: Column(
        children: [
          _buildSearchGameField(screenSize),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0.0),
                    const SizedBox(height: 0.0),
                    _buildGridOptions(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchGameField(Size screenSize) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAF9F6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0XFFfaf9f6),
                    border: InputBorder.none,
                    hintText: 'Cari Dompet Digital',
                    hintStyle: const TextStyle(
                      color: Color(0xff909EAE),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Implement search action
                },
                icon: const Icon(Icons.search_rounded),
                color: const Color(0xff353E43),
                iconSize: 28.0,
                splashRadius: 20.0,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 2.0,
            color: Color(0xff353E43),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future<String> _getImage(String key, String index, String tipe) async {
    var result = await NativeChannel.instance.fetchAndSaveImage(key, index, tipe);
    return result;
  }


  Future<Map<String, List<Map<String, dynamic>>>> _fetchData() async {
    var produkInstance = Produk();
    var result = await produkInstance.fetchProduk(
        '',
        'EMONEY',
        ''
    );

    return result;
  }

  Widget _buildGridOptions() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading data"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No data available"));
        }

        final data = snapshot.data!;
        final keys = data.keys.toList();

        // Fetch images for each key and index
        for (var i = 0; i < keys.length; i++) {
          print('Index: $i, Key: ${keys[i]}');
          _getImage(keys[i], i.toString(), 'emoney');
        }

        return Container(
          color: const Color(0xFFfdf7e6),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GridView.builder(
            itemCount: keys.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              final key = keys[index];
              final imagePath = '/data/user/0/com.example.whitelabel/files/assets/$index-emoney.jpg';
              final voucherData = data[key]; // Extract relevant voucher data
              return _buildGridItem(key, imagePath, voucherData);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        );
      },
    );
  }


  Widget _buildGridItem(String title, String imagePath, List<Map<String, dynamic>> voucherData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mDetailDompetDigital(
              gameTitle: title,
              voucherData: voucherData,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: const Color(0xffFDF7E6),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.file(
                    File(imagePath),
                    // Use Image.file to load from internal storage
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                            Icons.broken_image, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xff353E43).withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 37,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
