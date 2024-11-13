import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:white_label/menuSaldo/mSaldo.dart';
import 'detailProsesTransaksi.dart';
import 'detailTransaksi.dart';
import 'detailTransaksiGagal.dart';
import 'mutasiMenu.dart';

class TransactionSummary extends StatefulWidget {
  const TransactionSummary({super.key});

  @override
  State<TransactionSummary> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionSummary> {
  bool _isSaldoVisible = true; // Controller for saldo visibility
  String? selectedMonth;
  int? clickedIndex;

  final List<String> months = [
    'Januari 2024',
    'Februari 2024',
    'Maret 2024',
    'April 2024',
    'Mei 2024',
    'Juni 2024',
    'Juli 2024',
    'Agustus 2024',
    'September 2024',
    'Oktober 2024',
    'November 2024',
    'Desember 2024',
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
    selectedMonth = months[0]; // September 2024
  }

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590'; // Example saldo
    return Scaffold(
      backgroundColor: const Color(0xFFF8F2E9), // Background warna krem
      appBar: AppBar(
        backgroundColor: Color(0xffFAF9F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff353E43)
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when tapped
          },
        ),
        title: Row(
          children: [
            const Text(
              'Saldo ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFF4e5558),
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              _isSaldoVisible ? saldo : '********',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
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
                _isSaldoVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off,
                color:Color(0xff909EAE),
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
        color: Color(0xffFAF9F6), // Background color of the container
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
    return
      Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
      children: [
        // Add a Text widget for the label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xfff5db84),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedMonth,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: Color(0xff353e43)), // Reduced icon size
            elevation: 2,
            style: const TextStyle(
              color: Color(0xff353e43),
              fontWeight: FontWeight.w600,
              fontSize: 14,
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

  String formatSelectedMonth(String month) {
    // Mapping full month names to abbreviated ones
    final Map<String, String> monthAbbreviations = {
      'Januari 2024': 'Jan 2024',
      'Februari 2024': 'Feb 2024',
      'Maret 2024': 'Mar 2024',
      'April 2024': 'Apr 2024',
      'Mei 2024': 'Mei 2024',
      'Juni 2024': 'Jun 2024',
      'Juli 2024': 'Jul 2024',
      'Agustus 2024': 'Agu 2024',
      'September 2024': 'Sep 2024',
      'Oktober 2024': 'Okt 2024',
      'November 2024': 'Nov 2024',
      'Desember 2024': 'Des 2024',
    };

    return monthAbbreviations[month] ?? month; // Return abbreviated month or original month if not found
  }
  void selectMonth(String selectedMonth) {
    formatSelectedMonth(selectedMonth);
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
              percent: 0.50, // 18% progress
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "50%",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                      color: Color(0xffECB709),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Profit",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffECB709),
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
              _buildMonthlyMutationButton(context), // Add the button here
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
              fontWeight: FontWeight.w300,
              color: Color(0xff353E43),
              fontFamily: 'Poppins',
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color ?? Color(0xff353E43),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<Map<String, String>> transactions) {
    // Data statis untuk bar
    List<double> barStates = [1, 3,3, 1, 2, 1, 4, 7, 1, 3, 5, 2, 4, 6, 8,10,5,5,5,5]; // Contoh nilai

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: SizedBox(
        height: 200,
        width: double.infinity, // Height of the bar chart
        child: BarChart(
          BarChartData(
            barGroups: List.generate(barStates.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: barStates[index], // Height of the bar
                    color: (clickedIndex == index)
                        ? const Color(0xffecb709)
                        : const Color(0xff198754),
                    width: 10,
                    borderRadius: BorderRadius.circular(4), // Rounded corners
                  ),
                ],
              );
            }),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide left titles
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide top titles
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide right titles
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,
                  getTitlesWidget: (value, meta) {
                    return Text(' ${(value + 1).toInt()}'); // Update title display
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(
              show: false, // Hide border
            ),
            barTouchData: BarTouchData(
              touchCallback: (event, response) {
                // Handle touch response
                if (response != null && response.spot != null &&
                    (event is FlTapUpEvent || event is FlLongPressEnd)) {
                  // Check if the widget is still mounted
                  if (mounted) {
                    setState(() {
                      // Get the index of the tapped bar
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

  Widget _buildMonthlyMutationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the mutasiMenu page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MutasiMenu()), // Adjust MutasiMenu according to your class name in mutasiMenu.dart
        );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Lihat Mutasi Saldo Bulanan',
              style: TextStyle(
                color: Color(0xffecb709),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xffecb709),
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
      ),
    );
  }

  Widget _buildStatusContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // Add horizontal margin
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffFAF9F6),
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
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xff909EAE),
              fontFamily: 'Poppins', // Set font family to Poppins
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStatusIndicator(
                'Sukses',
                '1',
                const Color(0xff198754),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailTransaksi()),
                  );
                },
              ),
              const SizedBox(width: 10),
              _buildStatusIndicator('Proses',
                  '0',
                  const Color(0xffecb709),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailProsesTransaksi()),
                  );
                },

              ),
              const SizedBox(width: 10),
              _buildStatusIndicator(
                  'Gagal',
                  '0',
                  const Color(0xffc70000),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailTransaksiGagal()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Color(0xff353E43),
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
              Text(
                '64',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
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
                  color: Color(0xff353E43),
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
              Text(
                'Rp. 13.000',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
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
                  color: Color(0xff353E43),
                  fontFamily: 'Poppins', // Set font family to Poppins
                ),
              ),
              Text(
                'Rp. 10.210',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
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

  Widget _buildStatusIndicator(String label, String jumlah, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
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
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(width: 4),
          Text(
            jumlah,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

}
