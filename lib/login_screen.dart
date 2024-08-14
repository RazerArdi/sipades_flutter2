import 'package:flutter/material.dart';
import 'GoogleSheetsServiceLOGIN.dart';
import 'AdminHomeScreen.dart';
import 'UserHomeScreen.dart';
import 'LupaKataSandiORRusername.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  final _googleSheetsService = GoogleSheetsServiceLOGIN(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final adminCredentials = await _googleSheetsService.fetchCredentials('ADMIN!C:D');
      final userCredentials = await _googleSheetsService.fetchCredentials('USERS!E:F');

      if (adminCredentials[username] == password) {
        await _showDialogAndNavigate('Login Berhasil', 'Selamat datang, Admin!', true, 'admin');
      } else if (userCredentials[username] == password) {
        await _showDialogAndNavigate('Login Berhasil', 'Selamat datang, $username!', true, 'user');
      } else {
        await _showDialogAndNavigate('Login Gagal', 'Username atau Password Salah!', false, '');
      }
    } catch (e) {
      await _showDialogAndNavigate('Error', 'Terjadi kesalahan: $e', false, '');
    }
  }

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
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => role == 'admin'
                          ? AdminScreen()
                          : UserHomeScreen(username: _usernameController.text),
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
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Masukkan Data login Anda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              Stack(
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LupaKataSandiORRusername()),
                  );
                },
                child: Text(
                  'Lupa Kata Sandi',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
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