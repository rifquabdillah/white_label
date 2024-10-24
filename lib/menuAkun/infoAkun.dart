import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoAkunScreen extends StatefulWidget {
  const InfoAkunScreen({super.key});

  @override
  _InfoAkunScreenState createState() => _InfoAkunScreenState();
}

class _InfoAkunScreenState extends State<InfoAkunScreen> {
  int _selectedIndex = 2; // Set default index to 2 for Profile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf7e6),
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFfdf7e6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFfdf7e6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure content is spaced properly
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile info with picture, name, and status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildProfileIcon(context),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'PX14025',
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins'),
                                              ),
                                              TextSpan(
                                                text: ' - Ferry Febrian N',
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.notifications),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Name, Address, Registered Number Section in Container
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name Input Field
                                Text(
                                  "Isi nama sesuai KTP untuk membuka fitur lebih lengkap",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: "Ferry Febrian Nagara",
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Address Field
                                Text(
                                  "Memudahkan pengiriman ketika ada hadiah promo",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: "Jl. Sulaksana Baru I no. 5",
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.purple, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Registered Number
                                Text(
                                  "Nomor Terdaftar",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "0822 4000 0201",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Save Button inside Container filling the screen
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {},
                          child: Text(
                            "SIMPAN",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: const BoxDecoration(
            color: Color(0xFFc70000),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'FF', // Placeholder for profile initials or image
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              _changeProfileImage(); // Call function to change image
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white, // Background color for camera icon
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFc70000), // Border color matching main circle
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Color(0xFFc70000), // Camera icon color
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _changeProfileImage() {
    print("Change profile image");
  }
}
