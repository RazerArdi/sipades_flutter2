import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"), // Judul di AppBar
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
      ),
      body: Container(
        // Background dengan gradasi warna biru
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Mulai dari atas
            end: Alignment.bottomCenter, // Hingga bawah
            colors: [
              Color.fromARGB(255, 71, 126, 255), // Warna biru muda
              Color.fromARGB(255, 18, 64, 189), // Warna biru tua
            ],
          ),
        ),
        // Isi halaman diletakkan di tengah
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Posisi di tengah secara vertikal
            children: [
              // Ikon "construction" menandakan halaman sedang dalam perbaikan
              Icon(
                Icons.construction,
                size: 100, // Ukuran ikon
                color: Colors.white, // Warna ikon putih
              ),
              SizedBox(height: 20), // Jarak antar ikon dan teks
              Text(
                'Halaman FAQ Masih Dalam Perbaikan!', // Pesan utama
                style: TextStyle(
                  fontSize: 24, // Ukuran teks besar
                  fontWeight: FontWeight.bold, // Teks tebal
                  color: Colors.white, // Warna teks putih
                ),
                textAlign: TextAlign.center, // Teks di tengah
              ),
              SizedBox(height: 20), // Jarak antara teks
              Text(
                'Mohon maaf atas ketidaknyamanan ini. Kami sedang melakukan perbaikan pada halaman FAQ.', // Pesan tambahan
                style: TextStyle(
                  fontSize: 16, // Ukuran teks lebih kecil
                  color: Colors.white, // Warna teks putih
                ),
                textAlign: TextAlign.center, // Teks di tengah
              ),
            ],
          ),
        ),
      ),
    );
  }
}
