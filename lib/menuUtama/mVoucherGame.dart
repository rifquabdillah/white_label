import 'package:flutter/material.dart';

class VoucherGameScreen extends StatefulWidget {
  @override
  _VoucherGameScreenState createState() => _VoucherGameScreenState();
}

class _VoucherGameScreenState extends State<VoucherGameScreen> {
  bool _isSaldoVisible = true; // State to manage balance visibility

  @override
  Widget build(BuildContext context) {
    const String saldo = '2.862.590'; // Menyimpan saldo

    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Stack(
          children: [
            AppBar(
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
                            _isSaldoVisible = !_isSaldoVisible; // Toggle visibility
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
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              toolbarHeight: 60,
              elevation: 0, // Menghilangkan bayangan
            ),
          ],
        ),
      ),
      body: _buildGridOptions(),
    );
  }

  Widget _buildGridOptions() {
    const List<Map<String, dynamic>> options = [
      {'title': 'PUBGM', 'image': 'assets/pubg.jpg'},
      {'title': 'Mobile Legends', 'image': 'assets/ml.jpg'},
      {'title': 'Free Fire', 'image': 'assets/ff.jpg'},
      {'title': 'Lainnya', 'image': ''}, // You can specify an image if needed
    ];

    return Container(
      color: const Color(0xFFfdf7e6),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: GridView.builder(
        itemCount: options.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust as needed
          childAspectRatio: 0.75, // Adjust to maintain the aspect ratio of items
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return _buildGridItem(options[index]['title'], options[index]['image']);
        },
      ),
    );
  }

  Widget _buildGridItem(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event, e.g., navigate to a detail screen
      },
      child: Container(
        width: 100, // Fixed width for uniformity
        height: 130, // Fixed height for uniformity
        decoration: BoxDecoration(
          color: const Color(0xffFDF7E6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset for shadow (x, y)
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
          children: [
            // Use a Container to maintain a consistent size for the image
            Container(
              width: 80, // Fixed image width
              height: 80, // Fixed image height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imagePath.isNotEmpty
                    ? Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                )
                    : Container(color: Colors.grey[300]), // Placeholder for no image
              ),
            ),
            const SizedBox(height: 8), // Space between image and text
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}
