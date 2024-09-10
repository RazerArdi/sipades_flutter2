import 'package:flutter/material.dart';

import 'PINDAH/Pd_SuratKeteranganPindah.dart';
import 'PINDAH/Pd_FormulirPendaftaranPerpindahan.dart';
import 'PINDAH/Pd_SuratKeteranganPindahDatangSatuDesa.dart';
import 'PINDAH/Pd_SuratKeteranganPindahAntarDesa.dart';
import 'PINDAH/Pd_SuratKeteranganPindahDatangAntarDesa.dart';
import 'PINDAH/Pd_SuratKeteranganPindahAntarKecamatan.dart';
import 'PINDAH/Pd_SuratKeteranganPindahDatangAntarKecamatan.dart';
import 'PINDAH/Pd_SuratPengantarPindah.dart';
import 'PINDAH/Pd_SuratPengantarPindahDatang.dart';
import 'PINDAH/Pd_FormulirPermohonanPindahAntarProvinsi.dart';
import 'PINDAH/Pd_FormulirPermohonanPindahDatangAntarProvinsi.dart';

// Widget utama untuk menampilkan layanan terkait perpindahan
class LayananKependudukanPindah extends StatefulWidget {
  @override
  _LayananKependudukanPindahState createState() =>
      _LayananKependudukanPindahState();
}

class _LayananKependudukanPindahState
    extends State<LayananKependudukanPindah> {
  // Daftar item layanan yang akan ditampilkan
  final List<Map<String, String>> _items = [
    {'title': 'Surat Keterangan Pindah', 'route': '/suratKeteranganPindah'},
    {'title': 'Formulir Pendaftaran Perpindahan Penduduk (F-1.03)', 'route': '/formulirPendaftaranPerpindahan'},
    {'title': 'Surat Keterangan Pindah Datang WNI Dalam Satu Desa/Kelurahan (F-1.24)', 'route': '/suratKeteranganPindahDatangSatuDesa'},
    {'title': 'Surat Keterangan Pindah WNI Antar Desa/Kelurahan (F-1.26)', 'route': '/suratKeteranganPindahAntarDesa'},
    {'title': 'Surat Keterangan Pindah Datang WNI Antar Desa/Kelurahan (F-1.28)', 'route': '/suratKeteranganPindahDatangAntarDesa'},
    {'title': 'Surat Keterangan Pindah WNI Antar Kecamatan (F-1.30)', 'route': '/suratKeteranganPindahAntarKecamatan'},
    {'title': 'Surat Keterangan Pindah Datang WNI Antar Kecamatan (F-1.32)', 'route': '/suratKeteranganPindahDatangAntarKecamatan'},
    {'title': 'Surat Pengantar Pindah (F-1.33)', 'route': '/suratPengantarPindah'},
    {'title': 'Surat Pengantar Pindah Datang (F-1.35)', 'route': '/suratPengantarPindahDatang'},
    {'title': 'Formulir Permohonan Pindah WNI Antar Provinsi (F-1.36)', 'route': '/formulirPermohonanPindahAntarProvinsi'},
    {'title': 'Formulir Permohonan Pindah Datang WNI Antar Provinsi (F-1.38)', 'route': '/formulirPermohonanPindahDatangAntarProvinsi'},
  ];

  // Daftar item yang sudah difilter berdasarkan query pencarian
  List<Map<String, String>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    // Inisialisasi _filteredItems dengan nilai awal dari _items
    _filteredItems = _items;
  }

  // Fungsi untuk memfilter item berdasarkan query pencarian
  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        // Jika query kosong, tampilkan semua item
        _filteredItems = _items;
      } else {
        // Filter item yang mengandung query pada judul
        _filteredItems = _items
            .where((item) =>
            item['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text('Pindah'), // Judul pada AppBar
        backgroundColor: Colors.black, // Warna latar belakang AppBar
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon pada AppBar
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold, // Gaya teks judul AppBar
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterItems, // Memanggil fungsi _filterItems saat teks berubah
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300], // Warna latar belakang TextField
                hintText: 'Cari', // Teks petunjuk pada TextField
                prefixIcon: const Icon(Icons.search), // Ikon pencarian pada TextField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Sudut border TextField
                  borderSide: BorderSide.none, // Menghilangkan border default
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length, // Jumlah item yang ditampilkan
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _Item(
                  icon: Icons.file_copy, // Ikon untuk item
                  title: item['title']!, // Judul item
                  onTap: () {
                    // Menavigasi ke halaman detail berdasarkan route
                    _navigateToDetailPage(context, item['route']!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menavigasi ke halaman detail berdasarkan route
  void _navigateToDetailPage(BuildContext context, String route) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (route) {
            case '/suratKeteranganPindah':
              return Pd_SuratKeteranganPindah();
            case '/formulirPendaftaranPerpindahan':
              return Pd_FormulirPendaftaranPerpindahan();
            case '/suratKeteranganPindahDatangSatuDesa':
              return Pd_SuratKeteranganPindahDatangSatuDesa();
            case '/suratKeteranganPindahAntarDesa':
              return Pd_SuratKeteranganPindahAntarDesa();
            case '/suratKeteranganPindahDatangAntarDesa':
              return Pd_SuratKeteranganPindahDatangAntarDesa();
            case '/suratKeteranganPindahAntarKecamatan':
              return Pd_SuratKeteranganPindahAntarKecamatan();
            case '/suratKeteranganPindahDatangAntarKecamatan':
              return Pd_SuratKeteranganPindahDatangAntarKecamatan();
            case '/suratPengantarPindah':
              return Pd_SuratPengantarPindah();
            case '/suratPengantarPindahDatang':
              return Pd_SuratPengantarPindahDatang();
            case '/formulirPermohonanPindahAntarProvinsi':
              return Pd_FormulirPermohonanPindahAntarProvinsi();
            case '/formulirPermohonanPindahDatangAntarProvinsi':
              return Pd_FormulirPermohonanPindahDatangAntarProvinsi();
            default:
              return Scaffold(
                body: Center(child: Text('Page not found')), // Tampilan jika route tidak ditemukan
              );
          }
        },
      ),
    );
  }
}

// Widget untuk menampilkan item dalam daftar
class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon; // Ikon yang ditampilkan di sebelah judul
  final String title; // Judul item
  final VoidCallback onTap; // Fungsi yang dipanggil saat item ditekan

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Memanggil fungsi onTap saat item ditekan
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Warna latar belakang item
          borderRadius: BorderRadius.circular(8.0), // Sudut border item
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // Warna bayangan item
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0), // Posisi bayangan item
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon, // Ikon item
              size: 40.0,
              color: Colors.black, // Warna ikon
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, // Judul item
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Gaya teks judul
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
