import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Mengimpor berbagai layanan dan fitur tambahan untuk aplikasi
import 'Layanan/LayananUmum.dart';
import 'Layanan/LayananNikah.dart';
import 'Layanan/LayananLainnya.dart';
import 'Layanan/LayananKependudukan.dart';
import 'Layanan/LayananPertanahan.dart';
import 'FiturTambahan/JadwalSholatScreen.dart';
import 'FiturTambahan/CuacaScreen.dart';
import 'FiturTambahan/EventDesaScreen.dart';

// Kelas utama untuk tampilan beranda aplikasi
class BerandaScreen extends StatelessWidget {
  final String username; // Menyimpan nama pengguna

  // Konstruktor untuk menerima nama pengguna
  const BerandaScreen({Key? key, required this.username}) : super(key: key);

  // Fungsi untuk menentukan salam berdasarkan waktu saat ini
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  // Fungsi untuk konfirmasi sebelum keluar dari aplikasi
  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // Keluar dari aplikasi
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting(); // Mendapatkan salam berdasarkan waktu

    return WillPopScope(
      onWillPop: () => _onWillPop(context), // Menangani tombol kembali
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16.0), // Margin di sekitar kontainer
                padding: const EdgeInsets.all(16.0), // Padding di dalam kontainer
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Radius sudut kontainer
                  color: Colors.white, // Warna latar belakang
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Warna bayangan
                      spreadRadius: 2, // Jarak sebar bayangan
                      blurRadius: 5, // Jarak buram bayangan
                      offset: const Offset(0, 3), // Offset bayangan
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting, // Menampilkan salam
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      username, // Menampilkan nama pengguna
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Menampilkan item layanan di baris pertama
                        Expanded(
                          child: _ServiceItem(
                            icon: Icons.mosque,
                            label: 'Jadwal Sholat',
                            iconColor: Colors.green,
                            backgroundColor: Colors.grey[300]!,
                            labelColor: Colors.black,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JadwalSholatScreen()), // Navigasi ke layar jadwal sholat
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: _ServiceItem(
                            icon: Icons.cloud,
                            label: 'Cuaca',
                            iconColor: Colors.blue,
                            backgroundColor: Colors.grey[300]!,
                            labelColor: Colors.black,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CuacaScreen()), // Navigasi ke layar cuaca
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: _ServiceItem(
                            icon: Icons.event,
                            label: 'Event Desa',
                            iconColor: Colors.purple,
                            backgroundColor: Colors.grey[300]!,
                            labelColor: Colors.black,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDesaScreen()), // Navigasi ke layar event desa
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Menampilkan menu layanan dalam bentuk grid
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3, // Jumlah kolom dalam grid
                padding: const EdgeInsets.all(16.0), // Padding di sekitar grid
                childAspectRatio: 1.0, // Rasio aspek setiap item grid
                mainAxisSpacing: 8.0, // Jarak vertikal antar item grid
                crossAxisSpacing: 8.0, // Jarak horizontal antar item grid
                children: [
                  _ServiceMenuItem(
                    icon: Icons.business,
                    label: 'Layanan Umum',
                    backgroundColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LayananUmum()), // Navigasi ke layar layanan umum
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.assignment_ind,
                    label: 'Layanan Kependudukan',
                    backgroundColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LayananKependudukan()), // Navigasi ke layar layanan kependudukan
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.favorite,
                    label: 'Layanan Nikah',
                    backgroundColor: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LayananNikah()), // Navigasi ke layar layanan nikah
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.home,
                    label: 'Layanan Pertanahan',
                    backgroundColor: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PertanahanScreen()), // Navigasi ke layar layanan pertanahan
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.person,
                    label: 'Layanan Lainnya',
                    backgroundColor: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LayananLainnya()), // Navigasi ke layar layanan lainnya
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk menampilkan item layanan dengan ikon dan label
class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final Color labelColor;
  final VoidCallback onTap;
  final double iconSize;

  const _ServiceItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.labelColor,
    required this.onTap,
    this.iconSize = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0), // Padding di dalam kontainer
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Radius sudut kontainer
          color: backgroundColor, // Warna latar belakang kontainer
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: iconColor), // Menampilkan ikon
            const SizedBox(height: 4.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                color: labelColor,
              ),
            ), // Menampilkan label
          ],
        ),
      ),
    );
  }
}

// Widget untuk menampilkan menu layanan dalam bentuk grid
class _ServiceMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;

  const _ServiceMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0), // Padding di dalam kontainer
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Bentuk kontainer
              color: backgroundColor, // Warna latar belakang kontainer
            ),
            child: Icon(icon, size: 40.0, color: Colors.white), // Menampilkan ikon
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12.0, color: Colors.black),
          ), // Menampilkan label
        ],
      ),
    );
  }
}
