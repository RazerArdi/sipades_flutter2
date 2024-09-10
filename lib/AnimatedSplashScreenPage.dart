import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart'; // Paket untuk animasi layar splash
import 'package:page_transition/page_transition.dart'; // Paket untuk transisi halaman
import 'First_Page.dart'; // Mengimpor halaman pertama aplikasi

// Halaman untuk menampilkan animasi splash screen
class AnimatedSplashScreenPage extends StatelessWidget {
  const AnimatedSplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Membuat stack mengisi seluruh area layar
        children: [
          // Latar belakang dengan gradien warna
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xffD488D4), const Color(0xff6E35B1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Widget AnimatedSplashScreen untuk menampilkan logo dengan animasi transisi
          AnimatedSplashScreen(
            splash: 'assets/images/LogoMalang.png', // Gambar yang ditampilkan saat splash
            nextScreen: const SplashScreen(), // Halaman berikutnya setelah splash
            splashTransition: SplashTransition.fadeTransition, // Transisi splash dengan efek fade
            pageTransitionType: PageTransitionType.fade, // Transisi halaman dengan efek fade
            backgroundColor: Colors.transparent, // Warna latar belakang transparan
            duration: 1000, // Durasi animasi splash dalam milidetik
          ),
        ],
      ),
    );
  }
}

// Halaman SplashScreen yang ditampilkan setelah animasi splash
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menunggu 3 detik sebelum berpindah ke halaman utama
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()), // Ganti dengan halaman utama
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xffD488D4), const Color(0xff6E35B1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Menyejajarkan konten di tengah
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/LogoMalang.png', // Gambar logo yang ditampilkan
                  width: 150, // Lebar gambar
                  height: 150, // Tinggi gambar
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding di sekitar teks
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Menyejajarkan teks di tengah
                children: [
                  const Text(
                    'SISTEM PELAYANAN DESA NGAWONGGO',
                    style: TextStyle(
                      fontSize: 20, // Ukuran font
                      fontWeight: FontWeight.bold, // Berat font tebal
                      color: Colors.white, // Warna font putih
                    ),
                    textAlign: TextAlign.center, // Menyelaraskan teks di tengah
                  ),
                  const SizedBox(height: 10), // Jarak vertikal antar teks
                  const Text(
                    'Official Mobile Application',
                    style: TextStyle(
                      fontSize: 16, // Ukuran font
                      fontWeight: FontWeight.normal, // Berat font normal
                      color: Colors.white, // Warna font putih
                    ),
                    textAlign: TextAlign.center, // Menyelaraskan teks di tengah
                  ),
                  const SizedBox(height: 5), // Jarak vertikal antar teks
                  const Text(
                    'Powered by PMM G8K70 2024 - V1.0',
                    style: TextStyle(
                      fontSize: 14, // Ukuran font
                      fontWeight: FontWeight.normal, // Berat font normal
                      color: Colors.white, // Warna font putih
                    ),
                    textAlign: TextAlign.center, // Menyelaraskan teks di tengah
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
