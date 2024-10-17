import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:white_label/login/register.dart';
import 'otpScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color textColor = Colors.grey; // Initial text color
  Color borderColor = Colors.black54; // Initial border color
  final TextEditingController _controller = TextEditingController();
  bool isRegistered = false; // Track if the user is registered
  bool showWarning = false; // Track if the warning message should be shown

  @override
  void initState() {
    super.initState();
    // Listener to change the text color based on input
    _controller.addListener(() {
      setState(() {
        textColor = _controller.text.isEmpty ? Colors.grey : Colors.black; // Change text color based on input
      });
    });
  }

  void _checkRegistration() {
    // Check if the input number is registered
    setState(() {
      isRegistered = _controller.text == "123456789"; // Example logic to check registration
      borderColor = isRegistered ? Colors.black54 : Colors.red; // Change border color
    });
  }

  void _onLoginPressed() {
    _checkRegistration(); // Check registration status
    if (isRegistered) {
      // Navigate to Otpscreen if registered
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Otpscreen()), // Navigate to Otpscreen
      );
    } else {
      setState(() {
        showWarning = true; // Show warning if the number is unregistered
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0; // Check if keyboard is open

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffaf9f6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
          padding: EdgeInsets.only(top: keyboardVisible ? 50 : 400), // Adjust padding based on keyboard visibility
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
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: Colors.amber,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Halo, Kak!\nSelamat datang kembali',
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
                      'Sepertinya nomor kamu belum terdaftar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.red, // Red color for the warning text
                        fontSize: 14,
                      ),
                    ),
                  ],

                  // TextField for phone number
                  TextField(
                    controller: _controller, // Connect the controller
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: textColor, // Set text color
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nomor HP Terdaftar', // Placeholder text
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
                          'LOGIN',
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
                        text: 'Belum punya akun? ',
                        style: const TextStyle(
                          fontFamily: 'Poppins', // Use Poppins font
                          color: Colors.black45,
                        ),
                        children: [
                          TextSpan(
                            text: 'Daftar Baru',
                            style: const TextStyle(
                              fontFamily: 'Poppins', // Use Poppins font
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              // Navigate to the registration page
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Register()),
                              );
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