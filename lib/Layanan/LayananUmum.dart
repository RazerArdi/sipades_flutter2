import 'package:flutter/material.dart';
import '../SURAT/SK_LayananUmum/LayananUmum_SkUsaha.dart';
import '../SURAT/SK_LayananUmum/LayananUmum_SkTempatUsaha.dart';
import '../SURAT/SK_LayananUmum/LayananUmum_SkPengantarBarang.dart';
import '../SURAT/SK_LayananUmum/LayananUmum_SkPengantarTernak.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkTidakMampuSekolah.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkTidakMampuUmum.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkRumahTanggaMiskin.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkPenghasilanOrangTua.dart';
import '../SURAT/SK_LayananUmum/LayananUmumPermohonanIzinKeramaian.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkPengantarSKCK.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkAhliWaris.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkBepergian.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkTidakBeradaDiTempat.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkBedaIdentitas.dart';
import '../SURAT/SK_LayananUmum/LayananUmumSkLainnya.dart';

class LayananUmum extends StatefulWidget {
  @override
  _LayananUmumState createState() => _LayananUmumState();
}

class _LayananUmumState extends State<LayananUmum> {
  final List<Map<String, dynamic>> _services = [
    {'title': 'Surat Keterangan Usaha', 'icon': Icons.business_center, 'color': Colors.red, 'route': LayananUmumSkUsaha()},
    {'title': 'Surat Keterangan Tempat Usaha', 'icon': Icons.store, 'color': Colors.blue, 'route': LayananUmumSkTempatUsaha()},
    {'title': 'Surat Keterangan Pengantar Barang', 'icon': Icons.local_shipping, 'color': Colors.green, 'route': LayananUmumSkPengantarBarang()},
    {'title': 'Surat Keterangan Pengantar Ternak', 'icon': Icons.pets, 'color': Colors.orange, 'route': LayananUmumSkPengantarTernak()},
    {'title': 'Surat Keterangan Tidak Mampu (Sekolah)', 'icon': Icons.school, 'color': Colors.purple, 'route': LayananUmumSkTidakMampuSekolah()},
    {'title': 'Surat Keterangan Tidak Mampu (Umum)', 'icon': Icons.people_alt, 'color': Colors.teal, 'route': LayananUmumSkTidakMampuUmum()},
    {'title': 'Surat Keterangan Rumah Tangga Miskin Sekali', 'icon': Icons.home, 'color': Colors.brown, 'route': LayananUmumSkRumahTanggaMiskin()},
    {'title': 'Surat Keterangan Penghasilan Orang Tua', 'icon': Icons.attach_money, 'color': Colors.cyan, 'route': LayananUmumSkPenghasilanOrangTua()},
    {'title': 'Permohonan Izin Keramaian Pesta', 'icon': Icons.party_mode, 'color': Colors.pink, 'route': LayananUmumPermohonanIzinKeramaian()},
    {'title': 'Surat Pengantar SKCK', 'icon': Icons.fingerprint, 'color': Colors.indigo, 'route': LayananUmumSkPengantarSKCK()},
    {'title': 'Surat Keterangan Ahli Waris', 'icon': Icons.family_restroom, 'color': Colors.deepOrange, 'route': LayananUmumSkAhliWaris()},
    {'title': 'Surat Keterangan Bepergian', 'icon': Icons.flight_takeoff, 'color': Colors.lightGreen, 'route': LayananUmumSkBepergian()},
    {'title': 'Surat Keterangan Tidak Berada di Tempat', 'icon': Icons.location_off, 'color': Colors.amber, 'route': LayananUmumSkTidakBeradaDiTempat()},
    {'title': 'Surat Keterangan Beda Identitas', 'icon': Icons.person_search, 'color': Colors.lime, 'route': LayananUmumSkBedaIdentitas()},
    {'title': 'Surat Keterangan Lainnya', 'icon': Icons.description, 'color': Colors.lightBlue, 'route': LayananUmumSkLainnya()},
  ];

  List<Map<String, dynamic>> _filteredServices = [];

  @override
  void initState() {
    super.initState();
    _filteredServices = _services;
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredServices = _services;
      } else {
        _filteredServices = _services
            .where((service) =>
            service['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan Umum'),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey, Colors.black],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: _filterServices,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Cari Layanan...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'Layanan Tersedia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: _filteredServices.map((service) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => service['route'],
                        ),
                      );
                    },
                    child: _buildServiceCard(
                      color: service['color'],
                      title: service['title'],
                      icon: service['icon'],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required Color color,
    required String title,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
