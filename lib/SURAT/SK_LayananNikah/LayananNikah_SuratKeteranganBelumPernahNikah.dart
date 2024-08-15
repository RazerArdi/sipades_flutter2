import 'package:flutter/material.dart';

class LayananNikah_SuratKeteranganBelumPernahNikah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Keterangan Belum Pernah Nikah'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Detail Surat Keterangan Belum Pernah Nikah',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
