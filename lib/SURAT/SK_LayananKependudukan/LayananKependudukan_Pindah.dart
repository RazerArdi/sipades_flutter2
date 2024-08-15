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

class LayananKependudukanPindah extends StatefulWidget {
  @override
  _LayananKependudukanPindahState createState() =>
      _LayananKependudukanPindahState();
}

class _LayananKependudukanPindahState
    extends State<LayananKependudukanPindah> {
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

  List<Map<String, String>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _items;
      } else {
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
            Navigator.pop(context);
          },
        ),
        title: const Text('Pindah'),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterItems,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return _Item(
                  icon: Icons.file_copy,
                  title: item['title']!,
                  onTap: () {
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
                body: Center(child: Text('Page not found')),
              );
          }
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.black,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
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
