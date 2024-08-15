import 'package:flutter/material.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_PengantarNikah.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_SuratKeteranganPernahNikah.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_SuratKeteranganBelumPernahNikah.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_SuratKeteranganDudaJanda.dart';

class LayananNikah extends StatefulWidget {
  @override
  _LayananNikahState createState() => _LayananNikahState();
}

class _LayananNikahState extends State<LayananNikah> {
  final List<Map<String, dynamic>> _services = [
    {'title': 'Pengantar Nikah \n(N1-N6)', 'icon': Icons.calendar_today, 'color': Colors.blue, 'page': LayananNikah_PengantarNikah()},
    {'title': 'Surat Keterangan Pernah Nikah', 'icon': Icons.assignment_turned_in, 'color': Colors.green, 'page': LayananNikah_SuratKeteranganPernahNikah()},
    {'title': 'Surat Keterangan Belum Pernah Nikah', 'icon': Icons.assignment_turned_in, 'color': Colors.orange, 'page': LayananNikah_SuratKeteranganBelumPernahNikah()},
    {'title': 'Surat Keterangan Duda/Janda', 'icon': Icons.assignment_turned_in, 'color': Colors.red, 'page': LayananNikah_SuratKeteranganDudaJanda()},
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
        title: const Text('Layanan Nikah'),
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
