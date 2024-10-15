import 'package:flutter/material.dart';

class TransaksiPay extends StatefulWidget {
  @override
  _TransaksiPayState createState() => _TransaksiPayState();
}

class _TransaksiPayState extends State<TransaksiPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Pay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Detail Transaksi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KonfirmasiTransaksi(),
                      ),
                    );
                  },
                  child: const Text('KIRIM TRANSAKSI BERHASIL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransaksiGagal(),
                      ),
                    );
                  },
                  child: const Text('KIRIM TRANSAKSI GAGAL'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KonfirmasiTransaksi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  // Menghilangkan tombol back default
        toolbarHeight: 30.0,
        backgroundColor: const Color(0xfffaf9f6),// Menetapkan tinggi AppBar menjadi 80 piksel
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);  // Aksi tombol close
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0), // Set padding to 0 for no space around the container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Ensure content is aligned to the top
          crossAxisAlignment: CrossAxisAlignment.stretch, // Make container stretch to the screen width
          children: [
            // Remove the SizedBox to stick the container at the top
            Container(
              decoration: BoxDecoration(
                color: const Color(0xfffaf9f6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              padding: const EdgeInsets.only(bottom: 20),
              margin: const EdgeInsets.all(0), // Optional: Add margin if you want space around the container
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo_sukses.png', // Path to your PNG image
                    width: 100, // Set the desired width
                    height: 100, // Set the desired height
                    fit: BoxFit.contain, // Ensure the image fits nicely
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ALHAMDULILLAH!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Transaksi kamu sudah berhasil dikirim dan sedang diproses',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _buildTransactionDetails(),
            const SizedBox(height: 20),
            _buildActionButtons(context),
            const Spacer(),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }
}


  Widget _buildTransactionDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF2D7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ferry Febrian Negara',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          _buildTransactionDetailRow('Tanggal Transaksi', '23/09/2024 13:00:21'),
          _buildTransactionDetailRow('Kode Produk', 'IP5'),
          _buildTransactionDetailRow('Nama Produk', 'Indosat Promo Mixed 5.000'),
          _buildTransactionDetailRow('Nomor Tujuan', '0856 2244 866'),
          _buildTransactionDetailRow(
            'Harga Jual',
            '7.000',
            isBold: true, // Jika ingin judulnya tebal
            color: Colors.orange, // Tetap menggunakan warna orange untuk nilai
            icon: Icons.edit, // Menambahkan ikon pensil
          ),

        ],
      ),
    );
  }

Widget _buildActionButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end, // Mengatur semua elemen ke sebelah kanan
    children: [
      TextButton.icon(
        onPressed: () {
          // Implement sharing functionality here
        },
        icon: const Icon(Icons.share, color: Colors.orange),
        label: const Text(
          'Bagikan',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      const SizedBox(width: 8), // Jarak antara tombol Bagikan dan Cetak Faktur
      Padding(
        padding: const EdgeInsets.only(right: 10), // Padding untuk menggeser tombol ke kiri
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Warna tombol
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Ukuran tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Radius sudut tombol
            ),
          ),
          onPressed: () {
            // Implement "Cetak Faktur" functionality here
          },
          child: const Text(
            'Cetak Faktur',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white), // Mengatur ukuran dan gaya teks
          ),
        ),
      ),
    ],
  );
}


  Widget _buildBackButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst); // Go back to home
      },
      child: const Text('Kembali ke Beranda'),
    );
  }

Widget _buildTransactionDetailRow(String title, String value, {bool isBold = false, Color color = Colors.black, IconData? icon}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isBold ? FontWeight.normal : FontWeight.normal,
          color: Colors.grey, // Setel warna teks "Harga Jual" ke hitam
        ),
      ),
      Row(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
              color: color, // Gunakan warna yang diberikan (orange untuk "7.000")
            ),
          ),
          const SizedBox(width: 8), // Jarak antara teks dan ikon
          if (icon != null) // Menambahkan ikon jika ada
            Icon(icon, color: color),
        ],
      ),
    ],
  );
}




// Halaman Transaksi Gagal
class TransaksiGagal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context); // Close the failure screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.cancel, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text(
              'MAAF!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Text(
              'Transaksi kamu gagal diproses',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF2D7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ferry Febrian Negara',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionDetailRow('Tanggal Transaksi', '23/09/2024 13:00:21'),
                  _buildTransactionDetailRow('Kode Produk', 'IP5'),
                  _buildTransactionDetailRow('Nama Produk', 'Indosat Promo Mixed 5.000'),
                  _buildTransactionDetailRow('Nomor Tujuan', '0856 2244 866'),
                  _buildTransactionDetailRow('Harga Jual', '7.000', isBold: true, color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst); // Go back to home
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetailRow(String label, String value,
      {bool isBold = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TransaksiPay(),
  ));
}
