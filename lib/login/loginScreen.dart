import 'package:flutter/material.dart';
import 'package:white_label/login/login.dart';
import 'package:white_label/login/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Set LoginScreen sebagai halaman awal
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffecb709), // Dark background for the entire page
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

            const SizedBox(height: 350),

            // LOGIN button
            ElevatedButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()), // Navigasi ke halaman LoginScreen
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

            const SizedBox(height: 10),

            // DAFTAR BARU button
            OutlinedButton(
              onPressed: () {
                // Pindah ke halaman Register ketika tombol ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, // Warna teks
                side: const BorderSide(
                  color: Colors.white, // Warna border putih
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(350, 50), // Ukuran tombol
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
            const SizedBox(height: 30),


            Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row content
          children: [
            const Text(
              'Mau intip harga dulu?',
              style: TextStyle(color: Colors.black45),
            ),
            const SizedBox(width: 5), // Adds a small gap between the texts
            GestureDetector(
              onTap: () {
                // Action for Cek Pricelist
              },
              child: const Text(
                'Cek Pricelist',
                style: TextStyle(
                  color: Colors.white, // White text
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline, // Underlined text
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
