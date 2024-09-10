import 'package:flutter/material.dart'; // Mengimpor paket Flutter Material
import 'package:sipades_flutter2/LupaPasswordScreen.dart'; // Mengimpor layar Lupa Password
import 'package:sipades_flutter2/LupaUsernameScreen.dart'; // Mengimpor layar Lupa Username

// Kelas untuk tampilan layar pilihan lupa username atau password
class LupaKataSandiORRusername extends StatefulWidget {
  @override
  _LupaKataSandiORRusernameState createState() => _LupaKataSandiORRusernameState();
}

// State untuk LupaKataSandiORRusername
class _LupaKataSandiORRusernameState extends State<LupaKataSandiORRusername> {
  bool _isUsernameSelected = false; // Variabel untuk menentukan pilihan (Username atau Password)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
        leading: BackButton(color: Colors.white), // Tombol kembali dengan warna putih
        title: Text(
          'Lupa Username/Password',
          style: TextStyle(color: Colors.white), // Warna teks judul
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Mengatur konten kolom ke kiri
          children: [
            Text(
              'Pilih Lupa Username Atau Password',
              style: TextStyle(
                fontSize: 18, // Ukuran font judul
                fontWeight: FontWeight.bold, // Membuat font tebal
              ),
            ),
            SizedBox(height: 10), // Jarak vertikal
            Text(
              'Pilih Lupa Username atau Password sesuai dengan kebutuhan kamu',
              style: TextStyle(fontSize: 14), // Ukuran font deskripsi
            ),
            SizedBox(height: 20), // Jarak vertikal
            Card(
              child: ListTile(
                leading: Radio(
                  value: true, // Nilai radio untuk memilih Username
                  groupValue: _isUsernameSelected,
                  onChanged: (value) {
                    setState(() {
                      _isUsernameSelected = value!; // Mengubah status pilihan
                    });
                  },
                ),
                title: Text('Lupa Username'),
                subtitle: Text(
                  'Fitur lupa username digunakan untuk melihat kembali username (NIK atau ID KK) yang terdaftar',
                  style: TextStyle(fontSize: 12), // Ukuran font deskripsi
                ),
              ),
            ),
            SizedBox(height: 20), // Jarak vertikal
            Card(
              child: ListTile(
                leading: Radio(
                  value: false, // Nilai radio untuk memilih Password
                  groupValue: _isUsernameSelected,
                  onChanged: (value) {
                    setState(() {
                      _isUsernameSelected = value!; // Mengubah status pilihan
                    });
                  },
                ),
                title: Text('Lupa Password'),
                subtitle: Text(
                  'Fitur lupa password digunakan untuk membuat password kembali dan membuka blokir Akun',
                  style: TextStyle(fontSize: 12), // Ukuran font deskripsi
                ),
              ),
            ),
            Spacer(), // Menyediakan ruang kosong di antara pilihan dan tombol
            Container(
              width: double.infinity, // Tombol mengisi lebar penuh
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 15), // Padding vertikal tombol
                ),
                onPressed: () {
                  // Aksi saat tombol ditekan
                  if (_isUsernameSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LupaUsernameScreen()), // Navigasi ke layar Lupa Username
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LupaPasswordScreen()), // Navigasi ke layar Lupa Password
                    );
                  }
                },
                child: Text(
                  'Lanjutkan',
                  style: TextStyle(color: Colors.white), // Warna teks tombol
                ),
              ),
            ),
            SizedBox(height: 20), // Jarak vertikal
          ],
        ),
      ),
    );
  }
}
