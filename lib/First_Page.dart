import 'package:flutter/material.dart';
import 'wave_painter.dart'; // Custom painter untuk gelombang di background
import 'login_screen.dart'; // Layar untuk login
import 'fingerprint_screen.dart'; // Layar untuk login menggunakan fingerprint

// StatefulWidget yang menjadi halaman utama aplikasi
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan Stack agar bisa menumpuk widget secara vertikal
      body: Stack(
        children: <Widget>[
          // Background gambar di bagian atas layar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2, // Setengah dari tinggi layar
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ilustrasi.png'), // Gambar ilustrasi
                  fit: BoxFit.cover, // Gambar menutupi seluruh container
                ),
              ),
            ),
          ),

          // Logo yang diletakkan di bagian atas tengah layar
          Positioned(
            top: 40, // Jarak dari atas layar
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter, // Menempatkan logo di tengah
              child: Image.asset('assets/images/LogoMalang.png', height: 50, width: 50), // Ukuran logo
            ),
          ),

          // CustomPaint untuk membuat efek gelombang di bawah layar
          Positioned(
            top: MediaQuery.of(context).size.height / 2, // Mulai dari setengah layar
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: WavePainter(), // Painter custom untuk membuat efek gelombang
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.red, Colors.blue], // Gradasi warna
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Konten utama yang ditampilkan di setengah bagian bawah layar
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                // Teks sambutan
                Text(
                  'Halo, Sobat Ngawonggo', // Teks utama
                  style: TextStyle(
                    fontSize: 32, // Ukuran font besar
                    fontWeight: FontWeight.bold, // Tebal
                    color: Colors.white, // Warna putih
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5), // Jarak antar teks
                Text(
                  'Beberapa Layanan Kami', // Sub-teks
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kBottomNavigationBarHeight), // Jarak ke bawah

                // Menu layanan, ditampilkan dalam bentuk ikon dan teks
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // Bagi rata ke kiri dan kanan
                    children: [
                      // Masing-masing item menu
                      _buildMenuItem('assets/images/registrasipenduduk.png', 'Registrasi Penduduk Baru'),
                      _buildMenuItem('assets/images/Surat.png', 'Surat/Berkas'),
                    ],
                  ),
                ),

                Spacer(), // Memberi jarak dengan tombol di bawah

                // Tombol login dan fingerprint
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman login
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50), // Lebar tombol full
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      SizedBox(height: 16), // Jarak antara tombol
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman fingerprint
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FingerprintScreen()),
                          );
                        },
                        child: Icon(Icons.fingerprint), // Ikon fingerprint
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50), // Lebar tombol full
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32), // Jarak ke bawah layar
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun item menu dengan gambar dan teks
  Widget _buildMenuItem(String iconPath, String title) {
    return Column(
      children: [
        Image.asset(iconPath, height: 50), // Ikon dengan tinggi 50
        SizedBox(height: 8), // Jarak antar ikon dan teks
        Text(title, style: TextStyle(fontSize: 14, color: Colors.white)), // Teks judul item menu
      ],
    );
  }
}
