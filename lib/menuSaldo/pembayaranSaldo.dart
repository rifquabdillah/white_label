import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detailSaldoBatal.dart';
import 'mSaldo.dart';

class PembayaranSaldo extends StatefulWidget {
  const PembayaranSaldo({super.key});

  @override
  _PembayaranSaldoState createState() => _PembayaranSaldoState();
}

class _PembayaranSaldoState extends State<PembayaranSaldo> {
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0),
          _buildNewContent(),
          const SizedBox(height: 10),
          _buildTransferLimitWidget(context),
          const SizedBox(height: 0), // Spacing between sections
          _buildBankInfo(),
          _buildWarning(), // New warning section
        ],
      ),

    );
  }

  Widget _buildNewContent() {
    return Container(height: 220,
      decoration: BoxDecoration(
        color: Color(0xffFAF9F6), // Set the background color here
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
                color: Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              '500.545',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Color(0xff353E43),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: SizedBox(
              width: 160,
              height: 35, // Set your desired width
              child: OutlinedButton(
                onPressed: () {
                  // Action to copy nominal
                  String nominal = '500.545'; // The nominal string to copy
                  // Remove formatting characters
                  String cleanNominal = nominal.replaceAll(RegExp(r'[.,]'), '');

                  // Copy the clean nominal to clipboard
                  Clipboard.setData(ClipboardData(text: cleanNominal)).then((_) {
                    // Show a snackbar or any feedback to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nominal copied: $cleanNominal')),
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
                      'Salin Nominal',
                      style: TextStyle(
                        color: Color(0xffECB709), // Text color
                        fontSize: 13, // Text size
                      ),
                    ),
                    const SizedBox(width: 5), // Space between text and icon
                    const Icon(
                      Icons.content_copy, // Use the copy icon
                      color: Color(0xffECB709), // Icon color
                      size: 16, // Icon size
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Transfer WAJIB sesuai jumlah yang muncul di atas agar saldo masuk otomatis ke akun kamu tanpa potongan.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff353E43),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
          SizedBox(
            width: 105, // Set your desired width
            height: 40, // Set your desired height
            child: ElevatedButton(
              onPressed: () {
                _showCancellationDialog(context); // Show dialog when pressed
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffECB709), // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Rounded corners
                ),
              ),
              child: const Text(
                'Batalkan',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancellationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Yakin batalkan tiket ini?',
                style: TextStyle(
                  fontSize: 14, // Customize the font size
                  fontFamily: 'Poppins', // Set your desired font family
                  fontWeight: FontWeight.w700,
                  color: Color(0xff353E43), // Set the font weight
                ),
              ),
              const SizedBox(width: 50),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xff353E43)), // Customize the icon color
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
          content: const Text(
            'Tiket yang dibatalkan tidak akan bisa digunakan kembali, silakan ambil tiket baru untuk mengisi deposit.',
            style: TextStyle(
              fontSize: 11, // Customize the font size
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: Color(0xff909EAE), // Set your desired font family
            ),
          ),
          actions: [
            Center( // Center the button
              child: Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color(0xffECB709), // Background color
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigate to detailSaldoBatal page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => detailSaldoBatal(transactionId: ''), // Replace with your actual DetailSaldoBatal widget
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Customize the text color
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5), // Button padding
                  ),
                  child: const Text(
                    'BATALKAN TIKET',
                    style: TextStyle(
                      fontSize: 14, // Customize the font size
                      fontFamily: 'Poppins', // Set your desired font family
                      fontWeight: FontWeight.w600, // Set the font weight
                    ),
                  ),
                ),
              ),
            ),
          ],
          // Set the width and height of the AlertDialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners for the dialog
          ),
        );
      },
    );
  }

  Widget _buildBankInfo() {
    return Container(
      padding: const EdgeInsets.all(16), // Padding for the container
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildBankCard('BCA', '280 186 8888', 'a/n Budhi Taufiq Sulistyo'),
          const SizedBox(height: 10), // Space between cards
          _buildBankCard(
              'Mandiri', '13000 51 88888 4', 'a/n Budhi Taufiq Sulistyo'),
          const SizedBox(height: 10), // Space between cards
          _buildBankCard(
              'BRI', '11070 1000 319 563', 'a/n Budhi Taufiq Sulistyo'),
        ],
      ),
    );
  }

  Widget _buildBankCard(String bankName, String accountNumber, String accountName) {
    // Map to store the bank logo paths
    final Map<String, String> bankLogos = {
      'BCA': 'assets/bca.png', // Replace with your actual image path
      'Mandiri': 'assets/mandiri.png', // Replace with your actual image path
      'BRI': 'assets/bri.png', // Replace with your actual image path
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
                  width: 90,
                  height: 70,
                ),
                Text(
                  accountName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Color(0xff909EAE),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20), // Space between logo and account details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Align text to start
                mainAxisAlignment: MainAxisAlignment.center, // Center the items vertically
                children: [
                  Text(
                    accountNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff353E43),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 173, // Set your desired width
                    height: 30, // Set your desired height
                    child: OutlinedButton(
                      onPressed: () {
                        // Action to copy bank account number
                        String cleanAccountNumber = accountNumber.replaceAll(RegExp(r'[., ]'), '');
                        // Copy the clean account number to clipboard
                        Clipboard.setData(ClipboardData(text: cleanAccountNumber)).then((_) {
                          // Show a snackbar or any feedback to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No.rekening disalin: $cleanAccountNumber')),
                          );
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xffECB709),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Center the contents
                        children: [
                          const Text(
                            'Salin Nomor Rekening',
                            style: TextStyle(
                              color: Color(0xffECB709),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 5), // Space between text and icon
                          const Icon(
                            Icons.content_copy,
                            color: Color(0xffECB709),
                            size: 9,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

