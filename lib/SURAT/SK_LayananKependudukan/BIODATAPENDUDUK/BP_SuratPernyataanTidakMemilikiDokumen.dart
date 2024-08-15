import 'package:flutter/material.dart';

class BP_SuratPernyataanTidakMemilikiDokumen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Pernyataan Tidak Memiliki Dokumen'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Text('Detail for Surat Pernyataan Tidak Memiliki Dokumen Kependudukan (F-1.04)'),
      ),
    );
  }
}
