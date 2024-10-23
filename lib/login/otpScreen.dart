import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import '../main.dart';
import 'dart:async';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otpscreen> {
  Color textColor = Colors.grey; // Initial text color
  Color borderColor = Colors.black54; // Initial border color
  Color buttonColor = Colors.grey; // Initial button color (gray)
  final TextEditingController _phoneController = TextEditingController();
  bool isOtp = false; // Track if the user is registered
  bool showWarning = false; // Track if the warning message should be shown

  // Timer variables
  late Timer _timer;
  int _start = 60; // Countdown starts from 60 seconds

  @override
  void initState() {
    super.initState();
    _startTimer();

    _phoneController.addListener(() {
      setState(() {
        textColor = _phoneController.text.isEmpty ? Colors.grey : Colors.black; // Change text color based on input
        // Change button color based on whether the text field is empty
        buttonColor = _phoneController.text.isEmpty ? Colors.grey : Colors.amber;
      });
    });
  }

  // Start the timer
  void _startTimer() {
    _start = 60; // Reset to 60 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel(); // Stop the timer when it reaches 0
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _checkOtp() {
    // Check if the phone number is registered
    setState(() {
      isOtp = _phoneController.text != "H33LLL"; // Change to a 6-character check for example
      borderColor = isOtp ? Colors.red : Colors.black54; // Change border color to red if unregistered
    });
  }

  void _onLoginPressed() {
    // This function is called when the login button is pressed
    _checkOtp(); // Check registration status
    setState(() {
      showWarning = isOtp; // Show warning if the number is unregistered
    });

    // If the OTP is valid, navigate to MyHomePage
    if (!isOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: '',)),
      );
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
                    'Masukan OTP',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: Colors.amber,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Kode OTP sudah kami kirim ke nomor HP kamu, cek inbox ya, Kakak!',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 1),
                  if (showWarning) ...[
                    const SizedBox(height: 20), // Space before warning message
                    const Text(
                      'OTP SALAH!',
                      style: TextStyle(
                        color: Color(0xffc70000),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ],
                  TextField(
                    controller: _phoneController, // Connect the controller
                    style: TextStyle(
                      fontFamily: 'Poppins', // Use Poppins font
                      color: textColor, // Set text color
                    ),
                    decoration: InputDecoration(
                      hintText: 'Kode OTP', // Placeholder text
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        color: Colors.grey, // Placeholder color
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor), // Underline border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor), // Border when focused
                      ),
                      suffix: Container(
                        width: 80,
                        alignment: Alignment.center,
                        child: Text(
                          _start > 0 ? '$_start' : 'Kirim Ulang',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6), // Limit input to 6 characters
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]*$')), // Allow only alphanumeric characters
                    ],
                    textCapitalization: TextCapitalization.characters, // Capitalize all input
                  ),
                  const SizedBox(height: 20), // Space before RichText
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins', // Use Poppins font
                        color: Color(0xff353E43), // Default color for text
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Belum dapat kode? '), // This part will be black
                        TextSpan(
                          text: _phoneController.text.isEmpty
                              ? 'Ditunggu dulu ya' // This part will also be black
                              : '', // This part will be orange if text field is filled
                          style: const TextStyle(
                            color: Colors.black, // Ensure this part is black
                          ),
                        ),
                        if (!_phoneController.text.isEmpty) ...[ // Only show this part if text field is filled
                          const TextSpan(
                            text: ' ', // Add a space
                          ),
                          TextSpan(
                            text: 'Kirim Ulang OTP', // This part will be orange
                            style: const TextStyle(
                              color: Color(0xffECB709), // Orange color for this part
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'// Make this text bold
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 30), // Space before the button
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _phoneController.text.isEmpty ? null : _onLoginPressed, // Disable button if text field is empty
                        child: const Text(
                          'KONFIRMASI',
                          style: TextStyle(
                            fontFamily: 'Poppins', // Use Poppins font
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Space before the message
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
