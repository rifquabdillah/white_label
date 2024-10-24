import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:white_label/account.dart';

class DaftarMember extends StatefulWidget {
  const DaftarMember({super.key});

  @override
  _DaftarMemberState createState() => _DaftarMemberState();
}

class _DaftarMemberState extends State<DaftarMember> {
  Color textColor = Colors.grey; // Initial text color
  Color borderColor = Colors.black54; // Initial border color
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _markUpController = TextEditingController();
  bool isRegistered = false; // Track if the user is registered
  bool showWarning = false; // Track if the warning message should be shown

  @override
  void initState() {
    super.initState();
    // Listener to change the text color based on input
    // Listener to change the text color based on input for each controller
    _nameController.addListener(() {
      setState(() {
        textColor = _nameController.text.isEmpty ? Colors.grey : Color(0xff353E43); // Change text color based on input
      });
    });

    _phoneController.addListener(() {
      setState(() {
        textColor = _phoneController.text.isEmpty ? Colors.grey : Color(0xff353E43);
      });
    });

    _alamatController.addListener(() {
      setState(() {
        textColor = _alamatController.text.isEmpty ? Colors.grey : Color(0xff353E43);
      });
    });

    _markUpController.addListener(() {
      setState(() {
        textColor = _markUpController.text.isEmpty ? Colors.grey : Color(0xff353E43);
      });
    });
  }

  void _onDaftarPressed() {
    // Assume registration is successful
    bool registrationSuccessful = true; // Change this based on your logic

    if (registrationSuccessful) {
      final snackBar = SnackBar(
        content: const Text(
          'Pendaftaran berhasil!',
          style: TextStyle(color: Color(0xff353E43)), // Optional: Change text color
        ),
        backgroundColor: Color(0xFFfdf7e6), // Set the background color here
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          textColor: Color(0xff353E43), // Optional: Change action text color
          onPressed: () {
            // Optional: Code to execute when the action is pressed.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AccountPage()), // Replace with your target page
        );
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    _markUpController.dispose();
    super.dispose();
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
      backgroundColor: const Color(0xfffaf9f6),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: keyboardVisible ? 50 : 100),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(28),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xfffaf9f6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Daftarkan Member Baru',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.amber,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 30),

                  if (showWarning) ...[
                    const SizedBox(height: 10),
                    const Text(
                      'Sepertinya nomor kamu belumsudah terdaftar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xffC70000),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],

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
                    controller: _nameController,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: textColor, // Use the textColor variable
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nama Lengkap',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Text(
                    'Gunakan nomor WhatsApp biar gampang dapat promo',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: textColor, // Use the textColor variable
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nomor HP yang Aktif',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
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
                    controller: _alamatController,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: textColor, // Use the textColor variable
                    ),
                    decoration: InputDecoration(
                      hintText: 'Alamat',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Text(
                    'Penambahan harga yang akan jadi keuntunganmu',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextField(
                    controller: _markUpController,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: textColor, // Use the textColor variable
                    ),
                    decoration: InputDecoration(
                      hintText: 'Mark Up',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        print('Dengan Mendaftar tapped');
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Dengan Mendaftar, saya menyetujui ',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Ketentuan Layanan',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                print('Ketentuan Layanan tapped');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffECB709), // Button color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _onDaftarPressed, // Call the onLoginPressed function
                        child: const Text(
                          'DAFTARKAN MEMBER',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
