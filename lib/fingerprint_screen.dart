import 'package:flutter/material.dart';

class FingerprintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Authentication'),
      ),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text(
      'Fingerprint Authentication is currently under maintenance.',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 20),
    Icon(Icons.fingerprint, size: 100),
    SizedBox(height: 20),
    ElevatedButton(
    onPressed: null, // Nonaktifkan tombol
    child: Text('Authenticate'),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey, // Ubah warna tombol untuk menunjukkan
      // tidak aktif
    ),
    ),
      ],
      ),
      ),
    );
  }
}
//