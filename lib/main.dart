import 'dart:async'; // Import untuk Timer
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:white_label/splashScreen.dart';
import 'account.dart';
import 'historyTransaction.dart';
import 'menu/mPulsaPaket.dart' show PulsaPaketScreen;
import 'menu/mTokenListrik.dart' show mTokenListrikScreen;
import 'menu/mPertagas.dart' show mPertagasScreen;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WL',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Set SplashScreen sebagai halaman awal
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  late PageController _pageController; // Mendeklarasikan PageController
  int _currentPage = 0; // Mendeklarasikan halaman saat ini
  Timer? _timer; // Mendeklarasikan timer
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  // Variabel untuk mengontrol animasi teks
  bool _isFirstText = true;

  // Tambahkan fungsi untuk mengubah teks secara berkala
  void _toggleText() {
    setState(() {
      _isFirstText = !_isFirstText;
    });
  }

  // Panggil fungsi ini di dalam initState untuk mengubah teks setiap detik
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this); // Inisialisasi TabController
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _startAutoScroll(); // Memulai auto scroll

    // Timer untuk mengubah teks setiap 2 detik
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _toggleText();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the tab controller
    _pageController.dispose();
    _timer?.cancel();
    _scrollController.dispose(); // Dispose the controller
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        // Determine the direction of the slide transition based on the selected index
        if (index == 0) { // Home
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(title: 'Home'), // Replace with your actual HomePage
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0); // Start from left
                const end = Offset.zero; // End at normal position
                const curve = Curves.easeIn;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        } else if (index == 1) { // History
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HistoryPage(transactions: []),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // Start from right
                const end = Offset.zero; // End at normal position
                const curve = Curves.easeIn;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        } else if (index == 2) { // Profile (Account)
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AccountPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // Start from right
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
        } else if (index == 3) { // Support
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(title: ''), // Replace with your actual SupportPage
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // Start from right
                const end = Offset.zero; // End at normal position
                const curve = Curves.easeIn;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        }
        _selectedIndex = index; // Update selected index after navigating
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Get screen size
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView to enable scrolling
          controller: _scrollController, // Assign the scroll controller
          child: Column(
            children: [
              _buildHomePage(screenSize),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        width: 70.0,  // Set the desired width
        height: 70.0, // Set the desired height
        child: FloatingActionButton(
          backgroundColor: const Color(0xffecb709),
          onPressed: _scrollToSpecialDeals, // Call the scroll function here
          tooltip: 'Shopping Cart',
          shape: const CircleBorder(),
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 45.0), // Keep the icon size as needed
        ),
      ),

      bottomNavigationBar: Container(
        height: 88.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), // Adjust radius as needed
            topRight: Radius.circular(20.0),
          ),
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align icons to the left
            children: [
              _buildIconWithText(Icons.home_filled, "Beranda", 0), // Pass index 0
              _buildIconWithText(Icons.access_time_filled_rounded, "History", 1), // Pass index 1
              _buildIconWithText(Icons.person_rounded, "Akun", 2), // Pass index 2
              _buildIconWithText(Icons.headset_mic_outlined, "Bantuan", 3), // Pass index 3
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildIconWithText(IconData icon, String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 1.0), // Adjust horizontal padding as needed
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
            onPressed: () => _onItemTapped(index), // Call _onItemTapped with the index
            icon: Icon(
              icon,
              color: _selectedIndex == index ? const Color(0xff353e43) : Colors.grey, // Change color based on selection
              size: 30.0,
            ),
          ),

          Text(
            text,
            style: TextStyle(
              color: _selectedIndex == index ? const Color(0xff353e43) : Colors.grey, // Change color based on selection
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage(Size screenSize) {
    return Stack(
      clipBehavior: Clip.none, // To allow overflow if needed
      children: [
        Column(
          children: [
            _buildProfileCard(), // Profile card remains at the top
            const SizedBox(height: 90), // Optional spacing
            _buildTabBar(), // Tab Bar added here
            const SizedBox(height: 250), // Optional spacing
            _buildBannerCarousel(),
            _buildTransactionSection(),
            const SizedBox(height: 10),
            _buildInfoSection(),
            const SizedBox(height: 0),
            _buildSpecialDeals(),
            const SizedBox(height: 5),
            _buildAdditionalSection(),
            const SizedBox(height: 16),
          ],
        ),
        // Positioned ActionRow and TabBar
        Positioned(
          top: 199, // Adjust this value based on your design
          left: 0,
          right: 0,
          child: buildActionRow(),
        ),
        Positioned(
          top: 348, // Adjust this value based on your design
          left: 0,
          right: 0,
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF), // Background color
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Shadow color
            blurRadius: 0, // Shadow blur
            offset: Offset(0, 0), // Shadow offset
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xffecb709), // Tab indicator color
        labelColor: Colors.amber, // Active tab text color
        unselectedLabelColor: const Color(0xff353535), // Inactive tab text color
        tabs: const [
          Tab(text: 'Pulsa'),
          Tab(text: 'Tagihan'),
          Tab(text: 'Voucher'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        height: 250, // Adjust height based on content
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildTransactionTab(), // Your puls tab content widget
            _buildBillTab(), // Your token listrik tab content widget
            _buildVoucherTab(), // Your pertagas tab content widget
          ],
        ),
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
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: ' - Ferry Febrian N',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                  )
                                  ),
                              ],
                            ),
                          ),
                          _buildMembershipStatus(), // Add membership status here
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
            _buildBalanceInfo(),
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
            Icons.star,
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

  Widget _buildBalanceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wrap the Container with Material for elevation
        Material(
          elevation: 5, // Set elevation for shadow effect
          borderRadius: BorderRadius.circular(12), // Match border radius with the Container
          shadowColor: Colors.black.withOpacity(0.2), // Shadow color with transparency
          child: Container(
            padding: const EdgeInsets.all(16),
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
              // Add BoxShadow for blur effect
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  blurRadius: 10, // Adjust the blur radius
                  spreadRadius: 1, // Spread the shadow
                  offset: const Offset(0, 4), // Offset of the shadow
                ),
              ],
            ),
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
                          fontSize: 14,
                          fontFamily: 'Poppins', // Menggunakan font Poppins
                          fontWeight: FontWeight.w400, // Menggunakan gaya SemiBold
                        ),
                      ),
                      Text(
                        '2.862.590',
                        style: TextStyle(
                          fontFamily: 'Poppins', // Menggunakan font Poppins
                          fontWeight: FontWeight.bold, // Menggunakan gaya Bold
                          fontSize: 22,
                          color: Color(0xFF353e43),
                        ),
                      ),
                      Text(
                        'Komisi: 328.025',
                        style: TextStyle(
                          color: Color(0xFF353e43),
                          fontSize: 14,
                          fontFamily: 'Poppins', // Menggunakan font Poppins
                          fontWeight: FontWeight.w500, // Gaya Normal
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 0),
                SizedBox(
                  width: 200,
                  child: _buildActionGrid(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActionRow() {
    return Stack(
      alignment: Alignment.topCenter, // Pusatkan elemen di Stack
      children: [
        // The Action Row with Images
        const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Gambar kiri dan kanan
              children: [
                Image(
                  image: AssetImage('assets/img1.jpg'), // Ganti dengan path gambar Anda
                  width: 110.46,
                  height: 116.9,
                ),
                Image(
                  image: AssetImage('assets/kado.png'), // Ganti dengan path gambar Anda
                  width: 102.46,
                  height: 116.9,
                ),
              ],
            ),
            SizedBox(height: 4), // Jarak antara baris gambar dan tombol
          ],
        ),
        // The Animated Text
        const SizedBox(height: 0),
        Center(
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(seconds: 1), // Adjusted to a shorter duration for better UX
                child: _isFirstText
                    ? const Text(
                  'Cek Spesial Deals hari ini!',
                  key: ValueKey('firstTextKey'), // Unique key for the first text
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF353E43),
                  ),
                )
                    : const Text(
                  'Mau dapat cuan extra?',
                  key: ValueKey('secondTextKey'), // Unique key for the second text
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF353E43),
                  ),
                ),
              )
            ],
          ),
        ),
        // The Button Positioned over the Action Row
        Positioned(
          bottom: 50, // Tempatkan tombol lebih dekat ke gambar
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(25),
            child: OutlinedButton(
              onPressed: () {
                // Tambahkan aksi saat tombol ditekan
                _scrollToSpecialDeals(); // Panggil untuk scroll ke special deals
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xffecb709),
                side: const BorderSide(color: Color(0xfff7df92), width: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(150, 50),
              ),
              child: const Text(
                'Lihat di sini',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins', // Ukuran font
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
              ),
            ),
          ),
        ),
      ],
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
                _buildActionButton('assets/topup1.png', 'Top Up'), // Use string for asset path
                _buildActionButton('assets/topup.png', 'Transfer'), // Update with the correct asset
                _buildActionButton('assets/qris.png', 'QRIS'), // Update with the correct asset
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
              borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded corners
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
            constraints: const BoxConstraints(maxWidth: 60), // Set max width to avoid overflow
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

  Widget _buildGridOptions() {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10), // Jarak dari pinggir
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 10, // Jarak antar box horizontal
        mainAxisSpacing: 15, // Jarak antar box vertical
        children: [
          _buildGridItem('Pulsa & Paket', Colors.blue),
          _buildGridItem('Token Listrik', Colors.blue),
          _buildGridItem('Pertagas', Colors.blue),
          _buildGridItem('Promo!', Colors.blue),
          _buildGridItem('Voucher Game', Colors.blue),
          _buildGridItem('Entertainment', Colors.blue),
          _buildGridItem('Lainnya', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, MaterialColor color) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pulsa & Paket') {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation,
                  secondaryAnimation) => const PulsaPaketScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        } else if (title == 'Token Listrik') {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation,
                  secondaryAnimation) => const mTokenListrikScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        } else if (title == 'Pertagas') {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation,
                  secondaryAnimation) => const mPertagasScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF30b0c7), // Ubah warna sesuai kebutuhan
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOptionsBill() {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        children: [
          _buildGridItemBill('BPJS', Colors.indigo),
          _buildGridItemBill('PLN', Colors.indigo),
          _buildGridItemBill('PDAM', Colors.indigo),
          _buildGridItemBill('Telkom', Colors.indigo),
          _buildGridItemBill('Pascabayar', Colors.indigo),
          _buildGridItemBill('Multifinace', Colors.indigo),
          _buildGridItemBill('Tv Kabel', Colors.indigo),
          _buildGridItemBill('Lainnya', Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildGridItemBill(String title, MaterialColor blue) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pulsa & Paket') {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const PulsaPaketScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOptionsVoucher() {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10), // Jarak dari pinggir
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        children: [
          _buildGridItemVoucher('Inject Satuan', Colors.pink),
          _buildGridItemVoucher('Masal', Colors.pink),
          _buildGridItemVoucher('Act Perdana', Colors.pink),
          _buildGridItemVoucher('Voucher Fisik', Colors.pink),
          _buildGridItemVoucher('Cek Status', Colors.pink),
          _buildGridItemVoucher('Tutorial', Colors.pink),
          _buildGridItemVoucher('Provider', Colors.pink),
        ],
      ),
    );
  }

  Widget _buildGridItemVoucher(String title, MaterialColor blue) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pulsa & Paket') {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const PulsaPaketScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTab() {
    return Material(
      elevation: 4, // Set elevation for shadow effect
      shadowColor: Colors.grey.withOpacity(0.5), // Color of the shadow
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Optional: round the corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
          child: Container(
            // Set the background color to match the tab bar
            color: const Color(0xFFFFFFFF).withOpacity(0.9), // Slightly transparent to enhance the blur effect
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15), // No horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGridOptions(), // Call the buildGridOptions method here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBillTab() {
    return Material(
      elevation: 4, // Set elevation for shadow effect
      shadowColor: Colors.grey.withOpacity(0.1), // Color of the shadow
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Optional: round the corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
          child: Container(
            color: const Color(0xFFFFFFFF).withOpacity(0.9), // Slightly transparent to enhance the blur effect
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10), // No horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGridOptionsBill(), // Call the buildGridOptions method here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherTab() {
    return Material(
      elevation: 4, // Set elevation for shadow effect
      shadowColor: Colors.grey.withOpacity(0.5), // Color of the shadow
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Optional: round the corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
          child: Container(
            color: const Color(0xFFFFFFFF).withOpacity(0.9), // Slightly transparent to enhance the blur effect
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10), // No horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGridOptionsVoucher(), // Call the buildGridOptions method here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Material(
      elevation: 6.0, // Set elevation for shadow effect
      shadowColor: Colors.grey.withOpacity(0.5), // Color of the shadow
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Optional: round the corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
          child: SizedBox(
            width: double.infinity, // Set the width of the card to fill the space
            height: 200, // Height for the PageView
            child: Container(
              color: const Color(0xFFFDF7E6).withOpacity(0.9), // Slightly transparent background
              child: Padding(
                padding: const EdgeInsets.all(0.0), // Remove inner padding
                child: PageView.builder(
                  itemCount: 3, // Number of banners
                  itemBuilder: (context, index) {
                    // Determine color for each banner
                    Color bannerColor;
                    switch (index) {
                      case 0:
                        bannerColor = Colors.red; // Banner 1 color
                        break;
                      case 1:
                        bannerColor = Colors.green; // Banner 2 color
                        break;
                      case 2:
                        bannerColor = Colors.blue; // Banner 3 color
                        break;
                      default:
                        bannerColor = Colors.grey; // Default color
                    }
                    return _buildBanner('Banner ${index + 1}', bannerColor);
                  },
                  controller: _pageController, // Use initialized controller
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Material(
        elevation: 4.0, // Atur elevasi untuk bayangan
        borderRadius: BorderRadius.circular(12.0), // Sudut membulat banner
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0), // Sudut membulat
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12.0), // Sudut membulat
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Padding di dalam banner
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), // Padding around the section
      child: Material(
        elevation: 4.0, // Set elevation for the shadow effect
        borderRadius: BorderRadius.circular(8.0), // Add border radius for rounded corners
        shadowColor: Colors.black.withOpacity(0.8), // Shadow color for a subtle blur effect
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.circular(8.0), // Match border radius with Material
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 0.0, bottom: 0.0), // Reduced padding for title
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread content to left and right
                  children: [
                    const Text(
                      'Transaksi Terakhir',
                      style: TextStyle(
                        color: Color(0xFF353e43),
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Keep the same font size for consistency
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const HistoryPage(transactions: [],),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0); // Start from right
                                  const end = Offset.zero; // End at normal position (no offset)
                                  const curve = Curves.easeIn;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'History',
                            style: TextStyle(
                              color: Color(0xFFfbb034),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFfbb034), // Underline color
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4), // Space between the button and the text
                        const Text(
                          '>>', // Additional text here
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 350, // Adjust height as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildTransactionItem('S10 - 0822 4000 0201', '18 September 2024 - 20:33:24', 'Dalam Proses'),
                      _buildTransactionItem('TD25 - 0812 2126 0284', '18 September 2024 - 18:43:32', 'Sukses'),
                      _buildTransactionItem('S10 - 0822 4000 0201', '18 September 2024 - 20:33:24', 'Gagal'),
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

  Widget _buildTransactionItem(String nomorTransaksi, String tanggal, String status) {
    // Tentukan warna berdasarkan status
    Color getStatusColor(String status) {
      if (status == 'Sukses') {
        return Colors.white; // Warna teks untuk status sukses
      } else if (status == 'Dalam Proses') {
        return Colors.white; // Warna teks untuk status dalam proses
      } else if (status == 'Gagal') {
        return Colors.white; // Warna teks untuk status gagal
      }
      return Colors.grey; // Default warna jika status tidak diketahui
    }

    Color getBackgroundColor(String status) {
      if (status == 'Sukses') {
        return const Color(0xff198754); // Hijau
      } else if (status == 'Dalam Proses') {
        return const Color(0xffecb709); // Kuning
      } else if (status == 'Gagal') {
        return const Color(0xffc70000); // Merah
      }
      return Colors.grey.withOpacity(0.2); // Default latar belakang
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Margin antara item
      padding: const EdgeInsets.all(12.0), // Padding di dalam kotak
      decoration: BoxDecoration(
        color: const Color(0xFFf0f0f0), // Warna latar belakang untuk item
        borderRadius: BorderRadius.circular(8.0), // Sudut membulat
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            spreadRadius: 4,
            blurRadius: 3,
            offset: const Offset(0,0), // Mengubah posisi bayangan
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status berada di bagian atas dengan latar belakang
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: getBackgroundColor(status), // Latar belakang berdasarkan status
                    borderRadius: BorderRadius.circular(15.0), // Sudut membulat pada latar belakang
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(status),
                      fontSize: 12,// Warna teks status berdasarkan status
                    ),
                  ),
                ),
                const SizedBox(height: 4), // Jarak antara status dan detail transaksi
                Text(
                  nomorTransaksi,
                  style: const TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 12,
                  ),
                ),
                Text(tanggal, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Color(0xff909eae)),
            onPressed: () {
              // Aksi untuk melihat detail transaksi
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      color: const Color(0xFFFDF7E6), // Latar belakang warna fdf7e6
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Card baru dengan informasi dan warna
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container dengan warna latar belakang
                  Container(
                    height: 150.0, // Sesuaikan tinggi
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.green, // Ganti dengan warna yang diinginkan
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: const Center(

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Terbaru',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ini adalah informasi terbaru yang ditampilkan di bawah gambar. Anda bisa menambahkan detail lebih lanjut di sini.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 0), // Jarak bawah setelah card
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialDeals() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10), // Optional padding around the section
      child: Material(
        elevation: 7.0, // Set elevation for the shadow effect
        borderRadius: BorderRadius.circular(20), // Add border radius for rounded corners
        shadowColor: Colors.black.withOpacity(0.8), // Shadow color for a subtle blur effect
        child: Container(
          width: double.infinity, // Set width to fill available space
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFECB709), // Background color
            borderRadius: BorderRadius.circular(20), // Match border radius with Material
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Special Deals Hari Ini!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Action for 'Semua'
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Semua',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline, // Underline
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '>>',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              const Text(
                'Bisa jadi inspirasi cuan tambahan buat kamu',
                style: TextStyle(color: Colors.black38),
              ),
              const SizedBox(height: 5),

              // Deals Section with Horizontal Scroll and 2 rows
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Scroll horizontal
                child: Row(
                  children: [
                    Column(
                      children: [
                        // Baris pertama
                        Wrap(
                          spacing: 15, // Jarak horizontal antar card
                          runSpacing: 8, // Jarak vertikal antar card
                          children: [
                            _buildDealCard('Cashback 5%', 'Indosat Gift 15 GB', 'IGF15', Colors.orange),
                            _buildDealCard('Diskon 2.500', 'Telkomsel Flash 50 GB', 'TDF50', Colors.red),
                            _buildDealCard('Diskon 12%', 'Transfer Pulsa Indosat', 'IP', Colors.red),
                          ],
                        ),
                        const SizedBox(height: 16), // Jarak antar baris

                        // Baris kedua
                        Wrap(
                          spacing: 15, // Jarak horizontal antar card
                          runSpacing: 8, // Jarak vertikal antar card
                          children: [
                            _buildDealCard('Diskon 12%', 'Transfer Pulsa Indosat', 'IP', Colors.orange),
                            _buildDealCard('Diskon 20%', 'Voucher Makanan', 'VM20', Colors.orange),
                            _buildDealCard('Promo Akhir Tahun', 'Diskon 50%', 'PAT50', Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToSpecialDeals() {
    // You may need to adjust the offset based on the actual position of _buildSpecialDeals
    // For example, if it's the third widget down, you can use a specific offset:
    _scrollController.animateTo(
      1500.0, // Adjust this value to match the position of your _buildSpecialDeals widget
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildDealCard(String title, String description, String code, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 230, // Atur lebar sesuai kebutuhan
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bagian kotak warna
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 8), // Jarak antara kotak warna dan teks

          // Bagian teks (dibuat menjadi vertikal)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4), // Jarak antara title dan description

                // Description
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 4), // Jarak antara description dan code

                // Kode promo
                Text(
                  code,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalSection() {
    return Container(
      color: const Color(0xFFFDF7E6), // Latar belakang warna fdf7e6
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center( // Memusatkan teks
            child: Text(
              'Informasi Menarik Lainnya',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildInfoCard(),
              _buildInfoCard(),
              _buildInfoCard(),
              _buildInfoCard(),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Memusatkan konten dalam Row
              children: [
                TextButton(
                  onPressed: () {
                    // Aksi ketika tombol "Selengkapnya" ditekan
                  },
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(
                      color: Color(0xFFfbb034),
                      fontSize: 16,
                      decoration: TextDecoration.underline, // Menambahkan garis bawah
                      decorationColor: Color(0xFFfbb034), // Warna garis bawah
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Text(
                  '>>', // Ganti dengan teks yang diinginkan
                  style: TextStyle(
                    color: Color(0xFFfbb034), // Gaya teks tambahan
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all( // Menambahkan border
            color: Colors.blue, // Warna border
            width: 2, // Ketebalan border
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder gambar di sebelah kiri dengan border
            Container(
              width: 80, // Lebar placeholder
              height: 80, // Tinggi placeholder
              decoration: const BoxDecoration(// Border radius untuk gambar
                color: Colors.lightBlue, // Warna placeholder biru
              ),
              child: const Center(
                child: Text(
                  'Gambar', // Teks placeholder
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10), // Spasi antara placeholder dan teks
            // Teks di sebelah kanan placeholder
            const Expanded(
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
