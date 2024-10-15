import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:white_label/main.dart';
import 'historyTransaction.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 0; // Default index for the selected icon

  void _onItemTapped(int index) {
    if (_selectedIndex != index) { // Cek apakah indeks yang dipilih berbeda
      setState(() {
        _selectedIndex = index; // Update index yang dipilih
      });

      // Navigasi berdasarkan indeks yang dipilih
      switch (index) {
        case 0: // Home
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AccountPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeIn;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
          break;
        case 1: // History
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HistoryPage(transactions: []),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeIn;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
          break;
        case 2: // Profile
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AccountPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
          break;
        case 3: // Support
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(title: ''),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeIn;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
          break;
      }
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
                _buildUserInfo(context),
                const SizedBox(height: 20),
                _buildBalanceSection(context),
                // Account Balance and Actions with border and no padding
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Transparent background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Sales and Downline Information
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoCard(
                            title: 'Penjualan',
                            amount: 'Rp. 1.285.000',
                            description: 'Laba Rp. 362.475\n64 Transaksi',
                          ),
                          const SizedBox(width: 12), // Adjust gap between cards
                          _buildInfoCard(
                            title: 'Downline',
                            amount: '4.583 Downline',
                            description: 'Komisi Hari Ini\nRp. 135.725',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffecb709), // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Radius sudut tombol
                            ),
                          ),
                          child: const Text(
                            'Daftarkan Member Baru',
                            style: TextStyle(
                              color: Colors.white, // Warna teks tombol
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bagian atas
                const SizedBox(height: 16),
                // Divider tanpa padding tambahan
                Divider(
                  color: Colors.grey[300], // Warna Divider
                  thickness: 2, // Ketebalan Divider
                  indent: 0, // Menghilangkan padding kiri
                  endIndent: 0, // Menghilangkan padding kanan
                ),
                // Bagian bawah
                const SizedBox(height: 16),

                // Account Options Section
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
        onPressed: () {  },
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 35.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 88.9,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align icons to the left
            children: [
              _buildIconWithText(Icons.home_filled, "Home", 0), // Pass index 0
              _buildIconWithText(Icons.access_time_filled_rounded, "History", 1), // Pass index 1
              _buildIconWithText(Icons.person_rounded, "Profile", 2), // Pass index 2
              _buildIconWithText(Icons.headset_mic_outlined, "Support", 3), // Pass index 3
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




Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left:16.0),
      // Optionally set a background color or decoration if needed
      decoration: BoxDecoration(
        color: const Color(0xfffdf7e6), // Example background color
        borderRadius: BorderRadius.circular(12),

      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFc70000),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'FF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Update using RichText for user ID and phone number
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PX14025',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: ' | Ferry Febrian N',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'FF Cell',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF404040),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.crown,
                      color: Color(0xFFf7d82f),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Premium Member',
                      style: TextStyle(
                        color: Color(0xFF404040),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
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
              Color(0xFFf2cd54),
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
                        fontSize: 10, // Adjusted font size to match the example
                        fontFamily: 'Poppins', // Use Poppins font
                        fontWeight: FontWeight.w400, // SemiBold
                      ),
                    ),
                    Text(
                      '10.000.000',
                      style: TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF353e43),
                      ),
                    ),
                    Text(
                      'Komisi: 1.805.725\nPoin: 52.336',
                      style: TextStyle(
                        color: Color(0xFF353e43),
                        fontSize: 10, // Adjusted font size to match the example
                        fontFamily: 'Poppins', // Use Poppins font
                        fontWeight: FontWeight.w500, // Normal
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
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: double.infinity,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 2, // Kurangi jarak antar kolom
          mainAxisSpacing: 2,  // Kurangi jarak antar baris
          children: [
            _buildActionButton('Isi Saldo'),
            _buildActionButton('Transfer'),
            _buildActionButton('Cek Mutasi'),
          ],
        ),
      ),
    );
  }
  // Individual Action Button
Widget _buildActionButton(String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,  // Sesuaikan ukuran ikon agar lebih kecil
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFd9d9d9),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 0),  // Kurangi jarak antara ikon dan teks
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Info Card for Sales and Downline
Widget _buildInfoCard({
    required String title,
    required String amount,
    required String description,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // Remove the border and add an orange shadow
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2), // Orange shadow color
              spreadRadius: 4, // Spread radius for shadow
              blurRadius: 3, // Blur radius for shadow
              offset: const Offset(0, 0), // Offset for shadow (x, y)
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 2),
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),

    );
  }

  // Account Options Section
  Widget _buildAccountOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding around the column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Akun',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildAccountOption('Lihat Daftar Harga'),
          _buildAccountOption('Nomor Terdaftar'),
          _buildAccountOption('Status Membership'),
          _buildAccountOption('Kode Referral dan Mark Up'),
          _buildAccountOption('Pengaturan Keamanan Akun'),
          _buildAccountOption('Bantuan dan Laporan'),
          _buildAccountOption('Berikan Penilaian', isHighlighted: true),
        ],
      ),
    );
  }

  Widget _buildAccountOption(String title, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Add vertical padding for each account option
      child: ListTile(
        leading: Container(
          width: 15, // Width of the gray box
          height: 15, // Height of the gray box
          decoration: BoxDecoration(
            color: Colors.grey[400], // Color of the gray box
            borderRadius: BorderRadius.circular(3), // Radius of the box corners
          ),
          margin: const EdgeInsets.only(right: 12), // Space between the box and text
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isHighlighted ? Colors.grey[700] : Colors.grey[700],
            fontWeight: isHighlighted ? FontWeight.normal : FontWeight.normal,
          ),
        ),
        trailing: isHighlighted
            ? const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20, // Size of the check icon
            ),
            SizedBox(width: 8), // Space between the icon and text
            Text(
              'Promo Berhadiah',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        )
            : const Icon(Icons.chevron_right),
      ),
    );
  }

}
