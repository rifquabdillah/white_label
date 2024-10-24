import 'package:flutter/material.dart';

import 'mSaldo.dart';

class transferBankScreen extends StatefulWidget {
  const transferBankScreen({super.key});

  @override
  _SaldoPageScreenState createState() => _SaldoPageScreenState();
}

class _SaldoPageScreenState extends State<transferBankScreen> {
  bool _isSaldoVisible = true;
  final TextEditingController _phoneController = TextEditingController();

  // Daftar produk dan jenis produknya dengan detail
  final Map<String, List<Map<String, String>>> _productTypes = {
    'Transfer Bank via Tiket Deposit': [],
    'Alfamart Indomaret via Plasamall': [],
    'Tukar Komisi': [],
    'Redeem Poin': [],
  };

  // Track the expanded state of each product
  final Set<String> _expandedProducts = {};

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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2), // Position of the shadow
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Set background transparent for shadow effect
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

      body: SingleChildScrollView( // Wrap the body content in a SingleChildScrollView
        padding: const EdgeInsets.all(0), // Remove vertical and horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Space between input and new content
            _buildNewContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewContent() {
    return Padding(
      padding: const EdgeInsets.all(0), // Remove all padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), // Space between title and content
          const SizedBox(height: 16), // Space between the text and the cards
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(0), // No padding
            child: Column( // Use Column instead of SingleChildScrollView
              children: [
                _buildThreeFilledCards(),
                const SizedBox(height: 40),
                _buildDepositField(),
                const SizedBox(height: 30),
                _buildTransactionSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeFilledCards() {
    return SizedBox(
      height: 200,
      child: Column(  // Maintain the Column for stacking the title and cards
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Transfer Bank via Tiket Deposit',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Color(0xff909EAE),
              ),
            ),
          ),
          const SizedBox(height: 10), // Space between title and cards
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align the row contents to the start (left)
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: _buildFilledCardWithImageAndButton(
                  title: '',
                  imagePath: 'assets/bca.png',
                  buttonText: 'OPEN',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: _buildFilledCardWithImageAndButton(
                  title: '',
                  imagePath: 'assets/mandiri.png',
                  buttonText: 'OPEN',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              _buildFilledCardWithImageAndButton(
                title: '',
                imagePath: 'assets/bri.png',
                buttonText: 'OPEN',
                onPressed: () {},
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilledCardWithImageAndButton({
    required String title,
    required String imagePath,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 90,
            height: 60,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff198754),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
              minimumSize: Size(0, 0),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 16.0),
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFDF7E6),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: 'Nominal Deposit',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: _phoneController.text.isEmpty ? FontWeight.normal : FontWeight.w600,
              color: _phoneController.text.isEmpty ? Colors.grey : const Color(0xFF363636),
            ),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(height: 10),
        _buildButtonDeposit(context),
      ],
    );
  }

  Widget _buildButtonDeposit(BuildContext context) => Center(
    child: SizedBox(
      width: 355,
      height: 35,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffecb709),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Request Tiket',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );

  Widget _buildTransactionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 26.0, right: 16.0),
          child: Text(
            'Riwayat Tiket',
            style: TextStyle(fontSize: 16.0,
                fontWeight: FontWeight.w600, color: Color(0xff909EAE)),
          ),
        ),
        const SizedBox(height: 10),
        _buildTransactionItem('S10 - 0822 4000 0201', '18 September 2024 - 20:33:24', 'Dalam Proses'),
        _buildTransactionItem('TD25 - 0812 2126 0284', '18 September 2024 - 18:43:32', 'Sukses'),
        _buildTransactionItem('S10 - 0822 4000 0201', '18 September 2024 - 20:33:24', 'Gagal'),
      ],
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status berada di bagian atas dengan latar belakang
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: getBackgroundColor(status), // Background based on status
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners on background
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(status),
                        fontSize: 12, // Text color based on status
                      ),
                    ),
                  ),
                  const SizedBox(height: 4), // Space between status and transaction details
                  Text(
                    nomorTransaksi,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
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
                // Action to view transaction details
              },
            ),
          ],
        ),
      ),
    );

  }
}
