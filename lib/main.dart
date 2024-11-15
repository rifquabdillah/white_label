import 'dart:async'; // Import untuk Timer
import 'dart:ui';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:white_label/login/login.dart';
import 'package:white_label/menuUtama/mBpjs.dart';
import 'package:white_label/splashScreen.dart';
import 'account.dart';
import 'backend/nativeChannel.dart';
import 'bantuan.dart';
import 'historyTransaction.dart';
import 'menuAkun/infoAkun.dart';
import 'menuSaldo/kirimSaldo.dart';
import 'menuSaldo/mSaldo.dart';
import 'menuUtama/mMultifinance.dart';
import 'menuUtama/mPDAM.dart';
import 'menuUtama/mPLN.dart';
import 'menuUtama/mPascabayar.dart';
import 'menuUtama/mPromoScreen.dart';
import 'menuUtama/mPulsaPaket.dart' show PulsaPaketScreen;
import 'menuUtama/mSpesialDeals.dart';
import 'menuUtama/mTelkom.dart';
import 'menuUtama/mTokenListrik.dart' show TokenListrikScreen, mTokenListrikScreen;
import 'menuUtama/mPertagas.dart' show mPertagasScreen;
import 'menuUtama/mVoucherGame.dart';
import 'menuVoucher/actPerdana.dart';
import 'menuVoucher/injectSatuan.dart';
import 'menuVoucher/voucherFisik.dart';
import 'menuVoucher/voucherMasal.dart';
import 'notificationPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NativeChannel.instance.initialize();
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
      home: const MyHomePage(title: ''), // Set SplashScreen sebagai halaman awal
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
  final int _selectedPromoIndex = 0;
  final bool _isNotificationVisible = true;
  bool _isFirstText = true;
  void _toggleText() {
    setState(() {
      _isFirstText = !_isFirstText;
    });
  }

  Future<void> _checkPermission() async {
    bool isGranted = await NativeChannel.instance.checkPermission();
    if (!isGranted) {
      // Handle permission denial if needed, e.g., show a message to the user
      print("Permission not granted. Requesting permission...");
    } else {
      print("Permission granted.");
    }
  }

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

    _checkPermission();
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
              pageBuilder: (context, animation, secondaryAnimation) => const mBantuan(), // Replace with your actual SupportPage
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
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHomePage(screenSize),
                ],
              ),
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
            _buildProfileCard(context), // Profile card remains at the top
            const SizedBox(height: 90), // Optional spacing
            _buildTabBar(), // Tab Bar added here
            const SizedBox(height: 250), // Optional spacing
            _buildBannerCarousel(),
            const SizedBox(height: 20),
            _buildTransactionSection(),
            const SizedBox(height: 10),
            _buildInfoSection(),
            const SizedBox(height: 8),
            _buildSpecialDeals(),
            const SizedBox(height: 8),
            _buildAdditionalSection(),
            const SizedBox(height: 16),
          ],
        ),
        Positioned(
          top: 200, // Adjust this value based on your design
          left: 0,
          right: 0,
          child: buildActionRow(),
        ),
        Positioned(
          top: 370, // Adjust this value based on your design
          left: 0,
          right: 0,
          child: _buildTabContent(),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff353e430), fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 14); // Unselected text color set to black
    final selectedTextStyle = textStyle?.copyWith(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Poppins',); // Selected text color set to white
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffFAF9F6), // Background color
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Color(0xff909EAE), // Shadow color
              blurRadius: 4, // Shadow blur
              offset: Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Adjust padding for better appearance
          child: SegmentedTabControl(
            controller: _tabController,
            tabTextColor: const Color(0xff353535), // Unselected tab text color (black)
            selectedTabTextColor: Color(0xffFAF9F6), // Active tab text color (white)// Indicator color
            indicatorPadding: const EdgeInsets.all(2), // Adjust the padding for the indicator
            squeezeIntensity: 1.5,
            tabPadding: const EdgeInsets.symmetric(horizontal: 2),
            textStyle: textStyle, // Apply textStyle for unselected state
            selectedTextStyle: selectedTextStyle, // Apply selectedTextStyle for selected state
            tabs: [
              SegmentTab(
                label: 'Pulsa',
                color: const Color(0XFFECB709), // Tab color
                backgroundColor: const Color(0XFFFAF9F6), // Background color
              ),
              SegmentTab(
                label: 'Tagihan',
                color: const Color(0XFFECB709), // Tab color
                backgroundColor: const Color(0XFFFAF9F6), // Background color
              ),
              SegmentTab(
                label: 'Voucher',
                color: const Color(0XFFECB709), // Tab color
                backgroundColor: const Color(0XFFFAF9F6), // Background color
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      color: Color(0xffFAF9F6),
      child: SizedBox(
        height: 228, // Adjust height based on content
        child: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: [
            _buildTransactionTab(), // Your pulsa tab content widget
            _buildBillTab(), // Your tagihan tab content widget
            _buildVoucherTab(), // Your voucher tab content widget
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
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
                _buildProfileIcon(context),
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
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextSpan(
                                  text: ' - Ferry Febrian N',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
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
            _buildBalanceInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to infoAkun page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => infoAkun(), // Replace with your InfoAkun widget
          ),
        );
      },
      child: Container(
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
              color: Color(0xffFAF9F6),
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
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
                  child: _buildActionGrid(context),
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
                  width: 110.46,
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
                  'Kirim',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => kirimSaldo()),
                    );
                  },
                ),
                _buildActionButton(
                  'assets/qris.png',
                  'QRIS',
                      () {
                    // Show a SnackBar with the warning message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Under Construction',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w700), // Optional: Change text color to white for better contrast
                        ),
                        backgroundColor: Colors.red, // Set the background color to red
                        duration: const Duration(seconds: 3), // Duration for the SnackBar
                      ),
                    );
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

  Widget _buildGridOptions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 10, // Horizontal spacing between boxes
      mainAxisSpacing: 15, // Vertical spacing between boxes
      children: _buildGridItems(), // Call a method to build grid items
    );
  }

  List<Widget> _buildGridItems() {
    const List<Map<String, dynamic>> options = [
      {'title': 'Pulsa & Paket', 'color': Colors.blue},
      {'title': 'Token Listrik', 'color': Colors.blue},
      {'title': 'Pertagas', 'color': Colors.blue},
      {'title': 'Dompet Digital', 'color': Colors.blue},
      {'title': 'Voucher Game', 'color': Colors.blue},
      {'title': 'Entertainment', 'color': Colors.blue},
      {'title': 'Lainnya', 'color': Colors.grey},
    ];

    return options.map((option) {
      return _buildGridItem(option['title'], option['color'] as MaterialColor);
    }).toList();
  }

  Widget _buildGridItem(String title, MaterialColor color) {
    return GestureDetector(
      onTap: () => _onGridItemTapped(title),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Tambahkan ini untuk memperkecil tinggi
        children: [
          Container(
            width: 60, // Ubah ukuran lebar jika perlu
            height: 60, // Ubah ukuran tinggi untuk item
            decoration: BoxDecoration(
              color: color, // Gunakan warna yang disediakan
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 3), // Atur jarak antar konten
          Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: Color(0xff909EAE)),
          ),
        ],
      ),
    );
  }

  void _onGridItemTapped(String title) {
    late final Widget page; // Declare the page variable

    switch (title) {
      case 'Pulsa & Paket':
        page = const PulsaPaketScreen();
        break;
      case 'Token Listrik':
        page = const TokenListrikScreen();
        break;
      case 'Pertagas':
        page = const mPertagasScreen();
        break;
      case 'Voucher Game':
        page = VoucherGameScreen(); // Replace with the correct screen
        break;
      default:
        return; // If the title does not match, do nothing
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
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

  Widget _buildGridOptionsBill() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      children: _buildGridItemsBill(),
    );
  }

  List<Widget> _buildGridItemsBill() {
    const List<Map<String, dynamic>> options = [
      {'title': 'BPJS', 'color': Colors.indigo},
      {'title': 'PLN', 'color': Colors.indigo},
      {'title': 'PDAM', 'color': Colors.indigo},
      {'title': 'Telkom', 'color': Colors.indigo},
      {'title': 'Pascabayar', 'color': Colors.indigo},
      {'title': 'Multifinance', 'color': Colors.indigo},
      {'title': 'Tv Kabel', 'color': Colors.indigo},
      {'title': 'Lainnya', 'color': Colors.grey},
    ];

    return options.map((option) {
      return _buildGridItemBill(option['title'], option['color'] as MaterialColor);
    }).toList();
  }

  Widget _buildGridItemBill(String title, MaterialColor color) {
    return GestureDetector(
      onTap: () => _onGridItemBillTapped(title), // Call the new method
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: Color(0xff909EAE)),
          ),
        ],
      ),
    );
  }

  void _onGridItemBillTapped(String title) {
    late final Widget page; // Declare the page variable

    switch (title) {
      case 'BPJS':
      // Add the corresponding screen for BPJS
        page = const BpjsScreen(); // Replace with the correct screen
        break;
      case 'PLN':
      // Add the corresponding screen for PLN
        page = const PlnScreen(); // Replace with the correct screen
        break;
      case 'PDAM':
      // Add the corresponding screen for PDAM
        page = const PDAMScreen(); // Replace with the correct screen
        break;
      case 'Telkom':
      // Add the corresponding screen for Telkom
        page = const mTelkomScreen(); // Replace with the correct screen
        break;
      case 'Pascabayar':
      // Add the corresponding screen for Telkom
        page = const mPascabayarScreen(); // Replace with the correct screen
        break;
      case 'Multifinance':
      // Add the corresponding screen for Telkom
        page = const mMultifinance(); // Replace with the correct screen
        break;
      default:
        return; // If the title does not match, do nothing
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
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

  Widget _buildGridOptionsVoucher() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      children: _buildGridItemsVoucher(), // Mengganti children dengan metode baru
    );
  }

  List<Widget> _buildGridItemsVoucher() {
    const List<Map<String, dynamic>> options = [
      {'title': 'Inject Satuan', 'color': Colors.pink},
      {'title': 'Masal', 'color': Colors.pink},
      {'title': 'Act Perdana', 'color': Colors.pink},
      {'title': 'Voucher Fisik', 'color': Colors.pink},
      {'title': 'Cek Status', 'color': Colors.pink},
      {'title': 'Tutorial', 'color': Colors.pink},
      {'title': 'Provider', 'color': Colors.grey},
    ];

    return options.map((option) {
      return _buildGridItemVoucher(option['title'], option['color'] as MaterialColor);
    }).toList();
  }

  Widget _buildGridItemVoucher(String title, MaterialColor color) {
    return GestureDetector(
      onTap: () => _onGridItemVoucherTapped(title), // Memanggil _onGridItemTapped
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: Color(0xff909EAE)),
          ),
        ],
      ),
    );
  }

  void _onGridItemVoucherTapped(String title) {
    late final Widget page;

    switch (title) {
      case 'Inject Satuan':
        page = InjectVoucherSatuanScreen();
        break;
      case 'Masal':
        page = VoucherMasalScreen(); // Gantilah dengan halaman yang sesuai
        break;
      case 'Act Perdana':
        page = ActPerdanaScreen(); // Gantilah dengan halaman yang sesuai
        break;
      case 'Voucher Fisik':
        page = VoucherFisikScreen(); // Gantilah dengan halaman yang sesuai
        break;
      default:
        return; // Tidak ada tindakan jika title tidak cocok
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
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

  Widget _buildTransactionTab() {
    return Material(
      elevation: 4, // Set elevation for shadow effect
      shadowColor: Colors.black.withOpacity(0.5), // Color of the shadow
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Optional: round the corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
          child: Container(
            // Set the background color to match the tab bar
            color: const Color(0xffFAF9F6).withOpacity(0.9), // Slightly transparent to enhance the blur effect
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical:10), // No horizontal padding
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
            color: const Color(0xffFAF9F6).withOpacity(0.9), // Slightly transparent to enhance the blur effect
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8), // No horizontal padding
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
            color: const Color(0xffFAF9F6).withOpacity(0.9), // Slightly transparent to enhance the blur effect
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8), // No horizontal padding
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
    return SizedBox(
      height: 150, // Set the height of the banner
      child: PageView.builder(
        itemCount: 3, // Number of banners
        itemBuilder: (context, index) {
          // Determine color for each banner
          Color bannerColor;
          switch (index) {
            case 0:
              bannerColor = Color(0xff34C759); // Banner 1 color
              break;
            case 1:
              bannerColor = Color(0xff34C759); // Banner 2 color
              break;
            case 2:
              bannerColor = Color(0xff34C759); // Banner 3 color
              break;
            default:
              bannerColor = Colors.grey; // Default color
          }
          return _buildBanner('Banner ${index + 1}', bannerColor);
        },
        controller: _pageController, // Use initialized controller
      ),
    );
  }

  Widget _buildBanner(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust margin as needed
      decoration: BoxDecoration(
        color: color, // Banner background color
        borderRadius: BorderRadius.circular(12.0), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Color of the shadow
            blurRadius: 4.0, // Blur radius of the shadow
            offset: Offset(0, -2), // Offset to position the shadow at the top
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10), // Padding inside the banner
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xffFAF9F6),
              fontFamily: 'Poppins',
              fontSize: 24,
            ),
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
        shadowColor: Colors.black.withOpacity(0.15), // Shadow color for a subtle blur effect
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFAF9F6), // Warna latar belakang
            borderRadius: BorderRadius.circular(0.0), // Sudut membulat
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Warna bayangan
                spreadRadius: 1, // Penyebaran bayangan
                blurRadius: 2, // Keburaman bayangan
                offset: Offset(1, -1), // Posisi bayangan (x, y)
              ),
            ],
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
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
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
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xffECB709), // Underline color
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4), // Space between the button and the text
                        const Text(
                          '>>', // Additional text here
                          style: TextStyle(
                            color: Color(0xffECB709),
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
        return  Color(0xffFAF9F6); // Warna teks untuk status sukses
      } else if (status == 'Dalam Proses') {
        return  Color(0xffFAF9F6); // Warna teks untuk status dalam proses
      } else if (status == 'Gagal') {
        return  Color(0xffFAF9F6); // Warna teks untuk status gagal
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
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Color(0xffFAF9F6),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to the mutasiMenu page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpecialDealsPage()), // Adjust MutasiMenu according to your class name in mutasiMenu.dart
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Semua',
                          style: TextStyle(
                            color: Color(0xffFAF9F6),
                            decoration: TextDecoration.underline, // Underline
                            decorationColor:Color(0xffFAF9F6),
                            fontWeight: FontWeight.w300,
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
