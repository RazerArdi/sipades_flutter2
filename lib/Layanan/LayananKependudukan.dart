import 'package:flutter/material.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_BiodataPenduduk.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_Kelahiran.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_Kematian.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_Pindah.dart';


class LayananKependudukan extends StatefulWidget {
  @override
  _LayananKependudukanState createState() => _LayananKependudukanState();
}

class _LayananKependudukanState extends State<LayananKependudukan> {
  final List<Map<String, dynamic>> _services = [
    {'title': 'Biodata Penduduk', 'icon': Icons.person, 'color': Colors.blue},
    {'title': 'Pindah', 'icon': Icons.directions_car, 'color': Colors.green},
    {
      'title': 'Kelahiran',
      'icon': Icons.child_friendly,
      'color': Colors.orange
    },
    {
      'title': 'Kematian',
      'icon': Icons.sentiment_very_dissatisfied,
      'color': Colors.red
    },
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
        title: const Text('Layanan Kependudukan'),
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
                  return _buildServiceCard(
                    color: service['color'],
                    title: service['title'],
                    icon: service['icon'],
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
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Biodata Penduduk':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LayananKependudukanBiodataPenduduk()),
            );
            break;
          case 'Pindah':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LayananKependudukanPindah()),
            );
            break;
          case 'Kelahiran':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LayananKependudukanKelahiran()),
            );
            break;
          case 'Kematian':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LayananKependudukanKematian()),
            );
            break;
        }
      },
      child: Container(
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
      ),
    );
  }
}
