import 'package:flutter/material.dart'; // Mengimpor paket Flutter Material
import 'GoogleSheetsService_LupaUsername.dart'; // Mengimpor layanan Google Sheets untuk pengelolaan data

// Kelas untuk tampilan layar lupa username
class LupaUsernameScreen extends StatefulWidget {
  @override
  _LupaUsernameScreenState createState() => _LupaUsernameScreenState();
}

// State untuk LupaUsernameScreen
class _LupaUsernameScreenState extends State<LupaUsernameScreen> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk form agar dapat divalidasi
  final _nikController = TextEditingController(); // Kontroler untuk input NIK
  final _kkController = TextEditingController(); // Kontroler untuk input KK
  final _emailController = TextEditingController(); // Kontroler untuk input Email
  final _phoneController = TextEditingController(); // Kontroler untuk input Nomor Telepon
  late GoogleSheetsService _googleSheetsService; // Instansi layanan Google Sheets

  @override
  void initState() {
    super.initState();
    // Inisialisasi GoogleSheetsService dengan ID sheet yang sesuai
    _googleSheetsService = GoogleSheetsService('145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
  }

  // Fungsi untuk mengirimkan permintaan
  Future<void> _submitRequest() async {
    final nik = _nikController.text;
    final kk = _kkController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    if (_formKey.currentState!.validate()) {
      try {
        // Mengecek apakah NIK dan KK terdaftar di Google Sheets
        bool isRegistered = await _googleSheetsService.isNIKKKRegistered(nik, kk);

        if (isRegistered) {
          // Merekam permintaan ke Google Sheets jika terdaftar
          await _googleSheetsService.recordRequest('PERMINTAAN', {
            'ID': '',
            'NIK': nik,
            'KK': kk,
            'EMAIL': email,
            'NOMOR TELEPON': phone,
            'JENIS PERUBAHAN': 'Lupa Username',
          });

          // Menampilkan dialog konfirmasi jika permintaan berhasil
          await _showDialog('Permintaan Berhasil', 'Permintaan Anda telah berhasil dicatat. Mohon ditunggu, konfirmasi dari ADMIN');
        } else {
          // Menampilkan dialog error jika NIK dan KK tidak terdaftar
          await _showDialog('Permintaan Gagal', 'NIK dan KK tidak terdaftar.');
        }
      } catch (e) {
        // Menampilkan dialog error jika terjadi kesalahan
        await _showDialog('Error', 'Terjadi kesalahan: $e');
      }
    }
  }

  // Fungsi untuk menampilkan dialog
  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Menonaktifkan penutupan dialog dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog saat tombol OK ditekan
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
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
        leading: BackButton(color: Colors.white), // Tombol kembali dengan warna putih
        title: Text(
          'Lupa Username',
          style: TextStyle(color: Colors.white), // Warna teks judul
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Mengaitkan kunci form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Mengatur konten kolom ke kiri
            children: [
              Text(
                'Lupa Username',
                style: TextStyle(
                  fontSize: 18, // Ukuran font judul
                  fontWeight: FontWeight.bold, // Membuat font tebal
                ),
              ),
              SizedBox(height: 10), // Jarak vertikal
              Text(
                'Masukkan NIK, KK, Email, dan Nomor Telepon Anda untuk memulihkan username.',
                style: TextStyle(fontSize: 14), // Ukuran font deskripsi
              ),
              SizedBox(height: 20), // Jarak vertikal
              TextFormField(
                controller: _nikController, // Mengaitkan kontroler dengan input NIK
                decoration: InputDecoration(
                  labelText: 'NIK',
                  prefixIcon: Icon(Icons.person), // Ikon untuk input NIK
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong'; // Validasi NIK
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Jarak vertikal
              TextFormField(
                controller: _kkController, // Mengaitkan kontroler dengan input KK
                decoration: InputDecoration(
                  labelText: 'KK',
                  prefixIcon: Icon(Icons.credit_card), // Ikon untuk input KK
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'KK tidak boleh kosong'; // Validasi KK
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Jarak vertikal
              TextFormField(
                controller: _emailController, // Mengaitkan kontroler dengan input Email
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email), // Ikon untuk input Email
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress, // Menentukan jenis keyboard untuk input email
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong'; // Validasi Email
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Email tidak valid'; // Validasi format Email
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Jarak vertikal
              TextFormField(
                controller: _phoneController, // Mengaitkan kontroler dengan input Nomor Telepon
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone), // Ikon untuk input Nomor Telepon
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone, // Menentukan jenis keyboard untuk input nomor telepon
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong'; // Validasi Nomor Telepon
                  }
                  return null;
                },
              ),
              Spacer(), // Menyediakan ruang kosong di antara form dan tombol
              Container(
                width: double.infinity, // Tombol mengisi lebar penuh
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna latar belakang tombol
                    padding: EdgeInsets.symmetric(vertical: 15), // Padding vertikal tombol
                  ),
                  onPressed: _submitRequest, // Fungsi yang dipanggil saat tombol ditekan
                  child: Text(
                    'Kirim',
                    style: TextStyle(color: Colors.white), // Warna teks tombol
                  ),
                ),
              ),
              SizedBox(height: 20), // Jarak vertikal
            ],
          ),
        ),
      ),
    );
  }
}
