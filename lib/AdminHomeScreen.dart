import 'package:flutter/material.dart';
import 'admin_beranda_screen.dart';
import 'admin_riwayat_screen.dart';
import 'admin_bantuan_screen.dart';
import 'admin_profil_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminBerandaScreen(),
    AdminRiwayatScreen(),
    AdminBantuanScreen(),
    AdminProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('ADMIN'),
        backgroundColor: Colors.transparent, // Make the AppBar background transparent
        elevation: 0, // Remove shadow for a cleaner look
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
          BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey[600],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.safety_check),
                label: 'Data Masuk',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help),
                label: 'Bantuan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//