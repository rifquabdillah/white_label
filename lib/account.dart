import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:white_label/main.dart'; // Adjust according to your file structure
import 'historyTransaction.dart';
import 'menuAkun/daftarMember.dart';
import 'menuAkun/infoAkun.dart';
import 'menuAkun/mReferralMarkup.dart';
import 'menuSaldo/mSaldo.dart';
import 'menuTransaksi//mutasiMenu.dart';
import 'menuTransaksi//transactionsiSummary.dart';
import 'notificationPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 2; // Set default index to 2 for Profile

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        // Check if we are currently on the Profile page
        if (_selectedIndex == 2) { // Profile page index
          if (index == 1) { // Navigate to History
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) => const HistoryPage(transactions: []),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) {
                  const begin = Offset(
                      -1.0, 0.0); // Start from left for History
                  const end = Offset.zero; // End at normal position
                  const curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          } else if (index == 0) { // Navigate to Home
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) => const MyHomePage(title: 'Home'),
                // Replace with your actual HomePage
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) {
                  const begin = Offset(-1.0, 0.0); // Start from left for Home
                  const end = Offset.zero; // End at normal position
                  const curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          }
        } else {
          // For other navigation (History to Profile and Home to Profile)
          if (index == 2) { // Navigate to Profile
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) => const AccountPage(),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) {
                  const begin = Offset(
                      1.0, 0.0); // Start from right for Profile
                  const end = Offset.zero; // End at normal position
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          } else if (index == 3) { // Navigate to Support
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) => const MyHomePage(title: ''),
                // Replace with your actual SupportPage
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) {
                  const begin = Offset(
                      1.0, 0.0); // Start from right for Support
                  const end = Offset.zero; // End at normal position
                  const curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          }
        }
        _selectedIndex = index; // Update selected index after navigating
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf7e6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Section
                _buildProfileCard(),
                _buildThreeFilledCards(),
                _buildAccountOptions(),
                const SizedBox(height: 20),
                _buildLogoutMember(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffecb709),
        tooltip: 'Shopping Cart',
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 35.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 88.9,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // Align icons to the left
            children: [
              _buildIconWithText(Icons.home_filled, "Beranda ", 0),
              // Pass index 0
              _buildIconWithText(
                  Icons.access_time_filled_rounded, "History", 1),
              // Pass index 1
              _buildIconWithText(Icons.person_rounded, "Akun", 2),
              // Pass index 2
              _buildIconWithText(Icons.headset_mic_outlined, "Bantuan", 3),
              // Pass index 3
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(IconData icon, String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 1.0),
      // Adjust horizontal padding as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align items to the top
        children: [
          // Add the orange indicator line at the top
          if (_selectedIndex == index) // Use if for cleaner syntax
            Container(
              width: 30.0, // Adjust width as needed
              height: 1.5, // Thin line
              color: Colors.orange, // Orange color for the indicator
            ),
          IconButton(
            onPressed: () => _onItemTapped(index),
            // Call _onItemTapped with the index
            icon: Icon(
              icon,
              color: _selectedIndex == index ? const Color(0xff353e43) : Colors
                  .grey, // Change color based on selection
              size: 30.0,
            ),
          ),

          Text(
            text,
            style: TextStyle(
              color: _selectedIndex == index ? const Color(0xff353e43) : Colors
                  .grey, // Change color based on selection
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFfdf7e6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildProfileIcon(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'PX14025',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                        fontFamily: 'Poppins'
                                    ),
                                  ),
                                  TextSpan(
                                      text: ' - Ferry Febrian N',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                        fontSize: 14,
                                        fontFamily: 'Poppins'
                                      )
                                  ),
                                ],
                              ),
                            ),
                            _buildMembershipStatus(),
                            // Add membership status here
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationPage()),
                            ); // Navigate to the NotificationPage
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildBalanceSection(context),
            ],
          ),
        ),
      );
    }

  Widget _buildProfileIcon() {
    return Container(
      width: 68,
      height: 68,
      decoration: const BoxDecoration(
        color: Color(0xFFc70000),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'FF',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipStatus() {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.crown,
            color: Color(0xFFf7d82f),
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            'Premium',
            style: TextStyle(
              color: Color(0xFFf7d82f),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '•', // Simbol titik
            style: TextStyle(
              color: Color(0xFF676c6c),
              fontSize: 20,
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Poin 4.126',
            style: TextStyle(
              color: Color(0xFF676c6c),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container( // Use Container for the gradient background
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFf5db83),
              Color(0xFFf2cd53),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo Kamu',
                      style: TextStyle(
                        color: Color(0xFF353e43),
                        fontSize: 11, // Adjusted font size to match the example
                        fontFamily: 'Poppins', // Use Poppins font
                        fontWeight: FontWeight.w500, // SemiBold
                      ),
                    ),
                    Text(
                      '2.820.590',
                      style: TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF353e43),
                      ),
                    ),
                    Text(
                      'Komisi: 1.805.725',
                      style: TextStyle(
                        color: Color(0xFF353e43),
                        fontSize: 11, // Adjusted font size to match the example
                        fontFamily: 'Poppins', // Use Poppins font
                        fontWeight: FontWeight.w600, // Normal
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 0), // Adjust spacing if needed
              SizedBox(
                width: 200,
                child: _buildActionGrid(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 70, // Anda bisa mengatur ini sesuai kebutuhan
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              children: [
                _buildActionButton(
                  'assets/topup1.png',
                  'Top Up',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaldoPageScreen()),
                    );
                  },
                ),
                _buildActionButton(
                  'assets/topup.png',
                  'Transfer',
                      () {
                    // Tambahkan navigasi lain jika diperlukan
                  },
                ),
                _buildActionButton(
                  'assets/qris.png',
                  'QRIS',
                      () {
                    // Tambahkan navigasi lain jika diperlukan
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String assetPath, String title, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Menjaga tata letak tetap kompak
          children: [
            Container(
              width: 35, // Lebar kotak
              height: 35, // Tinggi kotak
              decoration: const BoxDecoration(
                color: Color(0xFFfaf9f6), // Warna latar belakang
                shape: BoxShape.rectangle, // Bentuk kotak
                borderRadius: BorderRadius.all(Radius.circular(10)), // Sudut melengkung
              ),
              child: Center(
                child: Image.asset(
                  assetPath,
                  width: 40, // Atur lebar gambar
                  height: 40, // Atur tinggi gambar
                ),
              ),
            ),
            const SizedBox(height: 6), // Jarak antara ikon dan teks
            Container(
              constraints: const BoxConstraints(maxWidth: 60), // Lebar maksimum untuk mencegah overflow
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0, // Ukuran font
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Mencegah teks overflow
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildAccountOptionsContainer(),
          const SizedBox(height: 8),
          _buildProfilOptionsContainer(),
          const SizedBox(height: 8),
          _buildAboutOptionsContainer(),
        ],
      ),
    );
  }

  Widget _buildThreeFilledCards() {
    return SizedBox(
      height: 150, // Set a fixed height for the scrollable area
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: Row(
          children: [
            SizedBox(width: 10), // Space before the first card
            GestureDetector( // Wrap the "Penjualan" card with GestureDetector
              onTap: () {
                // Navigate to the transaction history screen when the card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionSummary()), // Replace with your transaction history widget
                );
              },
              child: _buildFilledCard(
                title: 'Penjualan',
                amount: 'Rp. 13.000',
                newSale: 'Penjualan Baru', // New parameter for new sale
                newSaleAmount: 'Rp. 13.000', // Amount for new sale
                label1: 'Laba',
                profit: 'Rp. 2.790',
                label2: 'Trx Sukses',
                trxSuccess: '1',
              ),
            ),
            SizedBox(width: 10),
            GestureDetector( // Wrap the "Mutasi Saldo" card with GestureDetector
              onTap: () {
                // Navigate to the MutasiMenu screen when the card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MutasiMenu()), // Replace with your mutasi menu widget
                );
              },
              child: _buildFilledCard(
                title: 'Mutasi Saldo',
                label1: 'Saldo Masuk',
                profit: 'Rp. 2.000.000',
                label2: 'Saldo Akhir',
                trxSuccess: 'Rp. 2.510.210',
              ),
            ),
            SizedBox(width: 10), // Space between cards
            _buildFilledCard(
              title: 'Downline',
              label1: 'Komisi',
              profit: 'Rp. 11.100',
              label2: 'Total Downline',
              trxSuccess: '72',
            ),
            SizedBox(width: 10), // Space after the last card
          ],
        ),
      ),
    );
  }

  Widget _buildFilledCard({
    required String title,
    String? amount,
    String? newSale, // New parameter for new sale
    String? newSaleAmount, // Amount for new sale
    required String label1,
    required String profit,
    required String label2,
    required String trxSuccess,
  }) {
    return Container(
      width: 200, // Set a fixed width for the card
      height: 120, // Set a fixed height for the card (increased to accommodate new text)
      decoration: BoxDecoration(
        color: Color(0xfffaf9f6), // Background color for the card
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Shadow color
            offset: Offset(0, -0), // Shift the shadow downwards
            blurRadius: 4.0, // Softening the shadow
            spreadRadius: 3.0, // Extending the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding inside the card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffECB709),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xffECB709), // Underline color
                  ),
                ),
                SizedBox(width: 4), // Space between text and icon
                Icon(
                  Icons.double_arrow_rounded, // Replace with your desired icon
                  color: Color(0xffECB709), // Icon color
                  size: 16, // Icon size
                ),
              ],
            ),
            if (newSale != null && newSaleAmount != null) // Display new sale if provided
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newSale,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black, // Black text for nominal
                    ),
                  ),
                  Text(
                    newSaleAmount,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text for nominal
                    ),
                  ),
                ],
              ),
            SizedBox(height: 4), // Space between lines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black, // Black text for nominal
                  ),
                ),
                Text(
                  profit,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black text for nominal
                  ),
                ),
              ],
            ),
            SizedBox(height: 4), // Space between lines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label2,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black, // Black text for nominal
                  ),
                ),
                Text(
                  trxSuccess,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black text for nominal
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOptionsContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffaf9f6),
        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: Offset(0, -0), // Shift the shadow upwards
            blurRadius: 6.0, // Softening the shadow
            spreadRadius: 2.0, // Extending the shadow
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 4), // Margin for container
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0), // Padding for the title
            child: Text(
              '', // You can add a title here if needed
              style: TextStyle(
                fontSize: 5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF353e43), // Title color
              ),
            ),
          ),
          _buildButtonMember(context),
          const SizedBox(height: 5), // Add space between button and next option
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReferallMarkupScreen()),
              );
            },
            child: _buildAccountOption('Kode Referral dan Mark Up'),
          ),
          _buildAccountOption('Jaringan Downline'),
          _buildAccountOption('Info Komisi'),
          _buildAccountOption('Setelan Jaringan'),

        ],
      ),
    );
  }

  Widget _buildProfilOptionsContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffaf9f6),
        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: Offset(0, -0), // Shift the shadow upwards
            blurRadius: 6.0, // Softening the shadow
            spreadRadius: 2.0, // Extending the shadow
          ),
        ],
      ),
      margin: EdgeInsets.zero, // No margin on left and right
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0), // Padding for the title
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Profil Akun',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF353e43),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => infoAkun()),
              );
            },
            child: _buildAccountOption('Info Akun'),
          ),
          _buildAccountOption('Nomor Terdaftar'),
          _buildAccountOption('Keamanan Akun'),
          _buildAccountOption('Log Inbox'),
        ],
      ),
    );
  }

  Widget _buildAboutOptionsContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffaf9f6),
        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: Offset(0, -0), // Shift the shadow upwards
            blurRadius: 6.0, // Softening the shadow
            spreadRadius: 2.0, // Extending the shadow
          ),
        ],
      ),
      margin: EdgeInsets.zero, // No margin on left and right
      child: SizedBox(
        height: 218, // Set a fixed height for the card
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0), // Padding for the title
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tentang ',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF353e43), // Title color
                    ),
                  ),
                ],
              ),
            ),
            _buildAccountOption('Syarat & Ketentuan'),
            _buildAccountOption('Kebijakan Privasi'),
            _buildAccountOption('Kunjungin Halaman Web'),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonMember(BuildContext context) => SizedBox(
    width: 350,
    height: 35,
    child: ElevatedButton(
      onPressed: () {
        // Navigasi ke halaman daftarMember
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DaftarMember()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffecb709), // Warna background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Sudut membulat
        ),
      ),
      child: const Text(
        'Daftarkan Member Baru',
        style: TextStyle(
          color: Colors.white, // Warna teks tombol
          fontSize: 18,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  Widget _buildAccountOption(String option, {bool isHighlighted = false}) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Container(
                width: 16, // Small grey box width
                height: 16, // Small grey box height
                decoration: BoxDecoration(
                  color: Color(0xff909EAE), // Grey color for the box
                  borderRadius: BorderRadius.circular(4), // Add radius for rounded corners
                ),
              ),
              SizedBox(width: 10), // Space between the box and the text
              Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  color: isHighlighted ? Colors.blue : Colors.black,
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ), // Right arrow icon
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey[300]), // Divider between options
      ],
    );
  }

  Widget _buildLogoutMember() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min, // To center the content vertically
      children: [
        SizedBox(
          width: 350,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              _showLogoutDialog(context); // Show dialog on button press
            },
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color(0xfffaf9f6), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
            ),
            child: const Text(
              'KELUAR',
              style: TextStyle(
                color: Color(0XFF353e43), // Button text color
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // Space between button and version text
        const Text(
          'Versi 0.2.01',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey, // You can change the color as needed
          ),
        ),
      ],
    ),
  );

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyHomePage(title: '',)),
                      (Route<dynamic> route) => false,
                ); // Navigate to MyHomePage
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}




