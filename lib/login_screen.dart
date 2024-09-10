import 'package:flutter/material.dart'; // Mengimpor paket Flutter Material
import 'GoogleSheetsServiceLOGIN.dart'; // Mengimpor layanan untuk login melalui Google Sheets
import 'AdminHomeScreen.dart'; // Mengimpor layar beranda admin
import 'UserHomeScreen.dart'; // Mengimpor layar beranda pengguna
import 'LupaKataSandiORRusername.dart'; // Mengimpor layar untuk lupa password atau username

// Kelas untuk tampilan layar login
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// State untuk LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(); // Controller untuk input username
  final _passwordController = TextEditingController(); // Controller untuk input password
  bool _obscureText = true; // Status apakah teks password tersembunyi atau tidak
  final _googleSheetsService = GoogleSheetsServiceLOGIN(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI'); // Instansi layanan Google Sheets

  // Fungsi untuk melakukan proses login
  Future<void> _login() async {
    final username = _usernameController.text; // Mengambil nilai username
    final password = _passwordController.text; // Mengambil nilai password

    try {
      // Mengambil data kredensial admin dan pengguna dari Google Sheets
      final adminCredentials = await _googleSheetsService.fetchCredentials('ADMIN!C:D');
      final userCredentials = await _googleSheetsService.fetchCredentials('USERS!E:F');

      // Mengecek apakah kredensial cocok untuk admin atau pengguna
      if (adminCredentials[username] == password) {
        await _showDialogAndNavigate('Login Berhasil', 'Selamat datang, Admin!', true, 'admin'); // Arahkan ke beranda admin
      } else if (userCredentials[username] == password) {
        await _showDialogAndNavigate('Login Berhasil', 'Selamat datang, $username!', true, 'user'); // Arahkan ke beranda pengguna
      } else {
        await _showDialogAndNavigate('Login Gagal', 'Username atau Password Salah!', false, ''); // Tampilkan pesan kesalahan login
      }
    } catch (e) {
      await _showDialogAndNavigate('Error', 'Terjadi kesalahan: $e', false, ''); // Tampilkan pesan kesalahan jika terjadi exception
    }
  }

  // Fungsi untuk menampilkan dialog dan mengarahkan pengguna sesuai dengan hasil login
  Future<void> _showDialogAndNavigate(String title, String message, bool isSuccess, String role) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                if (isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => role == 'admin'
                          ? AdminHomeScreen() // Arahkan ke beranda admin
                          : UserHomeScreen(username: _usernameController.text), // Arahkan ke beranda pengguna
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'), // Judul layar login
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menyusun elemen secara vertikal di tengah
            children: [
              Text(
                'Masukkan Data login Anda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Membuat font tebal
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username', // Label untuk input username
                ),
              ),
              Stack(
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText, // Menyembunyikan teks password
                    decoration: InputDecoration(
                      labelText: 'Password', // Label untuk input password
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off, // Ikon untuk menampilkan/mempersembunyikan password
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText; // Mengubah status penyembunyian password
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login, // Aksi saat tombol login ditekan
                child: Text('Login'), // Teks tombol login
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LupaKataSandiORRusername()), // Navigasi ke layar lupa password atau username
                  );
                },
                child: Text(
                  'Lupa Kata Sandi',
                  style: TextStyle(
                    color: Colors.blueAccent, // Warna teks tombol
                    fontWeight: FontWeight.bold, // Membuat font tebal
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
