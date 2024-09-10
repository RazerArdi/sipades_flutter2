import 'package:flutter/material.dart';

import '../SURAT/SK_LayananPertanahan/LayananPertanahan_SuratKeteranganPencocokanSporadik.dart';
import '../SURAT/SK_LayananPertanahan/LayananPertanahan_Sporadik.dart';
import '../SURAT/SK_LayananPertanahan/LayananPertanahan_SuratKeteranganKepemilikanTanah.dart';
import '../SURAT/SK_LayananPertanahan/LayananPertanahan_SuratKeteranganJaminanRumah.dart';
import '../SURAT/SK_LayananPertanahan/LayananPertanahan_KeteranganAhliWaris.dart';
import '../SURAT/SK_LayananPertanahan/LayananPertanahan_KeteranganDesa.dart';

class PertanahanScreen extends StatefulWidget {
  @override
  _PertanahanScreenState createState() => _PertanahanScreenState();
}

class _PertanahanScreenState extends State<PertanahanScreen> {
  final List<Map<String, dynamic>> _services = [
    {'title': 'Surat Keterangan Pencocokan Sporadik', 'icon': Icons.document_scanner, 'color': Colors.blue, 'page': LayananPertanahan_SuratKeteranganPencocokanSporadik()},
    {'title': 'Sporadik', 'icon': Icons.document_scanner, 'color': Colors.green, 'page': LayananPertanahan_Sporadik()},
    {'title': 'Surat Keterangan Kepemilikan Tanah', 'icon': Icons.landscape, 'color': Colors.orange, 'page': LayananPertanahan_SuratKeteranganKepemilikanTanah()},
    {'title': 'Surat Keterangan Jaminan Rumah', 'icon': Icons.house, 'color': Colors.red, 'page': LayananPertanahan_SuratKeteranganJaminanRumah()},
    {'title': 'Keterangan Ahli Waris', 'icon': Icons.family_restroom, 'color': Colors.purple, 'page': LayananPertanahan_KeteranganAhliWaris()},
    {'title': 'Keterangan Desa', 'icon': Icons.cabin, 'color': Colors.teal, 'page': LayananPertanahan_KeteranganDesa()},
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
        title: const Text('Layanan Pertanahan'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
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
            colors: [Colors.grey, Colors.black, Colors.grey],
            stops: [0.05, 1.0, 0.05],
          ),
        ),
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
              child: Text(
                'Layanan Tersedia',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: _filteredServices.map((service) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => service['page']),
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
            ),
            const SizedBox(height: 16),
          ],
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
