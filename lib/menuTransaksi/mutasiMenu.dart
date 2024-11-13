import 'package:flutter/material.dart';
import 'package:white_label/menuSaldo/mSaldo.dart';


class MutasiMenu extends StatefulWidget {
  const MutasiMenu({super.key});

  @override
  _MutasiMenuState createState() => _MutasiMenuState();
}

class _MutasiMenuState extends State<MutasiMenu> {
  bool _isSaldoVisible = true;
  final String saldo = '2.862.590';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffdf7e6),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(73.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0XFFfaf9f6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color
                  offset: Offset(0, 2), // Shadow offset
                  blurRadius: 4, // Shadow blur radius
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent, // Make background transparent
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Saldo ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF4e5558),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        _isSaldoVisible ? saldo : '********',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color(0xff353E43),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 25.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSaldoVisible = !_isSaldoVisible; // Toggle visibility
                          });
                        },
                        child: Icon(
                          _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off,
                          color: Color(0xff909EAE),
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
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xff353E43),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              toolbarHeight: 60,
              elevation: 0, // Remove the shadow from AppBar itself
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Range Picker and Filter Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the Row
              children: [
                Expanded(
                  child: Container(
                    height: 20, // Set the height to match the text size
                    decoration: BoxDecoration(
                      color: Color(0xfff5db84),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: DropdownButton<String>(
                      value: '18/09/24',
                      onChanged: (String? newValue) {},
                      isExpanded: true, // Expand to fill the container
                      underline: SizedBox(), // Remove underline
                      iconSize: 24, // Set icon size for the dropdown arrow
                      items: <String>['18/09/24', '19/09/24', '20/09/24']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center( // Center the text inside the dropdown
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14, // Adjust font size as needed
                                color: Color(0xff353E43),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 5), // Space between the first dropdown and the text
                Text(
                  's/d',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14, // Match font size with dropdowns
                    color: Color(0xffabb4bc),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Container(
                    height: 20, // Set the height to match the text size
                    decoration: BoxDecoration(
                      color: Color(0xfff5db84),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: DropdownButton<String>(
                      value: '19/09/24', // Update as necessary
                      onChanged: (String? newValue) {},
                      isExpanded: true, // Expand to fill the container
                      underline: SizedBox(), // Remove underline
                      iconSize: 24, // Set icon size for the dropdown arrow
                      items: <String>['18/09/24', '19/09/24', '20/09/24']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center( // Center the text inside the dropdown
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14, // Adjust font size as needed
                                color: Color(0xff353E43),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      _showFilterDialog(); // Ensure this method is called
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffecb709),
                      minimumSize: Size(0, 30), // Set minimum height, width can be 0
                      padding: EdgeInsets.symmetric(horizontal: 8.0), // Optional padding around the content
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Fit the Row to its content
                      children: [
                        Icon(Icons.filter_list_alt, color:Color(0xffFAF9F6)),
                        SizedBox(width: 5), // Space between icon and text
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontFamily: 'Poppins', // Replace with your font family
                            fontSize: 14,
                            fontWeight: FontWeight.w400,// Adjust to your desired size
                            color: Color(0xfffaf9f6), // Replace with your desired color
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffecb709),
                      minimumSize: Size(0, 30), // Set minimum height, width can be 0
                      padding: EdgeInsets.symmetric(horizontal: 8.0), // Optional padding around the content
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // Adjust the radius here for a slight rounding
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Fit the Row to its content
                      children: [
                        Icon(Icons.file_download_outlined, color: Color(0xffFAF9F6)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Transaction List
              Expanded(
                child: ListView(
                  children: [
                    transactionCard(
                        'Transaksi',
                        'S10 - 0822 4000 0201',
                        '18 September 2024 - 16:40:28',
                        '10.210',
                        '2.862.590',
                        Color(0xffc70000)),
                    const SizedBox(height: 8),
                    transactionCard(
                        'Transaksi',
                        'TD25 - 0812 2126 0284',
                        '18 September 2024 - 13:37:28',
                        '24.650',
                        '2.872.800',
                        Color(0xffc70000)),
                    const SizedBox(height: 8),
                    transactionCard(
                        'Refund',
                        'S10 - 0822 4000 0201',
                        '18 September 2024 - 09:44:19',
                        '10.210',
                        '2.897.450',
                        Color(0xff198754)),
                    const SizedBox(height: 8),
                    transactionCard(
                        'Transaksi',
                        'S10 - 0822 4000 0201',
                        '18 September 2024 - 09:44:13',
                        '10.210',
                        '2.887.240',
                        Color(0xffc70000)),
                    const SizedBox(height: 8),
                    transactionCard(
                        'Kirim Saldo',
                        'PX148977 - 081 2126 0284',
                        '18 September 2024 - 09:44:13',
                        '1.000.000',
                        '2.897.450',
                        Color(0xffc70000)),
                    const SizedBox(height: 8),
                    transactionCard(
                        'Tiket Deposit',
                        'BCA 2801868888',
                        '18 September 2024 - 08:16:42',
                        '3.500.817',
                        '3.897.450',
                        Color(0xff198754),),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget transactionCard(String title, String subtitle, String date, String amount, String balance, Color amountColor) {
    return GestureDetector(
      onTap: () {
      },
      child: SizedBox(
        width: 400, // Set your desired width
        height: 100, // Set your desired height
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 0), // Position of shadow
                  ),
                ],// Rounded corners
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left Side Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: amountColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff353E43)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                date,
                                style: TextStyle(fontSize: 12,
                                    fontFamily: 'Poppins',
                                    color: Color(0xff909EAE)),
                              ),
                            ],
                          ),
                            ],
                          ),

                          // Right Side Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end, // Aligns the content to the end
                            children: [
                              // Detail text
                              Text(
                                'Detail >>',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color:  Color(0xffECB709),
                                ),
                              ),
                              // Amount and balance texts aligned together
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end, // Aligns amount and balance to the end
                                children: [
                                  Text(
                                    '($amount)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff353e43),
                                    ),
                                  ),
                                  // Balance text
                                  Text(
                                    'Sisa saldo: $balance',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color:Color(0xff909EAE),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                        ],
                      ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }



  void _showFilterDialog() {
    List<String> categories = [
      'Transaksi',
      'Refund',
      'Kirim Saldo',
      'Terima Saldo',
      'Tiket Deposit',
      'Tukar Komisi',
      'Lainnya'
    ];

    List<String> jenis = [
      'Saldo Masuk',
      'Saldo Keluar',
    ];

    List<bool> selectedCategories = List<bool>.filled(categories.length, false);
    List<bool> selectedJenis = List<bool>.filled(jenis.length, false); // Track selected checkboxes

    // Create a TextEditingController for the filter text field
    TextEditingController filterController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the dialog to take full height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // Rounded corners at the top
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75, // Set height to 75% of the screen height
          padding: const EdgeInsets.all(12.0), // Add some padding for content
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: filterController, // Set the controller to the TextField
                decoration: InputDecoration(
                  labelText: 'Filter Mutasi',
                ),
              ),
              SizedBox(height: 4), // Reduced space before category label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff909EAE),
                    fontFamily: 'Poppins', // Text color
                  ),
                ),
              ),
              SizedBox(height: 2),
              ...categories.map((category) {
                int index = categories.indexOf(category);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2), // Adjust vertical space between checkboxes
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedCategories[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedCategories[index] = value!; // Update the selected state
                          });
                        },
                      ),
                      SizedBox(width: 8), // Space between checkbox and text
                      Expanded(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins', // Set font to Poppins
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 8), // Space before the Jenis section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Jenis',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff909EAE),
                    fontFamily: 'Poppins', // Text color
                  ),
                ),
              ),
              SizedBox(height: 2), // Space before checkboxes
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align checkboxes to the start
                children: jenis.map((jenisItem) {
                  int index = jenis.indexOf(jenisItem);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1), // Space between checkboxes
                    child: Row(
                      children: [
                        Checkbox(
                          value: selectedJenis[index],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedJenis[index] = value!; // Update the selected state
                            });
                          },
                        ),
                        Text(
                          jenisItem,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins', // Set font to Poppins
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 5), // Space before the apply button
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the Row contents
                children: [
                  GestureDetector(
                    onTap: () {
                      // Logic to reset filters goes here
                      setState(() {
                        // Resetting the selections
                        selectedCategories.fillRange(0, selectedCategories.length, false);
                        selectedJenis.fillRange(0, selectedJenis.length, false);
                        filterController.clear(); // Clear the filter input
                      });
                    },
                    child: Text(
                      'Reset Filter',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xffecb709),
                        color: Color(0xffecb709), // Customize text color
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins', // Customize text size
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Space between text and button (adjustable)
                  ElevatedButton(
                    onPressed: () {
                      // Logic to apply the selected filters goes here
                      String filterValue = filterController.text.trim(); // Get the filter value
                      // Use filterValue and selectedCategories/selectedJenis for filtering logic
                      // For demonstration, we can log the selected filters
                      print("Filter Value: $filterValue");
                      print("Selected Categories: $selectedCategories");
                      print("Selected Jenis: $selectedJenis");

                      // Here, you would typically filter your data based on the selections
                      // e.g., filtering a list of transactions based on the criteria above.

                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xffecb709), // Customize button color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Customize button size
                    ),
                    child: Text(
                      'Filter Mutasi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins', // Customize the font size here
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }





}
