import 'package:flutter/material.dart';
import 'KELAHIRAN/Klan_SuratKeteranganKelahiran.dart';
import 'KELAHIRAN/Klan_FormulirPermohonanAktaKelahiran.dart';
import 'KELAHIRAN/Klan_SuratPernyataanKelahiran.dart';
import 'KELAHIRAN/Klan_FormulirPengajuanPerubahanAktaKelahiran.dart';

class LayananKependudukanKelahiran extends StatefulWidget {
  @override
  _LayananKependudukanKelahiranState createState() =>
      _LayananKependudukanKelahiranState();
}

class _LayananKependudukanKelahiranState
    extends State<LayananKependudukanKelahiran> {
  final List<Map<String, String>> _items = [
    {'title': 'Surat Keterangan Kelahiran', 'route': '/suratKeteranganKelahiran'},
    {'title': 'Formulir Permohonan Akta Kelahiran (F-2.01)', 'route': '/formulirPermohonanAktaKelahiran'},
    {'title': 'Surat Pernyataan Kelahiran (F-2.02)', 'route': '/suratPernyataanKelahiran'},
    {'title': 'Formulir Pengajuan Perubahan Akta Kelahiran (F-2.03)', 'route': '/formulirPengajuanPerubahanAktaKelahiran'},
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
        title: const Text('Kelahiran'),
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
                fillColor: Colors.white,
                hintText: 'Cari Formulir Kelahiran...',
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
                  icon: Icons.person,
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
            case '/suratKeteranganKelahiran':
              return Klan_SuratKeteranganKelahiran();
            case '/formulirPermohonanAktaKelahiran':
              return Klan_FormulirPermohonanAktaKelahiran();
            case '/suratPernyataanKelahiran':
              return Klan_SuratPernyataanKelahiran();
            case '/formulirPengajuanPerubahanAktaKelahiran':
              return Klan_FormulirPengajuanPerubahanAktaKelahiran();
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
