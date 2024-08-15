import 'package:flutter/material.dart';

class Klan_SuratPernyataanKelahiran extends StatelessWidget {
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
        title: const Text('Surat Pernyataan Kelahiran (F-2.02)'),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Text('Isi atau informasi tentang Surat Pernyataan Kelahiran'),
      ),
    );
  }
}
