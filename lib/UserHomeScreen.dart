import 'package:flutter/material.dart'; // Mengimpor package Flutter Material
import 'beranda_screen.dart'; // Mengimpor BerandaScreen
import 'bantuan_screen.dart'; // Mengimpor BantuanScreen
import 'history_screen.dart'; // Mengimpor HistoryScreen
import 'profile_screen.dart'; // Mengimpor ProfileScreen

// Kelas untuk layar utama pengguna dengan navigasi tab
class UserHomeScreen extends StatefulWidget {
  final String username; // Menyimpan username pengguna

  const UserHomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0; // Menyimpan indeks tab yang dipilih

  // Daftar halaman yang akan ditampilkan sesuai dengan tab yang dipilih
  final List<Widget> _pages = [
    BerandaScreen(username: 'username'), // Halaman Beranda
    HistoryScreen(), // Halaman Riwayat
    BantuanScreen(), // Halaman Bantuan
    ProfileScreen(username: 'username'), // Halaman Profil
  ];

  // Fungsi untuk menangani tap pada item BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah tab yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0, // Menentukan tinggi toolbar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red, Colors.blue], // Gradient untuk latar belakang AppBar
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('SIPADES'), // Judul AppBar
        backgroundColor: Colors.transparent, // Background AppBar transparan
        elevation: 0, // Menghapus shadow AppBar
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali otomatis
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline), // Tombol info di AppBar
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai tab yang dipilih
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.grey[300], // Garis pemisah di atas BottomNavigationBar
            height: 1.0,
          ),
          BottomNavigationBar(
            backgroundColor: Colors.white, // Background BottomNavigationBar
            selectedItemColor: Colors.red, // Warna item yang dipilih
            unselectedItemColor: Colors.grey[600], // Warna item yang tidak dipilih
            currentIndex: _selectedIndex, // Indeks tab yang dipilih
            onTap: _onItemTapped, // Menangani tab yang dipilih
            showSelectedLabels: true, // Menampilkan label untuk item yang dipilih
            showUnselectedLabels: true, // Menampilkan label untuk item yang tidak dipilih
            type: BottomNavigationBarType.fixed, // Tipe BottomNavigationBar
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), // Ikon untuk tab Beranda
                label: 'Beranda', // Label untuk tab Beranda
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history), // Ikon untuk tab Riwayat
                label: 'Riwayat', // Label untuk tab Riwayat
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help), // Ikon untuk tab Bantuan
                label: 'Bantuan', // Label untuk tab Bantuan
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person), // Ikon untuk tab Profil
                label: 'Profil', // Label untuk tab Profil
              ),
            ],
          ),
        ],
      ),
    );
  }
}
