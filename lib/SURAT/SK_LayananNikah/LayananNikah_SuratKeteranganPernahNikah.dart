import 'package:flutter/material.dart';

class LayananNikah_SuratKeteranganPernahNikah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Keterangan Pernah Nikah'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Detail Surat Keterangan Pernah Nikah',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
