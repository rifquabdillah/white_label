import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'cetakFaktur.dart';


class CetakFakturToken extends StatefulWidget {
  const CetakFakturToken({super.key});

  @override
  _CetakFakturTokenState createState() => _CetakFakturTokenState();
}

class _CetakFakturTokenState extends State<CetakFakturToken> {
  final GlobalKey widgetKey = GlobalKey(); // Declare the widgetKey

  // Dummy values for dropdowns
  List<String> printers = ['Pilih Printer', 'RD-G58', 'MT-200VL'];
  List<String> paperSizes = ['A4', 'A5', 'Letter'];
  String? selectedPrinter;
  String? selectedPaperSize;

  Future<Uint8List> widgetToImage(Widget widget) async {
    // Wrap the widget in a RepaintBoundary
    RenderRepaintBoundary boundary = widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Increase pixel ratio for better quality
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> _saveAsPdf(BuildContext context) async {
    final pdf = pw.Document();
    final image = await widgetToImage(_buildFaktur()); // Capture the widget as an image
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Image(pw.MemoryImage(image)),
    ));
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/faktur.pdf');
    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Faktur disimpan sebagai PDF')));
  }

  Future<void> _printFaktur(BuildContext context) async {
    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Create a PDF document
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Faktur Anda', style: pw.TextStyle(fontSize: 24)),
        ),
      ),
    );

    // Close the loading dialog
    Navigator.of(context).pop();

    // Print the PDF document
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    // Optionally, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Faktur berhasil dicetak')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFFFDF7E6),
          ),
          child: AppBar(
            backgroundColor: Color(0XFFFDF7E6),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Faktur Transaksi',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4e5558),
                  ),
                ),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildContent(),
            const SizedBox(height: 4),
            Container(
              height: 660, // Set height as required
              child: _buildFaktur(),
            ),
            const SizedBox(height: 20),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFFDF7E6), // Set the background color here
        borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius:2, // Spread radius for the shadow
            blurRadius: 4, // Blur radius for shadow effect
            offset: const Offset(0, 2), // Position of the shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), // Adjusted padding for content spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ensures the column only takes up necessary space
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Padding below the first dropdown
            child: _buildDropdownRow(
              label: 'Printer yang digunakan:',
              value: selectedPrinter,
              hintText: "Pilih Printer",
              items: printers,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPrinter = newValue; // Update the selected printer
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Adjusted padding below the second dropdown
            child: _buildDropdownRow(
              label: 'Ukuran Kertas:',
              value: selectedPaperSize,
              hintText: "Pilih Ukuran Kertas",
              items: paperSizes,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaperSize = newValue; // Update the selected paper size
                });
              },
            ),
          ),
        ],
      ),
    );
  }

// Dropdown Row Builder Function
  Widget _buildDropdownRow({
    required String label,
    String? value,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    const double dropdownWidth = 180.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF353E43),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: dropdownWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                decoration: BoxDecoration(
                  color: const Color(0xffFAF9F6),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: PopupMenuButton<String>(
                  onSelected: onChanged,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Display hint text if value is empty, otherwise display value
                      Text(value?.isEmpty ?? true ? hintText : value!,
                          style: const TextStyle(color: Color(0xff353e43))),
                      const Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: Color(0xffECB709)),
                    ],
                  ),
                  itemBuilder: (BuildContext context) {
                    return items.map<PopupMenuItem<String>>((String item) {
                      return PopupMenuItem<String>(
                        value: item,
                        child: Column(
                          children: [
                            Text(
                              item,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xff353e43),
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFE0E0E0), // Divider color
                              thickness: 1, // Divider thickness
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFaktur() {
    return Container(
      width: double.infinity,
      height: 200, // Fill the available width
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15), // Adjust vertical padding
      decoration: BoxDecoration(
        color: Color(0xffFAF9F6),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berikan keterangan di atas faktur',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
              color: Color(0xFF4e5558),
            ),
          ),
          const SizedBox(height: 0.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'HEADER',
                    hintStyle: TextStyle(
                      color: Color(0xFF909EAE),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF353E43),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff909EAE),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '3258-3788-7754-9277-4670',
                      hintStyle: TextStyle(
                        color: Color(0xFF909EAE),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff909EAE),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff909EAE),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff909EAE),
                          width: 1.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF353E43),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nomor Faktur:',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '#89535525',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF353E43),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tanggal Transaksi',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '18/09/2024 13:37:28',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF353E43),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nomor Tujuan',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '32150477777',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF353E43),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Pemilik',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'H. Memed Ramdan',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF353E43),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tipe/Daya',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'R1M/900VA',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF353E43),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nominal',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'Rp. 100.000',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF353E43),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jumlah KWh',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '68,5',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF353E43),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Admin PPOB:',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                width: 180, // Adjust the width as needed
                child: _buildDropdownRow(
                  label: '', // Empty label since it's already displayed
                  value: 'Option 1', // Default selected value
                  hintText: 'Select an option', // Placeholder text
                  items: <String>['Pilih Nominal Admin', 'Nominal 1', 'Nominal 2'], // Dropdown items
                  onChanged: (String? newValue) {
                    // Handle the selection change here
                    print('Selected: $newValue'); // Replace with your logic
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),
          Text(
            'Berapa harga jual untuk transaksi ini?',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic, // Add this line for italic style
              color: Color(0xFF4e5558),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Use Expanded to allow the TextField to take available space
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Masukan Harga Jual', // Placeholder text
                    hintStyle: TextStyle(
                      color: Color(0xFF909EAE),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    // Only display the bottom border
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Change this to your desired color
                        width: 2.0, // Set the width of the bottom border
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Color of the bottom border when enabled
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Color of the bottom border when focused
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Add padding for better spacing
                  ),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF353E43),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Berikan keterangan di bawah faktur',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic, // Add this line for italic style
              color: Color(0xFF4e5558),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Use Expanded to allow the TextField to take available space
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Keterangan', // Placeholder text
                    hintStyle: TextStyle(
                      color: Color(0xFF909EAE),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    // Only display the bottom border
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Change this to your desired color
                        width: 2.0, // Set the width of the bottom border
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Color of the bottom border when enabled
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Color of the bottom border when focused
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Add padding for better spacing
                  ),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF353E43),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: false, // Ganti dengan state yang sesuai
                onChanged: (bool? value) {
                  // Logika untuk mengubah state checkbox
                },
              ),
              Text(
                'Tambahkan QR Code Pendaftaran',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontFamily: 'Poppins'), // Ganti dengan gaya yang diinginkan
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Simpan Faktur',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Pilih jenis berkas untuk disimpan',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildFileTypeButton(Icons.image, '.jpg'),
                          const SizedBox(width: 12),
                          _buildFileTypeButton(Icons.picture_as_pdf, '.pdf'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _saveAsPdf(context); // Call save as PDF
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffECB709),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Simpan Faktur',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.save_alt_rounded, color: Color(0xffECB709), size: 24),
          ),
        ),
        const SizedBox(width: 8.0),
        GestureDetector(
          onTap: () {
            // Handle share invoice
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Icon(Icons.share, color: Colors.black.withOpacity(0.2), size: 22),
                const Icon(Icons.share, color: Color(0xffECB709), size: 22),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              await _printFaktur(context); // Call the print function
              // Remove navigation to CetakFaktur
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfffcb12b),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Cetak Faktur',
              style: TextStyle(
                color: Color(0xffFAF9F6),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),


      ],
    );
  }

  Widget _buildFileTypeButton(IconData icon, String fileType) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle file type selection
      },
      icon: Icon(icon),
      label: Text(fileType),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffECB709),
      ),
    );
  }
}
