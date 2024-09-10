import 'package:flutter/material.dart';

// Dialog untuk menampilkan informasi tentang kami
class AboutUsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Judul dialog
      title: Text('Tentang Kami'),

      // Konten dialog
      content: Column(
        mainAxisSize: MainAxisSize.min, // Ukuran kolom disesuaikan dengan konten
        children: [
          // Menampilkan gambar tentang kami
          Image.asset('assets/images/KITA.png'),

          SizedBox(height: 16), // Jarak vertikal antara gambar dan teks

          // Teks deskripsi tentang perusahaan
          Text(
            'We are an Advisory Firm who specializes in Business and Security Intelligence, providing a full spectrum of services and solutions with a focus on Political Risk, Security, Defence, and Aerospace sectors.',
            textAlign: TextAlign.center, // Penjajaran teks ke tengah
          ),
        ],
      ),

      // Tombol aksi di bawah dialog
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Menutup dialog ketika tombol ditekan
          child: Text('Tutup'), // Label tombol
        ),
      ],
    );
  }
}
