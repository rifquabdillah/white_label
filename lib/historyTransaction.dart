import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:white_label/main.dart';
import 'account.dart';
import 'menuSaldo/mSaldo.dart';
import 'menuTransaksi//transactionsiSummary.dart'; // Import this for BackdropFilter

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required List<Map<String, String>> transactions});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isSaldoVisible = true; // Controller for phone input
  final TextEditingController _phoneController = TextEditingController();
  int _selectedIndex = 1;


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
    final screenSize = MediaQuery
        .of(context)
        .size;
    const String saldo = '2.862.590'; // Example saldo
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xfffdf7e6), // Background color for the body
          ),
          Column(
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(190.0), // Adjust height
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
                              _isSaldoVisible
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Navigate to SaldoPage when the add icon is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SaldoPageScreen()), // Replace with your SaldoPage
                              );
                            },
                            child: const Icon(Icons.add, color: Color(0xFFFAF9F6)),
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
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, bottom: 20.0, left: 23.0, right: 23.0),
                    child: _buildPhoneNumberField(screenSize),
                  ),
                ),
              ),
              // Content of the body in a separate widget
              const Expanded(
                  child: HistoryContent()
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        width: 70.0, // Set the desired width
        height: 70.0, // Set the desired height
        child: FloatingActionButton(
          backgroundColor: const Color(0xffecb709),
          onPressed: () {
            // Logic to handle voice input here
          },
          tooltip: 'Shopping Cart',
          shape: const CircleBorder(),
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white,
              size: 45.0), // Keep the icon size as needed
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
            mainAxisAlignment: MainAxisAlignment.start,
            // Align icons to the left
            children: [
              _buildIconWithText(Icons.home_filled, "Beranda", 0),
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

  Widget _buildPhoneNumberField(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: false,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            hintText: 'Masukkan nomor handphone',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                      Icons.search, size: 40.0, color: Color(0xFF353e43)),
                  onPressed: () {}
                ),
                const SizedBox(width: 2), // Space between icons
              ],
            ),
          ),
          style: TextStyle(
            fontSize: 18,
            fontWeight: _phoneController.text.isEmpty
                ? FontWeight.normal
                : FontWeight.w600,
            color: _phoneController.text.isEmpty ? Colors.grey : const Color(
                0xFF363636),
          ),
          onChanged: (value) {
            setState(() {
              _phoneController.text = _formatPhoneNumber(value);
              _phoneController.selection = TextSelection.fromPosition(
                TextPosition(offset: _phoneController.text.length),
              );
            });
          },
        ),
      ],
    );
  }

  bool _validatePhoneNumber(String input) {
    final phoneRegex = RegExp(r'^\d{10,13}$');
    return phoneRegex.hasMatch(input);
  }

  String _formatPhoneNumber(String input) {
    input =
        input.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters
    if (input.length > 3 && input.length <= 7) {
      return '${input.substring(0, 3)}-${input.substring(3)}';
    } else if (input.length > 7) {
      return '${input.substring(0, 3)}-${input.substring(3, 7)}-${input
          .substring(7)}';
    }
    return input;
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
}

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  int _selectedFilterIndex = 0; // Track selected filter button
  List<Map<String, String>> allTransactions = [
    // Transactions for 18 September 2024
    {
      'nomorTransaksi': 'S10 - 0822 4000 0201',
      'tanggal': '18 September 2024 - 16:40:28',
      'status': 'Dalam Proses'
    },
    {
      'nomorTransaksi': 'S150 - 0822 4000 0221',
      'tanggal': '18 September 2024 - 16:40:28',
      'status': 'Dalam Proses'
    },
    {
      'nomorTransaksi': 'TD25 - 0812 2126 0284',
      'tanggal': '18 September 2024 - 13:37:28',
      'status': 'Sukses'
    },
    {
      'nomorTransaksi': 'S10 - 0822 4000 0201',
      'tanggal': '18 September 2024 - 09:44:13',
      'status': 'Gagal'
    },

    // Transactions for 19 September 2024
    {
      'nomorTransaksi': 'FF130 - 1143407304',
      'tanggal': '19 September 2024 - 08:40:26',
      'status': 'Sukses'
    },
    {
      'nomorTransaksi': 'S200 - 0822 4000 0301',
      'tanggal': '19 September 2024 - 10:00:15',
      'status': 'Dalam Proses'
    },
    {
      'nomorTransaksi': 'T300 - 0812 3126 0284',
      'tanggal': '19 September 2024 - 12:30:45',
      'status': 'Gagal'
    },
    {
      'nomorTransaksi': 'S400 - 0822 4000 0401',
      'tanggal': '19 September 2024 - 14:10:00',
      'status': 'Sukses'
    },
    {
      'nomorTransaksi': 'F500 - 1143407305',
      'tanggal': '19 September 2024 - 16:20:30',
      'status': 'Sukses'
    },

    // Transactions for 20 September 2024
    {
      'nomorTransaksi': 'S100 - 0822 4000 0501',
      'tanggal': '20 September 2024 - 09:15:00',
      'status': 'Gagal'
    },
    {
      'nomorTransaksi': 'S200 - 0822 4000 0601',
      'tanggal': '20 September 2024 - 10:45:13',
      'status': 'Sukses'
    },
    {
      'nomorTransaksi': 'T300 - 0812 3126 0384',
      'tanggal': '20 September 2024 - 12:00:00',
      'status': 'Dalam Proses'
    },
    {
      'nomorTransaksi': 'F400 - 1143407404',
      'tanggal': '20 September 2024 - 14:30:45',
      'status': 'Gagal'
    },
    {
      'nomorTransaksi': 'FF500 - 1143407405',
      'tanggal': '20 September 2024 - 16:50:50',
      'status': 'Sukses'
    },
  ];

  late List<Map<String, String>> filteredTransactions; // To hold filtered results

  @override
  void initState() {
    super.initState();
    filteredTransactions = allTransactions; // Initialize filtered list
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Wrap Column in SingleChildScrollView
      child: Column(
        children: [
          _buildFilterButtons(),
          // New Row for Month-Year and Success Transactions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dynamic Month and Year on the left
                Text(
                  DateFormat('MMMM yyyy').format(DateTime.now()), // Format current month and year
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Color(0xff353E43),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TransactionSummary()),
                    );
                  },
                  child: Text(
                    '${filteredTransactions.where((transaction) => transaction['status'] == 'Sukses').length} Transaksi Sukses >>',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Color(0xfff0ca4c),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xfff0ca4c), // Add underline
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Use a ListView.builder with a fixed height to allow for scrolling
          ListView.builder(
            itemCount: filteredTransactions.length,
            shrinkWrap: true, // Set to true to allow ListView to take only the space it needs
            physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
            itemBuilder: (context, index) {
              // Determine the color based on the status
              Color statusColor;
              Color backgroundColor;
              String status = filteredTransactions[index]['status']!;
              if (status == 'Dalam Proses') {
                statusColor = Colors.white; // White color for 'Dalam Proses'
                backgroundColor = const Color(0xffecb709); // Light orange background
              } else if (status == 'Sukses') {
                statusColor = Colors.white; // White color for 'Sukses'
                backgroundColor = const Color(0xff198754); // Light green background
              } else if (status == 'Gagal') {
                statusColor = Colors.white; // White color for 'Gagal'
                backgroundColor = const Color(0xffc70000); // Light red background
              } else {
                statusColor = Colors.black; // Default color for unknown status
                backgroundColor = const Color(0xfffaf9f6); // Light grey background for unknown status
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 4.0, // Set elevation for shadow effect
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            filteredTransactions[index]['nomorTransaksi']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            filteredTransactions[index]['tanggal']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Color(0xff909EAE),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman berikutnya
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TransactionSummary()),
                          );
                        },
                        child: const Icon(
                          Icons.navigate_next_rounded,
                          size: 50.0,
                          color: Color(0xff909eae),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // Add top padding for spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton('Semua', 0),
          _buildFilterButton('Proses', 1),
          _buildFilterButton('Sukses', 2),
          _buildFilterButton('Gagal', 3),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0), // Add margin here
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: _selectedFilterIndex == index
              ? const Color(0xffc70000) // Warna ketika aktif
              : const Color(0xfffaf9f6), // Warna ketika tidak aktif
        ),
        onPressed: () {
          setState(() {
            _selectedFilterIndex = index;
            // Filter berdasarkan indeks yang dipilih
            if (index == 0) {
              filteredTransactions = allTransactions;
            } else if (index == 1) {
              filteredTransactions = allTransactions
                  .where((transaction) => transaction['status'] == 'Dalam Proses')
                  .toList();
            } else if (index == 2) {
              filteredTransactions = allTransactions
                  .where((transaction) => transaction['status'] == 'Sukses')
                  .toList();
            } else if (index == 3) {
              filteredTransactions = allTransactions
                  .where((transaction) => transaction['status'] == 'Gagal')
                  .toList();
            }
          });
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: _selectedFilterIndex == index
                ? Colors.white // Warna font ketika aktif
                : Colors.black, // Warna font ketika tidak aktif
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins', // Ketebalan font
          ),
        ),
      ),
    );
  }

}


