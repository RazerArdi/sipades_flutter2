import 'package:flutter/material.dart';
import 'GoogleSheetsService_LupaUsername.dart';


class LupaUsernameScreen extends StatefulWidget {
  @override
  _LupaUsernameScreenState createState() => _LupaUsernameScreenState();
}

class _LupaUsernameScreenState extends State<LupaUsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _kkController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  late GoogleSheetsService _googleSheetsService;

  @override
  void initState() {
    super.initState();
    _googleSheetsService = GoogleSheetsService('145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
  }

  Future<void> _submitRequest() async {
    final nik = _nikController.text;
    final kk = _kkController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    if (_formKey.currentState!.validate()) {
      try {
        bool isRegistered = await _googleSheetsService.isNIKKKRegistered(nik, kk);

        if (isRegistered) {
          await _googleSheetsService.recordRequest('PERMINTAAN', {
            'ID': '',
            'NIK': nik,
            'KK': kk,
            'EMAIL': email,
            'NOMOR TELEPON': phone,
            'JENIS PERUBAHAN': 'Lupa Username',
          });

          await _showDialog('Permintaan Berhasil', 'Permintaan Anda telah berhasil dicatat. Mohon ditunggu, konfirmasi dari ADMIN');
        } else {
          await _showDialog('Permintaan Gagal', 'NIK dan KK tidak terdaftar.');
        }
      } catch (e) {
        await _showDialog('Error', 'Terjadi kesalahan: $e');
      }
    }
  }

  Future<void> _showDialog(String title, String message) async {
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
                Navigator.of(context).pop();
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
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white),
        title: Text(
          'Lupa Username',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lupa Username',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Masukkan NIK, KK, Email, dan Nomor Telepon Anda untuk memulihkan username.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nikController,
                decoration: InputDecoration(
                  labelText: 'NIK',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _kkController,
                decoration: InputDecoration(
                  labelText: 'KK',
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'KK tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _submitRequest,
                  child: Text(
                    'Kirim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}//
