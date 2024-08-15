import 'package:flutter/material.dart';
import 'beranda_screen.dart';
import 'bantuan_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class UserHomeScreen extends StatefulWidget {
  final String username;

  const UserHomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaScreen(username: 'username'),
    HistoryScreen(),
    BantuanScreen(),
    ProfileScreen(username: 'username'),
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
        title: const Text('SIPADES'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                icon: Icon(Icons.history),
                label: 'Riwayat',
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
}//
