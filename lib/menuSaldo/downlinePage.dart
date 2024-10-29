import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mSaldo.dart';

class downlinePage extends StatefulWidget {
   // Add this line

  const downlinePage({super.key, }); // Update the constructor

  @override
  _downlinePageState createState() => _downlinePageState();
}

class _downlinePageState extends State<downlinePage> {
  bool _isSaldoVisible = true;
  final DateTime transferLimitDateTime = DateTime(2024, 10, 24, 17, 40);
  int _selectedFilterIndex = 0;

  List<Map<String, String>> allDownline = [
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

  late List<Map<String, String>> filteredDownline; // To hold filtered results

  @override
  void initState() {
    super.initState();
    filteredDownline = allDownline; // Initialize filtered list
  }


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
          _buildFourFilledCards(context),
          const SizedBox(height: 10),
          _buildFilterButtons(),
          const SizedBox(height: 10),
          _buildDownlineSection(),
        ],
      ),

    );
  }

  Widget _buildFourFilledCards(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Color(0XFFfaf9f6), // Set your desired background color here
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            offset: Offset(0, 0), // Shadow position (x, y)
            blurRadius: 1.0, // How soft the shadow edges are
            spreadRadius: 3.0, // How much the shadow spreads
          ),
        ],
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add horizontal padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space evenly between the columns
            children: [
              // Left Column
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Space cards evenly within the column
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the transaction history screen when the card is tapped
                    },
                    child: _buildCommissionCard(
                      title: 'Komisi Saat Ini',
                      commissionAmount: '328.025', // Commission amount
                      boxColor: Colors.blue, // Color for the first card's box
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // Handle tap for Transaksi Hari ini
                    },
                    child: _buildCommissionCard(
                      title: 'Transaksi Jaringan',
                      commissionAmount: '72', // Commission amount for the second card
                      boxColor: Colors.green, // Color for the second card's box
                    ),
                  ),
                  const SizedBox(height: 8), // Add space between the last card and the bottom
                ],
              ),
              // Right Column
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Space cards evenly within the column
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle tap for another action
                    },
                    child: _buildCommissionCard(
                      title: 'Jumlah Downline',
                      commissionAmount: '174', // Commission amount for the third card
                      boxColor: Colors.red, // Color for the third card's box
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // Handle tap for another action
                    },
                    child: _buildCommissionCard(
                      title: 'Downline Aktif',
                      commissionAmount: '72', // Commission amount for the fourth card
                      boxColor: Colors.orange, // Color for the fourth card's box
                    ),
                  ),
                  const SizedBox(height: 8), // Add space between the last card and the bottom
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCommissionCard({
    required String title,
    required String commissionAmount,
    required Color boxColor, // Add boxColor parameter
  }) {
    return Container(
      width: 180, // Set a fixed width for the card
      height: 80, // Set a fixed height for the card
      decoration: BoxDecoration(
        color: Color(0xfffaf9f6), // Background color for the card
        borderRadius: BorderRadius.circular(8), // Rounded corners for the card
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Shadow color
            offset: Offset(0, 2), // Shift the shadow downwards
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff909EAE),
                  ),
                ),
                Container(
                  width: 24, // Width of the colored box
                  height: 24, // Height of the colored box
                  decoration: BoxDecoration(
                    color: boxColor, // Use the passed box color
                    borderRadius: BorderRadius.circular(4), // Rounded corners for the small box
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Space between title and amount
            Text(
              commissionAmount,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xff353E43), // Black text for nominal
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<Widget> _buildFilledCard({
    required String title,
    String? newSale, // New parameter for new sale
    String? newSaleAmount, // Amount for new sale
    required String label1,
    required String profit,
    required String label2,
    required String trxSuccess,
  }) async {
    return Container(
      width: 200, // Set a fixed width for the card
      height: 120, // Set a fixed height for the card
      decoration: BoxDecoration(
        color: Color(0xfffaf9f6), // Background color for the card
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Shadow color
            offset: Offset(0, 2), // Shift the shadow downwards
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

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // Add top padding for spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
        children: [
          _buildFilterButton('Semua Downline', 0),
          _buildFilterButton('Downline Langsung', 1),
          _buildFilterButton('Aktif Hari Ini', 2),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0), // Reduce margin between buttons
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          minimumSize: Size(100, 40), // Set a fixed width and height for the button
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0), // Add padding for larger button size
          backgroundColor: _selectedFilterIndex == index
              ? const Color(0xffc70000) // Color when active
              : const Color(0xfffaf9f6), // Color when inactive
        ),
        onPressed: () {
          setState(() {
            _selectedFilterIndex = index;
            // Filter based on the selected index
            if (index == 0) {
              filteredDownline = allDownline;
            } else if (index == 1) {
              filteredDownline = allDownline
                  .where((transaction) => transaction['status'] == 'Dalam Proses')
                  .toList();
            } else if (index == 2) {
              filteredDownline = allDownline
                  .where((transaction) => transaction['status'] == 'Sukses')
                  .toList();
            } else if (index == 3) {
              filteredDownline = allDownline
                  .where((transaction) => transaction['status'] == 'Gagal')
                  .toList();
            }
          });
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12, // Slightly reduce font size
            color: _selectedFilterIndex == index
                ? Colors.white // Text color when active
                : Colors.black, // Text color when inactive
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins', // Font weight
          ),
        ),
      ),
    );
  }

  Widget _buildDownlineSection() {
    return Expanded( // Wrap with Expanded
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 26.0, right: 16.0),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _showTransactionDetails(context, 'Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '178.245', '28', '7');
              },
              child: _buildTransactionItem('Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '178.245', '28', '7'),
            ),
            GestureDetector(
              onTap: () {
                _showTransactionDetails(context, 'Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '28.565', '22', '0');
              },
              child: _buildTransactionItem('Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '28.565', '22', '0'),
            ),
            GestureDetector(
              onTap: () {
                _showTransactionDetails(context, 'Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '178.245', '28', '7');
              },
              child: _buildTransactionItem('Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '178.245', '28', '7'),
            ),
            GestureDetector(
              onTap: () {
                _showTransactionDetails(context, 'Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '28.565', '22', '0');
              },
              child: _buildTransactionItem('Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '28.565', '22', '0'),
            ),
            GestureDetector(
              onTap: () {
                _showTransactionDetails(context, 'Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '178.245', '28', '7');
              },
              child: _buildTransactionItem('Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '178.245', '28', '7'),
            ),
            GestureDetector(
              onTap: () {
                _showTransactionDetails(context, 'Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '28.565', '22', '0');
              },
              child: _buildTransactionItem('Radian Cell', 'Kode Member PX14217', 'Kode Upline PX14025', '28.565', '22', '0'),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTransactionItem(String nama, String kodeMember, String kodeUpline, String saldo, String transaksi, String downline) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding to prevent touching the edges
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0), // Margin between items
        padding: const EdgeInsets.all(16.0), // Padding inside the box
        decoration: BoxDecoration(
          color: const Color(0xFFf0f0f0), // Background color for the item
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.15),
              spreadRadius: 4,
              blurRadius: 3,
              offset: const Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4), // Space between status and transaction details
                  Text(
                    nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    kodeMember,
                    style: const TextStyle(
                      color: Color(0xff353E43),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    kodeUpline,
                    style: const TextStyle(
                      color: Color(0xff909EAE),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Right Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 4), // Space between status and transaction details

                  // Saldo Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Saldo: ',
                        style: const TextStyle(
                          color: Color(0xff909EAE), // Gray color for the label
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        saldo,
                        style: const TextStyle(
                          color: Color(0xffECB709), // Yellow color for the value
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  // Transaksi Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Transaksi hari ini: ',
                        style: const TextStyle(
                          color: Color(0xff909EAE), // Gray color for the label
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        transaksi,
                        style: const TextStyle(
                          color: Color(0xff198754), // Green color for the value
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // Downline Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Jumlah downline: ',
                        style: const TextStyle(
                          color: Color(0xff909EAE), // Gray color for the label
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        downline,
                        style: const TextStyle(
                          color:Color(0xff198754), // Green color for the value
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, String nama, String kodeMember, String kodeUpline, String saldo, String transaksi, String downline) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6, // Increased height for additional content
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Setting Mark Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: Color(0xff353E43),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const Divider(),

              const SizedBox(height: 16),
              Center(
                child: Text(
                  '$nama',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: Color(0xff353E43),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Extract only the code for Kode Member and Kode Upline
              _buildDetailRow('Kode Member', kodeMember.split(' ').last),
              _buildDetailRow('Kode Upline', kodeUpline.split(' ').last),
              _buildDetailRow('Saldo', saldo),
              _buildDetailRow('Transaksi Hari Ini', transaksi),
              _buildDetailRow('Jumlah Downline', downline),
              const SizedBox(height: 20),
              // Add text for price information
              const Text(
                'Harga downline akan dinaikkan sesuai mark up',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xff353E43),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300// Set font style to italic
                ),
              ),
              const SizedBox(height: 10),
              // TextField for inputting price
              TextField(
                decoration: InputDecoration(
                  hintText: 'Harga',
                  hintStyle: TextStyle(
                    color: Color(0xff909EAE), // Set the hint text color to gray
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black, // Set the entered text color to black
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly between buttons
                  children: [
                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the modal
                      },
                      child: const Text(
                        'Batalkan',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color(0xffECB709) ,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xffECB709)// Underline the text
                        ),
                      ),
                    ),
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        // Add save functionality here
                        Navigator.of(context).pop(); // Optionally close the modal after saving
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffecb709), // Background color for the button
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


// Helper method to build detail rows
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color:Color(0xff909EAE),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: Color(0xff353E43),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }




}

