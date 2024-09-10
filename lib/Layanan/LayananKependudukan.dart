import 'package:flutter/material.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_BiodataPenduduk.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_Kelahiran.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_Kematian.dart';
import '../SURAT/SK_LayananKependudukan/LayananKependudukan_Pindah.dart';

// Widget utama untuk menampilkan layanan kependudukan
class LayananKependudukan extends StatefulWidget {
  @override
  _LayananKependudukanState createState() => _LayananKependudukanState();
}

class _LayananKependudukanState extends State<LayananKependudukan> {
  // Daftar layanan yang tersedia dengan ikon, judul, dan warna
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

  // Daftar layanan yang sudah difilter berdasarkan query pencarian
  List<Map<String, dynamic>> _filteredServices = [];

  @override
  void initState() {
    super.initState();
    // Inisialisasi _filteredServices dengan nilai awal dari _services
    _filteredServices = _services;
  }

  // Fungsi untuk memfilter layanan berdasarkan teks pencarian
  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        // Jika query kosong, tampilkan semua layanan
        _filteredServices = _services;
      } else {
        // Filter layanan yang mengandung query pada judul
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
        title: const Text('Layanan Kependudukan'), // Judul pada AppBar
        backgroundColor: Colors.black, // Warna latar belakang AppBar
        centerTitle: true,
        elevation: 0, // Menghilangkan bayangan AppBar
        titleTextStyle: const TextStyle(
          color: Colors.white, // Warna teks judul
          fontSize: 20,
          fontWeight: FontWeight.bold, // Gaya teks judul
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon pada AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey, Colors.black, Colors.grey], // Warna latar belakang gradient
            stops: [0.05, 1.0, 0.05],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16), // Jarak atas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: _filterServices, // Memanggil fungsi _filterServices saat teks berubah
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, // Warna latar belakang TextField
                  hintText: 'Cari Layanan...', // Teks petunjuk pada TextField
                  prefixIcon: const Icon(Icons.search), // Ikon pencarian pada TextField
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Sudut border TextField
                    borderSide: BorderSide.none, // Menghilangkan border default
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24), // Jarak atas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Layanan Tersedia', // Judul daftar layanan
                style: const TextStyle(
                  color: Colors.white, // Warna teks judul daftar
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Gaya teks judul daftar
                ),
              ),
            ),
            const SizedBox(height: 16), // Jarak atas
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Jumlah kolom pada GridView
                crossAxisSpacing: 16, // Jarak horizontal antar item
                mainAxisSpacing: 16, // Jarak vertikal antar item
                children: _filteredServices.map((service) {
                  return _buildServiceCard(
                    color: service['color'],
                    title: service['title'],
                    icon: service['icon'],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16), // Jarak bawah
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun kartu layanan
  Widget _buildServiceCard({
    required Color color,
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        // Menavigasi ke halaman detail layanan berdasarkan judul
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
          color: color, // Warna latar belakang kartu layanan
          borderRadius: BorderRadius.circular(12), // Sudut border kartu
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menyusun item secara vertikal di tengah
            children: [
              Icon(
                icon, // Ikon layanan
                color: Colors.white, // Warna ikon
                size: 40,
              ),
              const SizedBox(height: 12), // Jarak antara ikon dan judul
              Text(
                title, // Judul layanan
                textAlign: TextAlign.center, // Rata tengah teks
                style: const TextStyle(
                  color: Colors.white, // Warna teks judul
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Gaya teks judul
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
