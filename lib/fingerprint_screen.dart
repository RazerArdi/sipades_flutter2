import 'package:flutter/material.dart';

class FingerprintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Authentication'), // Judul di AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisikan di tengah secara vertikal
          children: [
            // Teks informasi tentang maintenance fitur fingerprint
            Text(
              'Fingerprint Authentication is currently under maintenance.', // Pesan pemberitahuan
              style: TextStyle(
                fontSize: 16, // Ukuran teks
                fontWeight: FontWeight.bold, // Teks tebal
                color: Colors.red, // Warna merah untuk menekankan pesan
              ),
              textAlign: TextAlign.center, // Teks di tengah
            ),
            SizedBox(height: 20), // Jarak antara teks dan ikon
            // Ikon fingerprint
            Icon(Icons.fingerprint, size: 100), // Ukuran ikon besar
            SizedBox(height: 20), // Jarak antara ikon dan tombol
            // Tombol otentikasi yang dinonaktifkan
            ElevatedButton(
              onPressed: null, // Tombol tidak aktif (null)
              child: Text('Authenticate'), // Label tombol
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Warna tombol abu-abu untuk menandakan tidak aktif
              ),
            ),
          ],
        ),
      ),
    );
  }
}
