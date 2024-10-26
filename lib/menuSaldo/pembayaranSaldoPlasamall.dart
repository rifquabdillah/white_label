import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mSaldo.dart';

class PembayaranSaldoPlasamall extends StatefulWidget {
  final String storeName; // Add this line

  const PembayaranSaldoPlasamall({super.key, required this.storeName}); // Update the constructor

  @override
  _PembayaranSaldoPlasamallState createState() => _PembayaranSaldoPlasamallState();
}

class _PembayaranSaldoPlasamallState extends State<PembayaranSaldoPlasamall> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();
  final DateTime transferLimitDateTime = DateTime(2024, 10, 24, 17, 40);

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
          ),
          child: AppBar(
            backgroundColor: Color(0xffFAF9F6),
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
                        _isSaldoVisible ? Icons.remove_red_eye : Icons
                            .visibility_off,
                        color: const Color(0xff909EAE),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              SaldoPageScreen()),
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0),
          _buildNewContent(context),
          const SizedBox(height: 10),
          _buildTransferLimitWidget(context),
          const SizedBox(height: 0), // Spacing between sections
          _buildBankInfo(widget.storeName),
          _buildWarning(), // New warning section
        ],
      ),

    );
  }

  Widget _buildNewContent(BuildContext context) {
    String paymentCode = '1001422592903'; // Kode bayar yang akan disalin

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xffFAF9F6), // Set the background color here
        borderRadius: BorderRadius.circular(0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0,
            blurRadius: 5, // Blur radius for shadow effect
            offset: const Offset(0, 4), // Position of the shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16), // Add padding for better spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Request diterima. Silakan transfer sebesar:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: const Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              paymentCode,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: const Color(0xff353E43),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: SizedBox(
              width: 175,
              height: 35, // Set your desired width
              child: OutlinedButton(
                onPressed: () {
                  // Action to copy the payment code
                  String cleanPaymentCode = paymentCode.replaceAll(RegExp(r'[., ]'), ''); // Clean the payment code

                  // Copy the clean payment code to clipboard
                  Clipboard.setData(ClipboardData(text: cleanPaymentCode)).then((_) {
                    // Show a snackbar or any feedback to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kode Bayar disalin: $cleanPaymentCode')),
                    );
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xffECB709), // Border color
                    width: 1.5, // Border width
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded border radius
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the contents
                  children: [
                    const Text(
                      'Salin Kode Bayar',
                      style: TextStyle(
                        color: Color(0xffECB709), // Text color
                        fontSize: 13, // Text size
                      ),
                    ),
                    const SizedBox(width: 3), // Space between text and icon
                    const Icon(
                      Icons.content_copy, // Use the copy icon
                      color: Color(0xffECB709), // Icon color
                      size: 13, // Icon size
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Berikan kode bayar di atas pada kasir, dan infokan mau top up PLASAMALL / WIN SOLUTION',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xff353E43),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTransferLimitWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the text
        children: [
          Text(
            'Batas Transfer: ${transferLimitDateTime.day.toString().padLeft(2, '0')}/'
                '${transferLimitDateTime.month.toString().padLeft(2, '0')}/'
                '${transferLimitDateTime.year} ${transferLimitDateTime.hour.toString().padLeft(2, '0')}:'
                '${transferLimitDateTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color(0xffECB709), // Text color
            ),
            textAlign: TextAlign.center, // Center-align text inside its container
          ),
        ],
      ),
    );
  }

  Widget _buildBankInfo(String storeName) {
    return Container(
      padding: const EdgeInsets.all(16), // Padding for the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (storeName == 'Alfamart') ...[
            _buildBankCard('Alfamart', '500.000', '*belum termasuk admin dari Alfamart'),
          ] else if (storeName == 'Indomaret') ...[
            _buildBankCard('Indomaret', '500.000', '*belum termasuk admin dari Indomaret'),
          ],
          // Optionally, you can add an else case or handle if no bank is selected
        ],
      ),
    );
  }


  Widget _buildBankCard(String bankName, String accountNumber,
      String info) {
    final Map<String, String> bankLogos = {
      'Alfamart': 'assets/alfaaa.png', // Replace with your actual image path
      'Indomaret': 'assets/indomaret.png', // Replace with your actual image path
    };
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Color(0xffFAF9F6),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
          children: [
            // Bank logo and account name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start, // Center the items vertically
              children: [
                Image.asset(
                  bankLogos[bankName] ?? 'assets/default_bank.png',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Aligns the row items to the end (right)
              children: [
                const SizedBox(width: 30), // Space between logo and account details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to the end (right)
                  mainAxisAlignment: MainAxisAlignment.center, // Centers items vertically
                  children: [
                    Text(
                      accountNumber,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff353E43),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      info,
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        color: Color(0xff909EAE),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
              ),
            ),
    );
  }

  Widget _buildWarning() {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add some padding
      decoration: BoxDecoration(
        color: Color(0xFFFDF7E6), // Background color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
        children: [
          // First text with red color
          Text(
            'Tidak menerima transfer dari mesin EDC!',
            style: const TextStyle(
              color: Color(0xffC70000), // Red color
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8), // Space between text lines
          // Second text with black color
          Text(
            'Saldo akan ditambahkan otomatis dalam waktu maksimal 10 menit setelah transfer masuk ke rekening kami. Bila ada kendala dalam deposit,',
            style: const TextStyle(
              color: Color(0xff353E43), // Black color
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8), // Space between text lines
          // Third text with yellow color
          Text(
            'hubungi CS kami di Pusat Bantuan.',
            style: const TextStyle(
              color: Color(0xffECB709), // Yellow color
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline, // Add underline
              decorationColor: Color(0xffECB709), // Optional: match the underline color with the text color
            ),
          ),

        ],
      ),
    );
  }

}

