import 'package:flutter/material.dart';

class LayananNikah_SuratKeteranganDudaJanda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Keterangan Duda/Janda'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Detail Surat Keterangan Duda/Janda',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
