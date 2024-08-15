import 'package:flutter/material.dart';

class LayananNikah_PengantarNikah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengantar Nikah (N1-N6)'),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Detail Pengantar Nikah (N1-N6)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
