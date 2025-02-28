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

    void updateState() {
      setState(() {});
    }

    _nameController.addListener(updateState);
    _phoneController.addListener(updateState);
    _alamatController.addListener(updateState);
    _markUpController.addListener(updateState);
  }

  bool isFormFilled() {
    return _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _alamatController.text.isNotEmpty &&
        _markUpController.text.isNotEmpty;
  }


  void _onDaftarPressed() {
    // Cek apakah semua field sudah diisi
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _markUpController.text.isEmpty) {
      // Tampilkan peringatan jika ada field yang kosong
      final snackBar = SnackBar(
        content: const Text(
          'Harap isi semua data sebelum mendaftar!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red, // Warna merah untuk peringatan
        duration: const Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return; // Hentikan proses pendaftaran
    }

    // Jika semua data telah diisi, lanjutkan proses pendaftaran
    final snackBar = SnackBar(
      content: const Text(
        'Pendaftaran berhasil!',
        style: TextStyle(color: Color(0xff353E43)),
      ),
      backgroundColor: Color(0xFFfdf7e6),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'OK',
        textColor: Color(0xff353E43),
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AccountPage()),
      );
    });
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
                    keyboardType: TextInputType.phone, // Menampilkan keyboard numerik
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
                    keyboardType: TextInputType.number, // Menampilkan keyboard angka
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
                          backgroundColor: isFormFilled() ? Color(0xffECB709) : Colors.grey, // Warna abu-abu jika form belum lengkap
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: isFormFilled() ? _onDaftarPressed : null, // Nonaktifkan jika form belum lengkap
                        child: const Text(
                          'DAFTARKAN MEMBER',
                          style: TextStyle(
                            fontFamily: 'Poppins',
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
