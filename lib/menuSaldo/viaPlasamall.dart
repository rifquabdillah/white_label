import 'package:flutter/material.dart';
import 'package:white_label/menuSaldo/pembayaranSaldoPlasamall.dart';
import 'PaymentHistoryScreen.dart';
import 'mSaldo.dart';

class viaPlasamallScreen extends StatefulWidget {
  const viaPlasamallScreen({super.key});

  @override
  _viaPlasamallScreenState createState() => _viaPlasamallScreenState();
}

class _viaPlasamallScreenState extends State<viaPlasamallScreen> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();
  int? _selectedRadio; // Store the selected radio button index

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.transparent,
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
                        color: const Color(0xff909EAE),
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
          ),
        ),
      ),

      body: SingleChildScrollView( // Wrap the body content in a SingleChildScrollView
        padding: const EdgeInsets.all(0), // Remove vertical and horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Space between input and new content
            _buildNewContent(),
            const SizedBox(height: 16),
            _buildDepositField(),
            const SizedBox(height: 60),
            _buildButtonKodeBayar(context),

          ],
        ),
      ),
    );
  }

  Widget _buildNewContent() {
    return Padding(
      padding: const EdgeInsets.all(16), // Add some padding around the content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Silakan pilih gerai yang akan dituju:',
            style: TextStyle(
              fontSize: 16, // Customize the font size
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: Color(0xff353E43), // Customize text color
            ),
          ),
          const SizedBox(height: 16), // Space between text and radio buttons
          // Radio Button 1
          Row(
            children: [
              const SizedBox(width: 8), // Space before the image
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRadio = 1; // Set the selected radio button index
                    });
                  },
                  child: Container(
                    height: 100, // Set your desired height
                    decoration: BoxDecoration(
                      color: const Color(0xffFAF9F6), // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between image and radio button
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0), // Set your desired padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/alfaaa.png', height: 50), // Replace with your image path
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Radio<int>(
                            value: 1, // Unique value for Radio Button 1
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value;
                              });
                            },
                            activeColor: const Color(0xff198754), // Radio button color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 8), // Space before the image
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRadio = 2; // Set the selected radio button index
                    });
                  },
                  child: Container(
                    height: 100, // Set your desired height
                    decoration: BoxDecoration(
                      color: const Color(0xffFAF9F6), // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between image and radio button
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0), // Set your desired padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/indomaret.png', height: 85), // Replace with your image path
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Radio<int>(
                            value: 2, // Unique value for Radio Button 2
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value;
                              });
                            },
                            activeColor: const Color(0xff198754), // Radio button color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildDepositField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label for the first TextField
        Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: const Text(
            'Nominal Deposit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF353E43),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFDF7E6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: 'Nominal Deposit',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: _phoneController.text.isEmpty ? FontWeight.normal : FontWeight.w600,
              color: _phoneController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
            ),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: const Text(
            'Konfirmasi nomor HP:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF353E43),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFDF7E6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: 'Nomor HP Terdaftar',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF363636),
            ),
          ),
        ),
        const SizedBox(height: 25),
        // Text with bolded "PLASAMALL / WIN SOLUTION"
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: RichText(
            text: TextSpan(
              text: 'Deposit via Gerai Alfamart dan Indomaret menggunakan jalur ',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontFamily: 'Poppins',
                color: Color(0xFF353E43),
              ),
              children: [
                TextSpan(
                  text: 'PLASAMALL / WIN SOLUTION',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Color(0xFF353E43),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildPaymentHistoryCard(), // New card widget
      ],
    );
  }

  Widget _buildPaymentHistoryCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 16.0, top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        color: const Color(0xffFAF9F6),
        child: InkWell(
          onTap: () {
            // Navigate to the Payment History Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentHistoryScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lihat Riwayat Kode Bayar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff909EAE),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Color(0xff909EAE),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonKodeBayar(BuildContext context) => Center(
    child: SizedBox(
      width: 355,
      height: 35,
      child: ElevatedButton(
        onPressed: () {
          // Determine the store name based on the selected radio button
          String storeName = _selectedRadio == 1 ? 'Alfamart' : 'Indomaret';
          // Navigate to PembayaranSaldo with the selected store name
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PembayaranSaldoPlasamall(storeName: storeName),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffecb709),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Request Tiket',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
