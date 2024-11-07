import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CetakFaktur extends StatefulWidget {
  const CetakFaktur({super.key});

  @override
  _CetakfakturState createState() => _CetakfakturState();
}

class _CetakfakturState extends State<CetakFaktur> {
  // Dummy values for dropdowns
  List<String> printers = ['Pilih Printer', 'RD-G58', 'MT-200VL'];
  List<String> paperSizes = ['A4', 'A5', 'Letter'];
  String? selectedPrinter;
  String? selectedPaperSize;
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _noFakturController = TextEditingController();
  final TextEditingController _produkController = TextEditingController();
  final TextEditingController _kodeProdukController = TextEditingController();
  final TextEditingController _nomorTujuanController = TextEditingController();
  final TextEditingController _kodeSNController = TextEditingController();



  @override
  void dispose() {
    // Dispose controllers when widget is destroyed
    _headerController.dispose();
    _hargaJualController.dispose();
    _keteranganController.dispose();
    _noFakturController.dispose();
    _produkController.dispose();
    _nomorTujuanController.dispose();
    _kodeSNController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuat PDF faktur
  Future<void> _generatePdf(Map<String, String> fakturData) async {
    final pdf = pw.Document();

    // Mendapatkan tanggal transaksi saat ini
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    // Menambahkan halaman dengan penataan posisi dan ukuran
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Positioned(
              top: 20, // Mengatur posisi dari atas halaman
              left: 20, // Mengatur posisi dari kiri halaman
              child: pw.Text(
                '${fakturData['Header']}',
                style: pw.TextStyle(
                  fontSize: 32, // Mengatur ukuran font
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Positioned(
              top: 100,
              left: 20,
              child: pw.Text(
                '${fakturData['Nomor Faktur']}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Positioned(
              top: 120, // Posisi setelah elemen sebelumnya
              left: 20,
              child: pw.Text(
                '$currentDate',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Positioned(
              top: 140,
              left: 100,
              child: pw.Text(
                'FAKTUR TRANSAKSI',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Positioned(
              top: 160,
              left: 20,
              child: pw.Text(
                'Kode Produk: ${fakturData['Kode Produk']}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Positioned(
              top: 180,
              left: 20,
              child: pw.Text(
                'Keterangan: ${fakturData['Produk']}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Positioned(
              top: 200,
              left: 20,
              child: pw.Text(
                'Nomor Tujuan: ${fakturData['Nomor Tujuan']}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            pw.Positioned(
              top: 220,
              left: 20,
              child: pw.Text(
                'Kode SN: ${fakturData['Kode SN']}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
            // Menambahkan tanggal transaksi di bawah nomor faktur

          ],
        );
      },
    ));

    // Menyimpan PDF ke file sementara
    final output = await pdf.save();

    // Menampilkan PDF dengan menggunakan plugin printing
    await Printing.layoutPdf(onLayout: (_) => output);
  }

  // Fungsi untuk menampilkan pratinjau PDF
  void _showPrintPreview(Map<String, String> fakturData) async {
    await _generatePdf(fakturData);
  }

  // Fungsi untuk mencetak data faktur
  void _printFaktur() {
    // Memeriksa apakah printer dan ukuran kertas sudah dipilih
    if (selectedPrinter == null || selectedPaperSize == null) {
      // Jika belum, tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Harap pilih printer dan ukuran kertas terlebih dahulu.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Ambil data dari _buildFaktur
      String headerText = _headerController.text.isEmpty ? 'HEADER' : _headerController.text;
      String noFakturText = _noFakturController.text.isEmpty ? '#89535525' : _noFakturController.text;
      String kodeProdukText = _produkController.text.isEmpty ? 'TD25' : _produkController.text;
      String produkText = _produkController.text.isEmpty ? 'Telkomsel Data Nominal 5 GB / 30 Hari' : _produkController.text;
      String nomorTujuanText = _nomorTujuanController.text.isEmpty ? '0812 2126 0284' : _nomorTujuanController.text;
      String kodeSNText = _kodeSNController.text.isEmpty ? '03589200001570588332' : _kodeSNController.text;
      String hargaJualText = _hargaJualController.text.isEmpty ? 'Harga tidak tersedia' : _hargaJualController.text;

      // Kumpulkan semua data dalam Map
      Map<String, String> fakturData = {
        'Header': headerText,
        'Nomor Faktur': noFakturText,
        'Kode Produk': kodeProdukText,
        'Produk': produkText,
        'Nomor Tujuan': nomorTujuanText,
        'Kode SN': kodeSNText,
        'Harga Jual': hargaJualText,
      };

      // Tampilkan pratinjau cetak
      _showPrintPreview(fakturData);
    }
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
                  'Cetak Faktur',
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
      body: Column(
        children: [
          _buildContent(), // Call the content widget
          const SizedBox(height: 4), // Space of 4 pixels
          Container(
            height: 579, // Set the desired height directly here
            child: _buildFaktur(), // Call the faktur widget without Expanded
          ),
          const SizedBox(height: 15), // Additional spacing if needed
          _buildButton(context), // Call the _buildButton widget
        ],
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
                      // Menampilkan hint jika value kosong, jika tidak tampilkan value
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
                              color: Color(0xFFE0E0E0), // Warna garis pemisah
                              thickness: 1, // Ketebalan garis pemisah
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
      height: 600, // Adjust the height as needed
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
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
                  controller: _headerController,
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
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                _noFakturController.text.isEmpty ? '#89535525' : _noFakturController.text,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF353E43),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'
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
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                '18/09/2024 13:37:28',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF353E43),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode Produk',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF909EAE),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                _kodeProdukController.text.isEmpty ? 'TD25' : _kodeProdukController.text,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF353E43),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Produk',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF909EAE),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _produkController.text.isEmpty
                        ? 'Telkomsel Data Nominal 5 GB / 30 Hari'
                        : _produkController.text,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
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
                'Nomor Tujuan',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF909EAE),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                _nomorTujuanController.text.isEmpty ? '0812 2126 0284' : _nomorTujuanController.text,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF353E43),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF909EAE),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                'SUKSES',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF353E43),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode SN',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF909EAE),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins'
                ),
              ),
              Text(
                _kodeSNController.text.isEmpty ? '03589200001570588332' : _kodeSNController.text,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF353E43),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Berapa harga jual untuk transaksi ini?',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic,
              color: Color(0xFF4e5558),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _hargaJualController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Harga Jual',
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
                        alignment: Alignment.centerLeft, // Atur posisi ke kiri
                        child: const Text(
                          'Pilih jenis berkas untuk disimpan',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Atur agar konten dimulai dari kiri
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
                            // Handle save action
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
            onPressed: () {
              _printFaktur(); // Panggil fungsi untuk mencetak faktur
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfffcb12b),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Cetak Faktur',
              style: TextStyle(color: Color(0xffFAF9F6), fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildFileTypeButton(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xff909EAE)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xff909EAE),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }



}
