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
    'September 2024',
    'October 2024',
    'November 2024',
    'December 2024',
  ];

  final List<Map<String, String>> transactions = [
    {'date': '2024-10-01', 'amount': '100', 'status': 'Sukses'},
    {'date': '2024-10-02', 'amount': '50', 'status': 'Dalam Proses'},
    // Add more transactions as needed for testing the bar chart
  ];

  @override
  void initState() {
    super.initState();
    // Set the default selected month
    selectedMonth = months[8]; // September 2024
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
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              _isSaldoVisible ? saldo : '********',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
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
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xfff5db84),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedMonth ?? months[0],
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xff353e43)),
            elevation: 2,
            style: const TextStyle(
              color: Color(0xff353e43),
              fontWeight: FontWeight.w600,
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
            underline: Container(),
            onChanged: (String? newValue) {
              setState(() {
                selectedMonth = newValue; // Update the selected month
              });
            },
            items: months.map<DropdownMenuItem<String>>((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              );
            }).toList(),
          ),
        ),
      ],
    );
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
              _buildTransactionText('Transaksi', 'Rp. 2.246.775', const Color(0xff198754)),
              _buildTransactionText('Profit', 'Rp. 484.475', const Color(0xffecb709)),
              const SizedBox(height: 10),
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
    // Data statis untuk bar
    List<double> barStates = [5, 3, 8, 6, 2, 7, 4, 9, 1, 3, 5, 2, 4, 6, 8]; // Contoh nilai

    // Variabel untuk melacak indeks bar yang sedang diklik
    int? clickedIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: SizedBox(
        height: 200, // Tinggi grafik batang
        child: BarChart(
          BarChartData(
            barGroups: List.generate(barStates.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    y: barStates[index], // Tinggi batang
                    colors: [
                      // Warna kuning jika bar yang sedang diklik, hijau jika tidak
                      (clickedIndex == index) ? const Color(0xffecb709) : const Color(0xff198754)
                    ],
                    width: 10,
                    borderRadius: BorderRadius.circular(4), // Sudut melengkung
                  ),
                ],
              );
            }),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: false), // Sembunyikan judul kiri
              topTitles: SideTitles(showTitles: false),  // Sembunyikan judul atas
              rightTitles: SideTitles(showTitles: false), // Sembunyikan judul kanan
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitles: (double value) {
                  // Tampilkan judul di bawah setiap bar
                  return '1 ${(value + 1).toInt()}';
                },
              ),
            ),
            gridData: FlGridData(show: true), // Tampilkan garis kisi
            borderData: FlBorderData(
              show: false, // Sembunyikan batas
            ),
            barTouchData: BarTouchData(
              touchCallback: (event, response) {
                // Tangani respons sentuhan
                if (response != null && response.spot != null &&
                    (event is FlTapUpEvent || event is FlLongPressEnd)) {
                  // Cek jika widget masih terpasang
                  if (mounted) {
                    setState(() {
                      // Dapatkan indeks bar yang diklik
                      clickedIndex = response.spot!.touchedBarGroupIndex;
                    });
                  }
                }
              },
            ),
          ),
        ),
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
