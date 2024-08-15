import 'package:flutter/material.dart';

class LayananPertanahan_SuratKeteranganPencocokanSporadik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Pencocokan Sporadik'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: const Text(
          'Halaman Surat Keterangan Pencocokan Sporadik',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
