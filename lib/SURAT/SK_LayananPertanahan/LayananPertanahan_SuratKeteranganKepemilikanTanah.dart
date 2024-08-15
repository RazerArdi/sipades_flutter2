import 'package:flutter/material.dart';

class LayananPertanahan_SuratKeteranganKepemilikanTanah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Kepemilikan Tanah'),
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
          'Halaman Surat Keterangan Kepemilikan Tanah',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
