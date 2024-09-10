import 'package:flutter/material.dart';

// Dialog untuk menampilkan informasi kontak admin
class AdminContactDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Membuat dialog dengan sudut membulat
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      // Judul dialog yang berada di tengah
      title: Center(
        child: Text(
          'Kontak Admin', // Judul dialog
          style: TextStyle(
            fontSize: 22, // Ukuran font judul
            fontWeight: FontWeight.bold, // Gaya font tebal
          ),
        ),
      ),

      // Konten dialog
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar lingkaran yang menampilkan ikon admin
            Center(
              child: CircleAvatar(
                radius: 60, // Jari-jari lingkaran avatar
                backgroundColor: Colors.blueAccent, // Warna latar belakang avatar
                child: Icon(
                  Icons.admin_panel_settings, // Ikon admin
                  size: 60, // Ukuran ikon
                  color: Colors.white, // Warna ikon
                ),
              ),
            ),
            SizedBox(height: 15), // Jarak vertikal antara elemen
            Text(
              'Email: ngawonggodesa@gmail.com', // Alamat email admin
              style: TextStyle(fontSize: 18), // Ukuran font teks email
              textAlign: TextAlign.left, // Penjajaran teks ke kiri
            ),
            SizedBox(height: 10), // Jarak vertikal antara elemen
            Text(
              'Nomor Telepon: \n6281000000000', // Nomor telepon admin
              style: TextStyle(fontSize: 18), // Ukuran font teks nomor telepon
              textAlign: TextAlign.left, // Penjajaran teks ke kiri
            ),
          ],
        ),
      ),

      // Tombol aksi di bawah dialog
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Menutup dialog ketika tombol ditekan
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Warna latar belakang tombol
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Padding tombol
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Membuat sudut tombol membulat
              ),
            ),
            child: Text(
              'Tutup', // Label tombol
              style: TextStyle(fontSize: 16), // Ukuran font label tombol
            ),
          ),
        ),
      ],
    );
  }
}
