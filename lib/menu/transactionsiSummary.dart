import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class TransactionSummary extends StatefulWidget {
  const TransactionSummary({super.key});

  @override
  State<TransactionSummary> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionSummary> {
  bool _isSaldoVisible = true; // Controller for saldo visibility
  List<int> barStates = List.filled(20, 0); // 0 for green, 1 for amber
  String? selectedMonth;

  final List<String> months = [
    'January 2024',
    'February 2024',
    'March 2024',
    'April 2024',
    'May 2024',
    'June 2024',
    'July 2024',
    'August 2024',
    'Sept 2024',
    'October 2024',
    'November 2024',
    'December 2024',
  ];

  final List<Map<String, String>> transactions = [
    {'date': '2024-10-01', 'amount': '100', 'status': 'Sukses'},
    {'date': '2024-10-02', 'amount': '50', 'status': 'Dalam Proses'},
  ];

  Color _getBarColor(int index) {
    return barStates[index] == 0 ? const Color(0xff198754) : const Color(0xffecb709);
  }

  @override
  void initState() {
    super.initState();
    // Set the default selected month
    selectedMonth = months[8]; // September 2024
  }


  void _onBarTap(int index) {
    if (index >= 0 && index < barStates.length) { // Check if the index is within bounds
      setState(() {
        // Toggle between green (0) and amber (1)
        barStates[index] = barStates[index] == 0 ? 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590'; // Example saldo
    return Scaffold(
      backgroundColor: const Color(0xFFF8F2E9), // Background warna krem
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Saldo ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: Color(0xFF4e5558),
                fontFamily: 'Poppins', // Set font family to Poppins
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              _isSaldoVisible ? saldo : '********',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins', // Set font family to Poppins
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
                _isSaldoVisible ? Icons.remove_red_eye : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(Icons.add, color: Colors.grey),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            _buildSummaryContainer(saldo, transactions),
            const SizedBox(height: 20),
            _buildStatusContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryContainer(String saldo, List<Map<String, String>> transactions) {
    return Container(
      padding: const EdgeInsets.all(20.0), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown bulan
          _buildMonthDropdown(),
          const SizedBox(height: 20),
          _buildProfitIndicator(),
          const SizedBox(height: 20),
          _buildBarChart(transactions), // Add bar chart here
        ],
      ),
    );
  }

  Widget _buildMonthDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Adjust padding for better appearance
          decoration: BoxDecoration(
            color: const Color(0xfff5db84),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedMonth ?? months[0],  // Provide a default value if selectedMonth is null
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xff353e43)),
            elevation: 2,
            style: const TextStyle(
              color: Color(0xff353e43),
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
            underline: Container(), // Remove the underline
            onChanged: (String? newValue) {
              setState(() {
                selectedMonth = newValue; // Update the selected month
              });
            },
            items: months.map<DropdownMenuItem<String>>((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month), // Display full month name in the dropdown list
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

// Function to get abbreviated month name for display
  String getAbbreviatedMonth(String month) {
    switch (month) {
      case 'January 2024':
        return 'Jan 2024';
      case 'February 2024':
        return 'Feb 2024';
      case 'March 2024':
        return 'Mar 2024';
      case 'April 2024':
        return 'Apr 2024';
      case 'May 2024':
        return 'May 2024';
      case 'June 2024':
        return 'Jun 2024';
      case 'July 2024':
        return 'Jul 2024';
      case 'August 2024':
        return 'Aug 2024';
      case 'September 2024':
        return 'Sep 2024';
      case 'October 2024':
        return 'Oct 2024';
      case 'November 2024':
        return 'Nov 2024';
      case 'December 2024':
        return 'Dec 2024';
      default:
        return month; // Fallback in case month is not matched
    }
  }




  Widget _buildProfitIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 13.0,
              percent: 1.0,
              backgroundColor: Colors.transparent,
              progressColor: const Color(0xff198754), // Dark green
              circularStrokeCap: CircularStrokeCap.round,
            ),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 13.0,
              animation: true,
              percent: 0.18, // 18% progress
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "18%",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Profit",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: const Color(0xffecb709), // Yellow color
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        const SizedBox(width: 20.0),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTransactionText('Transaksi Sukses', '64', const Color(0xff198754)),
              _buildSalesText('Penjualan', 'Rp. 2.731.250'),
              _buildTransactionText('Transaksi', 'Rp. 2.246.775', const Color(0xff198754)),
              _buildTransactionText('Profit', 'Rp. 484.475', const Color(0xffecb709)),
              const SizedBox(height: 10), // Optional: add some space between Profit and Lihat Mutasi
              _buildMonthlyMutationButton(), // Add the button here
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionText(String label, String value, [Color? color]) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<Map<String, String>> transactions) {
    const barWidth = 8.0; // Width of each bar
    const barSpacing = 15.0; // Space between the bars

    // Calculate the number of transactions for each status
    int successCount = transactions.where((t) => t['status'] == 'Sukses').length;
    int processingCount = transactions.where((t) => t['status'] == 'Dalam Proses').length;
    int failedCount = transactions.where((t) => t['status'] == 'Gagal').length;

    // Create bar states
    List<double> barStates = [successCount.toDouble(), processingCount.toDouble(), failedCount.toDouble()];

    final totalWidth = (barStates.length * barWidth) + ((barStates.length - 1) * barSpacing); // Total width calculation

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: SizedBox(
        height: 200, // Height of the bar chart
        width: totalWidth, // Set total width for the horizontal scroll
        child: BarChart(
          BarChartData(
            barGroups: List.generate(barStates.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    y: barStates[index], // Y value from barStates
                    colors: [_getBarColor(index)],
                    width: barWidth, // Width of the bar
                    borderRadius: BorderRadius.circular(4), // Optional: round the corners
                  ),
                ],
              );
            }),
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Sukses';
                    case 1:
                      return 'Dalam Proses';
                    case 2:
                      return 'Gagal';
                    default:
                      return '';
                  }
                },
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            alignment: BarChartAlignment.spaceAround,
          ),
        ),
      ),
    );
  }

  Widget _buildSalesText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
          TextSpan(
            text: ' $value',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff4d4d4d),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyMutationButton() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Lihat Mutasi Saldo Bulanan',
            style: TextStyle(
              color: Color(0xffecb709), // Yellow color
              fontWeight: FontWeight.w600,
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xffecb709), // Underline text
              fontFamily: 'Poppins',
            ),
          ),
          WidgetSpan(
            child: SizedBox(width: 1), // Adjust the width for desired spacing
          ),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(left: 2.0), // Adjust spacing between text and icon
              child: Icon(
                Icons.double_arrow, // Appropriate icon
                color: Color(0xffecb709), // Yellow color to match text
                size: 14, // Adjust size to match text
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // Add horizontal margin
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '18 September 2024',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Poppins', // Set font family to Poppins
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStatusIndicator('Sukses', const Color(0xff198754)),
              const SizedBox(width: 10),
              _buildStatusIndicator('Proses', const Color(0xffecb709)),
              const SizedBox(width: 10),
              _buildStatusIndicator('Gagal', const Color(0xffc70000)),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
              Text(
                '64',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Penjualan',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
              Text(
                'Rp. 13.000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
              Text(
                'Rp. 10.210',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontFamily: 'Poppins', // Set font family to Poppins
          ),
        ),
      ],
    );
  }
}
