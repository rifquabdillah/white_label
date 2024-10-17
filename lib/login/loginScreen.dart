import 'package:flutter/material.dart';
import 'package:white_label/login/login.dart';
import 'package:white_label/login/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Set LoginScreen as the initial page
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffecb709), // Background color for the entire page
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo section
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Center(
                child: Image.asset(
                  'assets/logokk.png', // Path to your image
                  height: 172, // Adjust the size of the image as needed
                  width: 172,
                ),
              ),
            ),

            const SizedBox(height: 350), // Space before buttons

            // LOGIN button
            ElevatedButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()), // Navigate to Login page
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White background
                minimumSize: const Size(350, 50), // Set button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.transparent),
              ),
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.yellow[800], // Yellow text color
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10), // Space between buttons

            // DAFTAR BARU button
            OutlinedButton(
              onPressed: () {
                // Navigate to the Register page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                side: const BorderSide(
                  color: Colors.white, // White border color
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(350, 50), // Button size
              ),
              child: const Text(
                'DAFTAR BARU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30), // Space before the row

            // Additional information row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Mau intip harga dulu?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic, // Set text to italic
                  ),
                ),
                const SizedBox(width: 5), // Small gap
                GestureDetector(
                  onTap: () {
                    // Action for Cek Pricelist
                  },
                  child: const Text(
                    'Cek Pricelist',
                    style: TextStyle(
                      color: Colors.white, // White text
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white, // Underlined text
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
