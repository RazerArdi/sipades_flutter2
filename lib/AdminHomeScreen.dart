import 'package:flutter/material.dart';
import 'admin_beranda_screen.dart';
import 'admin_DataMasuk_screen.dart';
import 'admin_bantuan_screen.dart';
import 'admin_profil_screen.dart';

// Halaman utama untuk tampilan admin dengan navigasi bawah
class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0; // Indeks halaman yang dipilih di navigasi bawah

  // Daftar halaman yang bisa dinavigasi
  final List<Widget> _pages = [
    AdminBerandaScreen(), // Halaman Beranda
    AdminRiwayatScreen(), // Halaman Riwayat
    AdminBantuanScreen(), // Halaman Bantuan
    AdminProfilScreen(), // Halaman Profil
  ];

  // Fungsi untuk menangani perubahan indeks ketika item navigasi bawah dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Memperbarui indeks halaman yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar di bagian atas dengan gradien sebagai latar belakang
      appBar: AppBar(
        toolbarHeight: 50.0, // Tinggi toolbar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red, Colors.blue], // Warna gradien dari atas kiri ke bawah kanan
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('ADMIN'), // Judul AppBar
        backgroundColor: Colors.transparent, // Membuat latar belakang AppBar transparan
        elevation: 0, // Menghilangkan bayangan untuk tampilan yang lebih bersih
        automaticallyImplyLeading: false, // Menghilangkan tombol panah kembali secara otomatis
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline), // Ikon info di sebelah kanan AppBar
          ),
        ],
      ),
      // Menampilkan halaman sesuai dengan indeks yang dipilih
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.grey[300], // Garis pemisah di atas BottomNavigationBar
            height: 1.0, // Tinggi garis pemisah
          ),
          BottomNavigationBar(
            backgroundColor: Colors.white, // Warna latar belakang BottomNavigationBar
            selectedItemColor: Colors.red, // Warna item yang dipilih
            unselectedItemColor: Colors.grey[600], // Warna item yang tidak dipilih
            currentIndex: _selectedIndex, // Menandai item yang sedang dipilih
            onTap: _onItemTapped, // Fungsi untuk menangani perubahan item
            showSelectedLabels: true, // Menampilkan label item yang dipilih
            showUnselectedLabels: true, // Menampilkan label item yang tidak dipilih
            type: BottomNavigationBarType.fixed, // Tipe navigasi bawah tetap
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), // Ikon untuk halaman Beranda
                label: 'Beranda', // Label untuk halaman Beranda
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.safety_check), // Ikon untuk halaman Data Masuk
                label: 'Data Masuk', // Label untuk halaman Data Masuk
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help), // Ikon untuk halaman Bantuan
                label: 'Bantuan', // Label untuk halaman Bantuan
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person), // Ikon untuk halaman Profil
                label: 'Profil', // Label untuk halaman Profil
              ),
            ],
          ),
        ],
      ),
    );
  }
}
