import 'package:flutter/material.dart';

class CuacaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuaca"),
      ),
      body: Center(
        child: Text('Tampilkan Informasi Cuaca di sini'),
      ),
    );
  }
}