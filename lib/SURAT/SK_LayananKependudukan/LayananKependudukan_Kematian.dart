import 'package:flutter/material.dart';
import 'KEMATIAN/Kmt_SuratKeteranganKematian.dart';
import 'KEMATIAN/Kmt_SuratKematian.dart';
import 'KEMATIAN/Kmt_SuratKeteranganPenguburan.dart';

class LayananKependudukanKematian extends StatefulWidget {
  @override
  _LayananKependudukanKematianState createState() =>
      _LayananKependudukanKematianState();
}

class _LayananKependudukanKematianState
    extends State<LayananKependudukanKematian> {
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Surat Keterangan Kematian (F-2.29)',
      'subtitle': '',
      'widget': Kmt_SuratKeteranganKematian()
    },
    {
      'title': 'Surat Kematian (A-5)',
      'subtitle': '',
      'widget': Kmt_SuratKematian()
    },
    {
      'title': 'Surat Keterangan Penguburan',
      'subtitle': '',
      'widget': Kmt_SuratKeteranganPenguburan()
    },
  ];

  List<Map<String, dynamic>> _filteredItems = [];

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
            Navigator.pop(context);
          },
        ),
        title: const Text('Kematian'),
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
                hintText: 'Cari Formulir Kematian...',
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
                return ListTile(
                  leading: Icon(Icons.document_scanner),
                  title: Text(item['title']),
                  subtitle: Text(item['subtitle']),
                  onTap: () {
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
