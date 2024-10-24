import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class infoAkun extends StatefulWidget {
  const infoAkun({super.key});

  @override
  _infoAkunState createState() => _infoAkunState();
}

class _infoAkunState extends State<infoAkun> {
  Color textColor = Colors.grey; // Initial text color
  Color borderColor = Colors.black54; // Initial border color
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  bool isSave = false; // Track if the user is registered
  bool showWarning = false; // Track if the warning message should be shown

  @override
  void initState() {
    super.initState();
    // Listener to change the text color based on input
    _nameController.addListener(() {
      setState(() {
        textColor = _nameController.text.isEmpty ? Colors.grey : Colors.black; // Change text color based on input
      });
    });
  }

  void _checkSave() {
    // This function should contain your logic to check if the number is registered
    setState(() {
      isSave = _phoneController.text != "123456789"; // Example logic to check registration
      borderColor = isSave ? Colors.red : Colors.black54; // Change border color to red if unregistered
    });
  }

  void _onSavePressed() {
    // This function is called when the login button is pressed
    _checkSave(); // Check registration status
    setState(() {
      showWarning = isSave; // Show warning if the number is unregistered
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: const Color(0xFFfdf7e6),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Adding the profile card in the AppBar
                ],
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous page
                },
              ),
              toolbarHeight: 100,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(), // Column for phone number input
            const SizedBox(height: 3),
            _buildNewContent(),
            const SizedBox(height: 100),
            _buildButtonMember(context),// Space between input and new content
            // New content below the phone number field
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Material(
      elevation: 4, // Set elevation here
      borderRadius: BorderRadius.circular(8), // Optional: if you want rounded corners
      child: Container(
        width: double.infinity,
        height: 130, // Set a height for the profile card
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFfdf7e6),
          borderRadius: BorderRadius.circular(8), // Match the Material's radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildProfileIcon(),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'PX14025',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                color: Color(0xff353E43),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildMembershipStatus(), // Membership status
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0), // Add left padding
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFc70000),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                'FF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                ),
              ),
            ),
            Positioned(
              bottom: 0, // Adjusts the position of the icon
              right: 0, // Adjusts the position of the icon
              child: Container(
                width: 25, // Increased width for the camera icon background
                height: 25, // Increased height for the camera icon background
                decoration: BoxDecoration(
                  color: Color(0xff909EAE), // Background for the camera icon
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined, // Camera icon
                  size: 18, // Size of the camera icon
                  color: Color(0xFF353E43), // Color of the camera icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipStatus() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          FontAwesomeIcons.crown,
          size: 14,
          color: Color(0xFFECB709),
        ),
        SizedBox(width: 8),
        Text(
          'Premium',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFECB709),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildNewContent() {
    return Material(
      elevation: 0, // Set elevation here
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(28),
        width: double.infinity,
        height: 400, // Height of the white box
        decoration: BoxDecoration(
          color: const Color(0xfffaf9f6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name Field
            const Text(
              'Isi nama sesuai KTP untuk membuka fitur lebih lengkap',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black54,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            TextField(
              controller: _nameController, // Connect the controller
              style: TextStyle(
                fontFamily: 'Poppins', // Use Poppins font
                color: textColor, // Set text color
              ),
              decoration: const InputDecoration(
                hintText: 'Ferry Febrian Nagara', // Placeholder text
                hintStyle: TextStyle(
                  fontFamily: 'Poppins', // Use Poppins font
                  color: Color(0xff353E43), // Placeholder color
                  fontSize: 18,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Underline border
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Border when focused
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Referral Code Field
            const Text(
              'Memudahkan pengiriman ketika ada hadiah promo',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black54,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            TextField(
              controller: _referralCodeController, // Connect the controller
              style: TextStyle(
                fontFamily: 'Poppins', // Use Poppins font
                color: textColor, // Set text color
              ),
              decoration: const InputDecoration(
                hintText: 'Jl. Sulaksana Baru I no. 5', // Placeholder text
                hintStyle: TextStyle(
                  fontFamily: 'Poppins', // Use Poppins font
                  color: Color(0xff353E43), // Placeholder color
                  fontSize: 18,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Underline border
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Border when focused
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding around the card
      child: Container(
        width: 300, // Set the width of the card
        height: 100, // Set the height of the card
        decoration: BoxDecoration(
          color: Colors.transparent, // Ensure the background is transparent to see the shadow
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 1, // Spread radius of the shadow
              blurRadius: 6, // Blur radius of the shadow
              offset: const Offset(0, -1), // Position of the shadow
            ),
          ],
        ),
        child: Card(
          elevation: 0, // Set elevation to 0 to use the custom shadow instead
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners for the card
          ),
          color: Color(0xfffaf9f6), // Background color of the card
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Inner padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nomor Terdaftar', // Example information
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Color(0xff909EAE),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '0822 4000 0201',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Color(0xFF353E43), // Title color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonMember(BuildContext context) => Center(
    child: SizedBox(
      width: 350,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          // Add your onPressed function here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffecb709), // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
        ),
        child: const Text(
          'SIMPAN',
          style: TextStyle(
            color: Colors.white, // Button text color
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );


}
