import 'package:flutter/material.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_PengantarNikah.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_SuratKeteranganPernahNikah.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_SuratKeteranganBelumPernahNikah.dart';
import '../SURAT/SK_LayananNikah/LayananNikah_SuratKeteranganDudaJanda.dart';

// Widget utama untuk menampilkan layanan nikah
class LayananNikah extends StatefulWidget {
  @override
  _LayananNikahState createState() => _LayananNikahState();
}

class _LayananNikahState extends State<LayananNikah> {
  // Daftar layanan yang tersedia dengan ikon, judul, warna, dan halaman terkait
  final List<Map<String, dynamic>> _services = [
    {'title': 'Pengantar Nikah \n(N1-N6)', 'icon': Icons.calendar_today, 'color': Colors.blue, 'page': LayananNikah_PengantarNikah()},
    {'title': 'Surat Keterangan Pernah Nikah', 'icon': Icons.assignment_turned_in, 'color': Colors.green, 'page': LayananNikah_SuratKeteranganPernahNikah()},
    {'title': 'Surat Keterangan Belum Pernah Nikah', 'icon': Icons.assignment_turned_in, 'color': Colors.orange, 'page': LayananNikah_SuratKeteranganBelumPernahNikah()},
    {'title': 'Surat Keterangan Duda/Janda', 'icon': Icons.assignment_turned_in, 'color': Colors.red, 'page': LayananNikah_SuratKeteranganDudaJanda()},
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
        title: const Text('Layanan Nikah'), // Judul pada AppBar
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
                  return GestureDetector(
                    onTap: () {
                      // Menavigasi ke halaman detail layanan berdasarkan halaman yang ditentukan
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
    return Container(
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
    );
  }
}
