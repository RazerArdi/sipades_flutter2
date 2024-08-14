import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              SystemNavigator.pop();
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
    final greeting = _getGreeting();

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
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
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _ServiceItem(
                            icon: Icons.mosque,
                            label: 'Jadwal Sholat',
                            iconColor: Colors.green,
                            backgroundColor: Colors.grey[200]!,
                            labelColor: Colors.black,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JadwalSholatScreen()),
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
                        const SizedBox(width: 20.0),
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
                childAspectRatio: 1.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: [
                  _ServiceMenuItem(
                    icon: Icons.business,
                    label: 'Surat Keterangan Domisili Usaha',
                    backgroundColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuratDomisiliUsahaScreen()),
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.cancel,
                    label: 'Sk Belum Pernah Nikah',
                    backgroundColor: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => N1N5Screen()),
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.home,
                    label: 'Surat Keterangan Domisili Haji',
                    backgroundColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DomisiliHajiScreen()),
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.list,
                    label: 'N1-N5',
                    backgroundColor: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => N1N5Screen()),
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.business_center,
                    label: 'Surat Keterangan Usaha',
                    backgroundColor: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuratUsahaScreen()),
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.assignment,
                    label: 'Surat Keterangan Kematian',
                    backgroundColor: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuratKematianScreen()),
                      );
                    },
                  ),
                  _ServiceMenuItem(
                    icon: Icons.child_care,
                    label: 'Surat Keterangan Kelahiran',
                    backgroundColor: Colors.brown,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuratKelahiranScreen()),
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
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: iconColor),
            const SizedBox(height: 4.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
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
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(icon, size: 40.0, color: Colors.white),
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
