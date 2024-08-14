import 'package:flutter/material.dart';
import 'SuratDomisiliUsahaScreen.dart';
import 'N1_N5.dart';
import 'SuratKematianScreen.dart';
import 'SuratKelahiranScreen.dart';
import 'DomisiliHajiScreen.dart';
import 'SuratUsahaScreen.dart';
import 'JadwalSholatScreen.dart';
import 'CuacaScreen.dart';
import 'EventDesaScreen.dart';

class BerandaScreen extends StatelessWidget {
  final String username;

  const BerandaScreen({Key? key, required this.username}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _ServiceItem(
                          icon: Icons.mosque,
                          label: 'Jadwal Sholat',
                          iconColor: Colors.white,
                          backgroundColor: Colors.grey[200]!,
                          labelColor: Colors.black,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalSholatScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: _ServiceItem(
                          icon: Icons.cloud,
                          label: 'Cuaca',
                          iconColor: Colors.blue,
                          backgroundColor: Colors.grey[200]!,
                          labelColor: Colors.black,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CuacaScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: _ServiceItem(
                          icon: Icons.event,
                          label: 'Event Desa',
                          iconColor: Colors.purple,
                          backgroundColor: Colors.grey[200]!,
                          labelColor: Colors.black,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventDesaScreen()),
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
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16.0),
              childAspectRatio: 1.0,  // This ensures the grid items are square
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: [
                _ServiceMenuItem(
                  icon: Icons.business,
                  label: 'Surat Keterangan Domisili Usaha',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SuratDomisiliUsahaScreen()),
                    );
                  },
                ),
                _ServiceMenuItem(
                  icon: Icons.cancel,
                  label: 'Surat Keterangan Belum Pernah N',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => N1N5Screen()),
                    );
                  },
                ),
                _ServiceMenuItem(
                  icon: Icons.home,
                  label: 'Surat Keterangan Domisili Haji',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DomisiliHajiScreen()),
                    );
                  },
                ),
                _ServiceMenuItem(
                  icon: Icons.list,
                  label: 'N1-N5',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => N1N5Screen()),
                    );
                  },
                ),
                _ServiceMenuItem(
                  icon: Icons.business_center,
                  label: 'Surat Keterangan Usaha',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SuratUsahaScreen()),
                    );
                  },
                ),
                _ServiceMenuItem(
                  icon: Icons.assignment,
                  label: 'Surat Keterangan Kematian',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SuratKematianScreen()),
                    );
                  },
                ),
                _ServiceMenuItem(
                  icon: Icons.child_care,
                  label: 'Surat Keterangan Kelahiran',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SuratKelahiranScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final Color labelColor;
  final VoidCallback onTap;

  const _ServiceItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.labelColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0, color: iconColor),
            const SizedBox(height: 4.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ServiceMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40.0, color: Colors.purple),
          const SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
