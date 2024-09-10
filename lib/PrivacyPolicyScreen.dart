import 'package:flutter/material.dart'; // Mengimpor paket Flutter Material

// Kelas untuk tampilan halaman kebijakan privasi
class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kebijakan Privasi"), // Judul aplikasi di AppBar
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Gradient mulai dari atas
            end: Alignment.bottomCenter, // Gradient berakhir di bawah
            colors: [
              Color.fromARGB(255, 71, 126, 255), // Warna gradient bagian atas
              Color.fromARGB(255, 18, 64, 189), // Warna gradient bagian bawah
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Mengatur agar kolom terpusat secara vertikal
            children: [
              Icon(
                Icons.construction, // Ikon konstruksi sebagai indikator perbaikan
                size: 100, // Ukuran ikon
                color: Colors.white, // Warna ikon
              ),
              SizedBox(height: 20), // Jarak vertikal antara ikon dan teks
              Text(
                'Halaman Kebijakan Privasi Masih Dalam Perbaikan!',
                style: TextStyle(
                  fontSize: 24, // Ukuran font untuk judul
                  fontWeight: FontWeight.bold, // Membuat font tebal
                  color: Colors.white, // Warna teks
                ),
                textAlign: TextAlign.center, // Menyelaraskan teks di tengah
              ),
              SizedBox(height: 20), // Jarak vertikal antara judul dan deskripsi
              Text(
                'Mohon maaf atas ketidaknyamanan ini. Kami sedang melakukan perbaikan pada halaman Kebijakan Privasi.',
                style: TextStyle(
                  fontSize: 16, // Ukuran font untuk deskripsi
                  color: Colors.white, // Warna teks
                ),
                textAlign: TextAlign.center, // Menyelaraskan teks di tengah
              ),
            ],
          ),
        ),
      ),
    );
  }
}
