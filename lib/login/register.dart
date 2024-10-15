import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Color textColor = Colors.grey; // Initial text color
  Color borderColor = Colors.black54; // Initial border color
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  bool isRegistered = false; // Track if the user is registered
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

  void _checkRegistration() {
    // This function should contain your logic to check if the number is registered
    // For demonstration, let's assume any input is considered unregistered if it's not "123456789"
    setState(() {
      isRegistered = _phoneController.text != "123456789"; // Example logic to check registration
      borderColor = isRegistered ? Colors.red : Colors.black54; // Change border color to red if unregistered
    });
  }

  void _onLoginPressed() {
    // This function is called when the login button is pressed
    _checkRegistration(); // Check registration status
    setState(() {
      showWarning = isRegistered; // Show warning if the number is unregistered
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0; // Check if keyboard is open

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffaf9f6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: const Text(
          '',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfffaf9f6), // Outer background
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: keyboardVisible ? 50 : 100), // Adjust padding based on keyboard visibility
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(28),
              width: double.infinity, // Width of the white box
              decoration: BoxDecoration(
                color: const Color(0xfffaf9f6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Daftar Baru',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: Colors.amber,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Salam Kenal!, Kak!\nSelamat bergabung di Kementrian Kuota',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Warning message for unregistered number
                  if (showWarning) ...[
                    const SizedBox(height: 10),
                    const Text(
                      'Sepertinya nomor kamu belumsudah terdaftar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xffC70000),
                        fontWeight: FontWeight.w700,// Red color for the warning text
                        fontSize: 14,
                      ),
                    ),
                  ],

                  // Name Field
                  const Text(
                    'Isi nama sesuai KTP untuk membuka fitur lebih lengkap',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  TextField(
                    controller: _nameController, // Connect the controller
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: textColor, // Set text color
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Lengkap', // Placeholder text
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        color: Colors.grey, // Placeholder color
                        fontSize: 16,
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

                  // Phone Field
                  const Text(
                    'Gunakan nomor WhatsApp biar gampang dapat promo',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                        fontSize: 12,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  TextField(
                    controller: _phoneController, // Connect the controller
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: textColor, // Set text color
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nomor HP', // Placeholder text
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        color: Colors.grey, // Placeholder color
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor), // Underline border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor), // Border when focused
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Referral Code Field
                  const Text(
                    'Kosongkan kalau kamu tidak mendapatkan kode referral',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                        fontSize: 12,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  TextField(
                    controller: _referralCodeController, // Connect the controller
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: textColor, // Set text color
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Kode Referral', // Placeholder text
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        color: Colors.grey, // Placeholder color
                        fontSize: 16,
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
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Action when the entire text is tapped
                        print('Dengan Mendaftar tapped');
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Dengan Mendaftar, saya menyetujui ',
                          style: const TextStyle(
                            fontFamily: 'Poppins', // Use Poppins font
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Ketentuan Layanan',
                              style: const TextStyle(
                                fontFamily: 'Poppins', // Use Poppins font
                                color: Colors.amber, // Color for the link
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // Action when "Ketentuan Layanan" is tapped
                                // Replace with your link action
                                print('Ketentuan Layanan tapped');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Action when the entire text is tapped
                        print('Kebijakan Privasi tapped');
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Kebijakan Privasi ',
                          style: TextStyle(
                            fontFamily: 'Poppins', // Use Poppins font
                            color: Colors.amber, // Color for the link
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'dari Kementrian Kuota',
                              style: TextStyle(
                                fontFamily: 'Poppins', // Use Poppins font
                                color: Colors.black45,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _onLoginPressed, // Call the onLoginPressed function
                        child: const Text(
                          'BUAT AKUN',
                          style: TextStyle(
                            fontFamily: 'Poppins', // Use Poppins font
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Sudah punya akun? ',
                        style: const TextStyle(
                          fontFamily: 'Poppins', // Use Poppins font
                          color: Colors.black45,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              fontFamily: 'Poppins', // Use Poppins font
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              // Action to go to the registration page
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
