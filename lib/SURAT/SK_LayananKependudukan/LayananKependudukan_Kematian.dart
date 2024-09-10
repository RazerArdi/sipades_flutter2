import 'package:flutter/material.dart';
import 'KEMATIAN/Kmt_SuratKeteranganKematian.dart';
import 'KEMATIAN/Kmt_SuratKematian.dart';
import 'KEMATIAN/Kmt_SuratKeteranganPenguburan.dart';

// Widget utama untuk menampilkan layanan terkait kematian
class LayananKependudukanKematian extends StatefulWidget {
  @override
  _LayananKependudukanKematianState createState() =>
      _LayananKependudukanKematianState();
}

class _LayananKependudukanKematianState
    extends State<LayananKependudukanKematian> {
  // Daftar item layanan yang akan ditampilkan
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Surat Keterangan Kematian (F-2.29)',
      'subtitle': '',
      'widget': Kmt_SuratKeteranganKematian() // Widget untuk surat keterangan kematian
    },
    {
      'title': 'Surat Kematian (A-5)',
      'subtitle': '',
      'widget': Kmt_SuratKematian() // Widget untuk surat kematian
    },
    {
      'title': 'Surat Keterangan Penguburan',
      'subtitle': '',
      'widget': Kmt_SuratKeteranganPenguburan() // Widget untuk surat keterangan penguburan
    },
  ];

  // Daftar item yang sudah difilter berdasarkan query pencarian
  List<Map<String, dynamic>> _filteredItems = [];

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
            item['title'].toLowerCase().contains(query.toLowerCase()))
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
        title: const Text('Kematian'), // Judul pada AppBar
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
                hintText: 'Cari Formulir Kematian...', // Teks petunjuk pada TextField
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
                return ListTile(
                  leading: Icon(Icons.document_scanner), // Ikon di sebelah kiri teks
                  title: Text(item['title']), // Judul item
                  subtitle: Text(item['subtitle']), // Subtitle item (kosong dalam kasus ini)
                  onTap: () {
                    // Menavigasi ke halaman detail berdasarkan widget item
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item['widget']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
