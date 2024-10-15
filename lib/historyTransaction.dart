import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'account.dart';
import 'menu/transactionsiSummary.dart'; // Import this for BackdropFilter

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required List<Map<String, String>> transactions});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isSaldoVisible = true; // Controller for phone input
  final TextEditingController _phoneController = TextEditingController();
  int _selectedIndex = 1;

  // All transactions defined here
  final List<Map<String, String>> allTransactions = [
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
    {
      'nomorTransaksi': 'FF130 - 1143407304',
      'tanggal': '16 September 2024 - 08:40:26',
      'status': 'Sukses'
    },
    {
      'nomorTransaksi': 'FF150 - 1143407304',
      'tanggal': '16 September 2024 - 08:40:26',
      'status': 'Gagal'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) { // History page index
        Navigator.pushReplacement( // Use pushReplacement to remove the current screen
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HistoryPage(transactions: [],),
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
      } else if (index == 2) { // Account page index
        Navigator.pushReplacement( // Use pushReplacement here as well
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
      } else {
        _selectedIndex = index; // Update selected index for other items
      }
    });
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
                  elevation: 0,
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
                          const Icon(Icons.add, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
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
              _buildIconWithText(Icons.headset_mic_outlined, "Support", 3),
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
                  onPressed: () {
                    // Logic to handle search functionality
                    if (_validatePhoneNumber(_phoneController.text)) {
                      _searchTransactionsByPhone(_phoneController.text);
                    }
                  },
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

  void _searchTransactionsByPhone(String phoneNumber) {
    List<Map<String, String>> filteredTransactions = allTransactions.where((
        transaction) {
      return transaction['nomorTransaksi']!.contains(phoneNumber);
    }).toList();

    // Show the filtered results (you can display them in a ListView or another widget)
    if (filteredTransactions.isNotEmpty) {
      // Handle displaying the filtered transactions
    } else {
      // Handle case where no transactions are found
    }
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
    {
      'nomorTransaksi': 'FF130 - 1143407304',
      'tanggal': '16 September 2024 - 08:40:26',
      'status': 'Sukses'
    },
    {
      'nomorTransaksi': 'FF150 - 1143407304',
      'tanggal': '16 September 2024 - 08:40:26',
      'status': 'Gagal'
    },
  ];

  late List<
      Map<String, String>> filteredTransactions; // To hold filtered results

  @override
  void initState() {
    super.initState();
    filteredTransactions = allTransactions; // Initialize filtered list
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(
          child: ListView.builder(
            itemCount: filteredTransactions.length,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                fontFamily: 'Poppins',
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
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            filteredTransactions[index]['tanggal']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
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
        ),
      ],
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
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
            filteredTransactions =
                allTransactions.where((transaction) => transaction['status'] ==
                    'Dalam Proses').toList();
          } else if (index == 2) {
            filteredTransactions =
                allTransactions.where((transaction) => transaction['status'] ==
                    'Sukses').toList();
          } else if (index == 3) {
            filteredTransactions =
                allTransactions.where((transaction) => transaction['status'] ==
                    'Gagal').toList();
          }
        });
      },
      child: Text(
        label,
        style: TextStyle(
          color: _selectedFilterIndex == index
              ? Colors.white // Warna font ketika aktif
              : Colors.black, // Warna font ketika tidak aktif
          fontWeight: FontWeight.w600, // Ketebalan font
        ),
      ),
    );
  }
}


