import 'package:flutter/material.dart';
import 'package:white_label/menuSaldo/pembayaranSaldoPlasamall.dart';
import 'mSaldo.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();

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

      body: SingleChildScrollView( // Wrap the body content in a SingleChildScrollView
        padding: const EdgeInsets.all(0), // Remove vertical and horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Space between input and new content
            _buildNewContent(),
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
          // Text header for payment history
          const Text(
            'Riwayat Kode Bayar Gerai',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color(0xff353E43),
            ),
          ),
          const SizedBox(height: 16), // Space between the header and content

          // Card for Alfamart
          GestureDetector(
            onTap: () {
              // Handle tap for Alfamart
            },
            child: Container(
              height: 120, // Increased height to accommodate new text
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between image
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0), // Set your desired padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/alfaaa.png', height: 45), // Replace with your image path
                        const SizedBox(height: 8), // Space between image and text
                        const Text(
                          '24/10/2024 09:32:48', // Example date and time
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff909EAE),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right section for payment code and nominal
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '1001422592903', // Example payment code
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Color(0xff353E43),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'Nominal Deposit 500.000', // Example nominal
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Color(0xff353E43),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Card for Indomaret
          GestureDetector(
            onTap: () {
              // Handle tap for Indomaret
            },
            child: Container(
              height: 120, // Increased height to accommodate new text
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between image
                children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0), // Set your desired padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/indomaret.png', height: 80), // Replace with your image path
                        const SizedBox(height: 0), // Space between image and text
                        const Text(
                          '24/10/2024 09:32:48', // Example date and time
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff909EAE),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right section for payment code and nominal
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '422593029', // Example payment code
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Color(0xff353E43),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'Nominal: Rp 75.000', // Example nominal
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Color(0xff353E43),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
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


}
