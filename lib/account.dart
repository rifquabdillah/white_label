import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:white_label/main.dart'; // Adjust according to your file structure
import 'historyTransaction.dart'; // Adjust according to your file structure

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
                const SizedBox(height: 16),
                _buildInfoSection(),
                _buildAccountOptions(),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
            fontWeight: FontWeight.normal,
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
                child: _buildActionGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionGrid() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 70, // You can adjust this as needed
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              children: [
                _buildActionButton('assets/topup1.png', 'Top Up'),
                // Use string for asset path
                _buildActionButton('assets/topup.png', 'Transfer'),
                // Update with the correct asset
                _buildActionButton('assets/qris.png', 'QRIS'),
                // Update with the correct asset
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String assetPath, String title) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Keep layout compact
        children: [
          Container(
            width: 35, // Box width
            height: 35, // Box height
            decoration: const BoxDecoration(
              color: Color(0xFFfaf9f6), // Background color
              shape: BoxShape.rectangle, // Box shape
              borderRadius: BorderRadius.all(
                  Radius.circular(10)), // Rounded corners
            ),
            child: Center(
              child: Image.asset(
                assetPath,
                width: 40, // Adjust the width of the image
                height: 40, // Adjust the height of the image
                // Set color if needed (or use original color)
              ),
            ),
          ),
          const SizedBox(height: 6), // Spacing between icon and text
          Container(
            constraints: const BoxConstraints(maxWidth: 60),
            // Set max width to avoid overflow
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12.0, // Adjust font size here
                color: Colors.white,
                fontWeight: FontWeight.w500, // Change color as needed
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis, // Prevent overflow
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildAccountOptionsContainer(),
          const SizedBox(height: 8),
          _buildProfilOptionsContainer(),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      color: const Color(0xFFFDF7E6), // Latar belakang warna fdf7e6
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: Row(
          children: [
            // Card pertama dengan informasi
            _buildInfoCard(
              title: 'Mutasi Saldo',
              content: 'Saldo Masuk 2.000.000 \n\Saldo Keluar 2.510.210',
            ),
            const SizedBox(width: 16), // Jarak antar card

            // Card kedua dengan informasi
            _buildInfoCard(
              title: 'Penjualan',
              content: 'Penjualan Rp. 13.000\n\Laba Rp. 2.790\n\Trx Sukses 1',
            ),
            const SizedBox(width: 16), // Jarak antar card

            // Card ketiga dengan informasi
            _buildInfoCard(
              title: 'Downline',
              content: 'Komisi Rp. 11.100\n\Downline 174 \n\Trx Jaringan 72',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    double? titleFontSize, // Optional parameter for title font size
    double? contentFontSize, // Optional parameter for content font size
    String? fontFamily, // Optional parameter for font family
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0), // Jarak atas dan bawah card
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 200,
        color: Color(0xfffaf9f6),// Lebar card, sesuaikan sesuai kebutuhan
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Optional: Aligns title and icon
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: titleFontSize ?? 14.0, // Default size if not provided
                              fontFamily: fontFamily ?? Theme.of(context).textTheme.titleLarge?.fontFamily, // Default font family
                              fontWeight: FontWeight.w300, // You can adjust this as needed
                              color: const Color(0xffECB709), // Set the text color to orange
                              decoration: TextDecoration.underline,
                              decorationColor: const Color(0xffECB709), // Add underline
                            ),
                          ),
                          const SizedBox(width: 4), // Reduced spacing between title and icon
                          const Icon(
                            Icons.keyboard_double_arrow_right_outlined, size: 18, // Icon for the arrow
                            color: Color(0xffECB709), // Match the color of the title
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Space below the title
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: contentFontSize ?? 14.0, // Default size if not provided
                          fontFamily: fontFamily ?? Theme.of(context).textTheme.bodyMedium?.fontFamily, // Default font family
                        ),
                      ),
                    ],
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
          _buildButtonMember(),
          const SizedBox(height: 5), // Add space between button and next option
          _buildAccountOption('Kode Referral dan Mark Up'),
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
      margin: const EdgeInsets.symmetric(vertical: 4), // Margin for container
      child: Container(
        height: 200, // Set a fixed height for the card
        child: Column( // Use Column instead of ListView
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0), // Padding for the title
              child: Row( // Use Row to align text left
                mainAxisAlignment: MainAxisAlignment.start, // Aligns text to the left
                children: [
                  Text(
                    'Profil Akun',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF353e43), // Title color
                    ),
                  ),
                ],
              ),
            ),
            _buildAccountOption('Info Akun'),
            _buildAccountOption('Nomor Terdaftar'),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonMember() => SizedBox(
    width: 350,
    height: 45,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffecb709), // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
      child: const Text(
        'Daftarkan Member Baru',
        style: TextStyle(
          color: Colors.white, // Button text color
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  Widget _buildAccountOption(String option, {bool isHighlighted = false}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            option,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: isHighlighted ? Colors.blue : Colors.black,
            ),
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

}

