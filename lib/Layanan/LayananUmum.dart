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

// Widget utama untuk menampilkan daftar layanan umum
class LayananUmum extends StatefulWidget {
  @override
  _LayananUmumState createState() => _LayananUmumState();
}

class _LayananUmumState extends State<LayananUmum> {
  // Daftar layanan yang tersedia dengan ikon, judul, warna, dan rute halaman terkait
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
        title: const Text('Layanan Umum'), // Judul pada AppBar
        backgroundColor: Colors.black, // Warna latar belakang AppBar
        centerTitle: true,
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
            colors: [Colors.grey, Colors.black], // Warna latar belakang gradient
          ),
        ),
        child: SingleChildScrollView(
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
                child: const Text(
                  'Layanan Tersedia', // Judul daftar layanan
                  style: TextStyle(
                    color: Colors.white, // Warna teks judul daftar
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Gaya teks judul daftar
                  ),
                ),
              ),
              const SizedBox(height: 16), // Jarak atas
              GridView.count(
                shrinkWrap: true, // Mengatur ukuran GridView sesuai kebutuhan
                physics: const NeverScrollableScrollPhysics(), // Menghilangkan scroll pada GridView
                crossAxisCount: 2, // Jumlah kolom pada GridView
                crossAxisSpacing: 16, // Jarak horizontal antar item
                mainAxisSpacing: 16, // Jarak vertikal antar item
                children: _filteredServices.map((service) {
                  return GestureDetector(
                    onTap: () {
                      // Menavigasi ke halaman detail layanan berdasarkan rute yang ditentukan
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
              const SizedBox(height: 16), // Jarak bawah
            ],
          ),
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
