import 'package:flutter/material.dart';
import 'detailRedeemPoin.dart';
import 'mSaldo.dart';

class RedeemPoin extends StatefulWidget {
  const RedeemPoin({super.key});

  @override
  _RedeemPoinState createState() => _RedeemPoinState();
}

class _RedeemPoinState extends State<RedeemPoin> {
  bool _isSaldoVisible = true;
  final DateTime transferLimitDateTime = DateTime(2024, 10, 24, 17, 40);
  late TextEditingController filterController;

  @override
  void initState() {
    super.initState();
    filterController = TextEditingController(); // Initialize the controller
  }

  @override
  void dispose() {
    filterController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590';
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF9F6),
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
                    _isSaldoVisible ? Icons.remove_red_eye : Icons.visibility_off,
                    color: const Color(0xff909EAE),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SaldoPageScreen()),
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
      body: SingleChildScrollView( // Membuat konten dapat digulir
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 0),
            _buildNewContent(context),
            const SizedBox(height: 30),
            _buildRedeemPoinCard(),
            const SizedBox(height: 30),
            _buildAdditionalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewContent(BuildContext context) {
    String redeemPoint = '4.126'; // Poin yang dimiliki
    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: const Color(0xffFAF9F6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Poin yang kamu miliki sekarang:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: const Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              redeemPoint,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: const Color(0xff353E43),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildRedeemPoinCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 16.0, top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        color: const Color(0xffFAF9F6),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5, // Set height to 50% of the screen height
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Redeem Poin ke Saldo',
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
                              Navigator.of(context).pop(); // Close the bottom sheet
                            },
                          ),
                        ],
                      ),
                      const Divider(), // Divider line

                      // Text above the TextField
                      const SizedBox(height: 16),
                      const Text(
                        'Berapa Poin yang kamu redeem ke saldo?',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Color(0xff353E43),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),

                      TextField(
                        controller: filterController, // Use the same controller for input
                        keyboardType: TextInputType.number, // Allow only numbers
                        decoration: InputDecoration(
                          hintText: 'Jumlah poin',
                          hintStyle: TextStyle(
                            color: Color(0xff909EAE),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 20, // Set the hint text color to gray
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff353E43), width: 2.0), // Customize the underline color when focused
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff353E43), width: 2.0), // Customize the underline color when enabled
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: filterController.text.isNotEmpty ? FontWeight.w600 : FontWeight.w600, // Make text bold if not empty
                          fontSize: 20, // Match the hint text size
                          color: Color(0xff353E43), // Text color
                        ),
                      ),


                      const SizedBox(height: 16),
                      // Minimum points text
                      const Text(
                        'Minimal poin yang ditukar adalah 50.000 poin',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff909EAE),
                        ),
                      ),
                      const Spacer(), // Spacer to push the button down
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            String redeemValue = filterController.text.trim();
                            Future.delayed(Duration(milliseconds: 300), () {
                              // Navigate to detailRedeemPoin page
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => detailRedeemPoin(redeemValue: redeemValue), // Pass the redeemValue to the new page
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffecb709),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                          ),
                          child: const Text(
                            'Redeem ke Saldo',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Redeem Poin ke Saldo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff353E43),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color(0xff353E43),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAdditionalSection() {
    return Container(
      color: const Color(0xFFFDF7E6),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Atau redeem poin ke hadiah berikut:',
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Color(0xff909EAE),
                fontWeight: FontWeight.w400,
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
              _buildInfoCard(),
              _buildInfoCard(),
              _buildInfoCard(),
              _buildInfoCard(),
            ],
          ),
          const SizedBox(height: 10),
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
          color: const Color(0xff34C759),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xff34C759),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            // Tambahkan konten tambahan di dalam card di sini jika diperlukan
          ],
        ),
      ),
    );
  }

}
