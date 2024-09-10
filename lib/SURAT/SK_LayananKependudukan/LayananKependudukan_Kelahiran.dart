import 'package:flutter/material.dart';
import 'KELAHIRAN/Klan_SuratKeteranganKelahiran.dart';
import 'KELAHIRAN/Klan_FormulirPermohonanAktaKelahiran.dart';
import 'KELAHIRAN/Klan_SuratPernyataanKelahiran.dart';
import 'KELAHIRAN/Klan_FormulirPengajuanPerubahanAktaKelahiran.dart';

// Widget utama untuk menampilkan layanan terkait kelahiran
class LayananKependudukanKelahiran extends StatefulWidget {
  @override
  _LayananKependudukanKelahiranState createState() =>
      _LayananKependudukanKelahiranState();
}

class _LayananKependudukanKelahiranState
    extends State<LayananKependudukanKelahiran> {
  // Daftar item layanan yang akan ditampilkan
  final List<Map<String, String>> _items = [
    {'title': 'Surat Keterangan Kelahiran', 'route': '/suratKeteranganKelahiran'},
    {'title': 'Formulir Permohonan Akta Kelahiran (F-2.01)', 'route': '/formulirPermohonanAktaKelahiran'},
    {'title': 'Surat Pernyataan Kelahiran (F-2.02)', 'route': '/suratPernyataanKelahiran'},
    {'title': 'Formulir Pengajuan Perubahan Akta Kelahiran (F-2.03)', 'route': '/formulirPengajuanPerubahanAktaKelahiran'},
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
        title: const Text('Kelahiran'), // Judul pada AppBar
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
                fillColor: Colors.white, // Warna latar belakang TextField
                hintText: 'Cari Formulir Kelahiran...', // Teks petunjuk pada TextField
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
                  icon: Icons.person, // Ikon untuk setiap item
                  title: item['title']!,
                  onTap: () {
                    // Menavigasi ke halaman detail berdasarkan route item
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
          // Menentukan widget yang akan ditampilkan berdasarkan route
          switch (route) {
            case '/suratKeteranganKelahiran':
              return Klan_SuratKeteranganKelahiran();
            case '/formulirPermohonanAktaKelahiran':
              return Klan_FormulirPermohonanAktaKelahiran();
            case '/suratPernyataanKelahiran':
              return Klan_SuratPernyataanKelahiran();
            case '/formulirPengajuanPerubahanAktaKelahiran':
              return Klan_FormulirPengajuanPerubahanAktaKelahiran();
            default:
            // Menampilkan halaman default jika route tidak ditemukan
              return Scaffold(
                body: Center(child: Text('Halaman tidak ditemukan')),
              );
          }
        },
      ),
    );
  }
}

// Widget untuk menampilkan item pada daftar layanan
class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon; // Ikon yang ditampilkan di samping judul
  final String title; // Judul item
  final VoidCallback onTap; // Fungsi yang dipanggil saat item ditekan

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Menangani aksi tap pada item
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Warna latar belakang item
          borderRadius: BorderRadius.circular(8.0), // Sudut border item
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0), // Bayangan di bawah item
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.black, // Warna ikon
            ),
            const SizedBox(width: 16.0), // Jarak antara ikon dan teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0, // Ukuran font judul
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
