import 'package:flutter/material.dart';

class Klan_FormulirPengajuanPerubahanAktaKelahiran extends StatelessWidget {
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
        title: const Text('Formulir Pengajuan Perubahan Akta Kelahiran (F-2.03)'),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Text('Isi atau informasi tentang Formulir Pengajuan Perubahan Akta Kelahiran'),
      ),
    );
  }
}
