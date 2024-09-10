import 'package:flutter/material.dart';
import 'BIODATAPENDUDUK/BP_FormulirKartuKeluarga.dart';
import 'BIODATAPENDUDUK/BP_FormulirPendaftaranPeristiwa.dart';
import 'BIODATAPENDUDUK/BP_SuratPernyataanTidakMemilikiDokumen.dart';
import 'BIODATAPENDUDUK/BP_SuratPernyataanPerubahanData.dart';
import 'BIODATAPENDUDUK/BP_FormulirBiodataPenduduk.dart';
import 'BIODATAPENDUDUK/BP_SuratKuasa.dart';
import 'BIODATAPENDUDUK/BP_FormulirPermohonanKKBaru.dart';
import 'BIODATAPENDUDUK/BP_FormulirPermohonanPerubahanKK.dart';
import 'BIODATAPENDUDUK/BP_FormulirPermohonanKTP.dart';
import 'BIODATAPENDUDUK/BP_SuratKeteranganDomisili.dart';
import 'BIODATAPENDUDUK/BP_SuratKeteranganHilangKK.dart';

// Widget utama untuk menampilkan layanan kependudukan
class LayananKependudukanBiodataPenduduk extends StatefulWidget {
  @override
  _LayananKependudukanBiodataPendudukState createState() =>
      _LayananKependudukanBiodataPendudukState();
}

class _LayananKependudukanBiodataPendudukState
    extends State<LayananKependudukanBiodataPenduduk> {
  // Daftar item layanan yang akan ditampilkan
  final List<Map<String, String>> _items = [
    {'title': 'Formulir Kartu Keluarga (Pengganti F-1.01)', 'subtitle': ''},
    {'title': 'Formulir Pendaftaran Peristiwa Kependudukan (F-1.02)', 'subtitle': ''},
    {'title': 'Surat Pernyataan Tidak Memiliki Dokumen Kependudukan (F-1.04)', 'subtitle': ''},
    {'title': 'Surat Pernyataan Perubahan Data Kependudukan (F-1.05)', 'subtitle': ''},
    {'title': 'Formulir Biodata Penduduk Untuk Perubahan Data WNI (F-1.06)', 'subtitle': ''},
    {'title': 'Surat Kuasa Dalam Pelayanan Administrasi Kependudukan (F-1.07)', 'subtitle': ''},
    {'title': 'Formulir Permohonan KK Baru WNI (F-1.15)', 'subtitle': ''},
    {'title': 'Formulir Permohonan Perubahan KK Baru WNI (F-1.16)', 'subtitle': ''},
    {'title': 'Formulir Permohonan KTP (F-1.21)', 'subtitle': ''},
    {'title': 'Surat Keterangan Domisili', 'subtitle': ''},
    {'title': 'Surat Keterangan Hilang Kartu Keluarga', 'subtitle': ''},
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
        title: const Text('Biodata Penduduk'), // Judul pada AppBar
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
                  icon: Icons.person, // Ikon untuk setiap item
                  title: item['title']!,
                  subtitle: item['subtitle']!,
                  onTap: () {
                    // Menavigasi ke halaman detail berdasarkan judul item
                    _navigateToDetailPage(context, item['title']!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menavigasi ke halaman detail berdasarkan judul item
  void _navigateToDetailPage(BuildContext context, String title) {
    switch (title) {
      case 'Formulir Kartu Keluarga (Pengganti F-1.01)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_FormulirKartuKeluarga()),
        );
        break;
      case 'Formulir Pendaftaran Peristiwa Kependudukan (F-1.02)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_FormulirPendaftaranPeristiwa()),
        );
        break;
      case 'Surat Pernyataan Tidak Memiliki Dokumen Kependudukan (F-1.04)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_SuratPernyataanTidakMemilikiDokumen()),
        );
        break;
      case 'Surat Pernyataan Perubahan Data Kependudukan (F-1.05)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_SuratPernyataanPerubahanData()),
        );
        break;
      case 'Formulir Biodata Penduduk Untuk Perubahan Data WNI (F-1.06)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_FormulirBiodataPenduduk()),
        );
        break;
      case 'Surat Kuasa Dalam Pelayanan Administrasi Kependudukan (F-1.07)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_SuratKuasa()),
        );
        break;
      case 'Formulir Permohonan KK Baru WNI (F-1.15)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_FormulirPermohonanKKBaru()),
        );
        break;
      case 'Formulir Permohonan Perubahan KK Baru WNI (F-1.16)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_FormulirPermohonanPerubahanKK()),
        );
        break;
      case 'Formulir Permohonan KTP (F-1.21)':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_FormulirPermohonanKTP()),
        );
        break;
      case 'Surat Keterangan Domisili':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_SuratKeteranganDomisili()),
        );
        break;
      case 'Surat Keterangan Hilang Kartu Keluarga':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BP_SuratKeteranganHilangKK()),
        );
        break;
      default:
      // Tangani kasus default jika diperlukan
        break;
    }
  }
}

// Widget untuk menampilkan item pada daftar layanan
class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final IconData icon; // Ikon yang ditampilkan di samping judul
  final String title; // Judul item
  final String subtitle; // Subtitle atau deskripsi item
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
                  const SizedBox(height: 4.0), // Jarak antara judul dan subtitle
                  Text(
                    subtitle.isNotEmpty ? subtitle : 'No additional details',
                    style: const TextStyle(
                      fontSize: 14.0, // Ukuran font subtitle
                      color: Colors.grey, // Warna teks subtitle
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
