import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRImo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image covering the top half
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ilustrasi.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Blue background with wave shape for the lower half
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: WavePainter(),
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
          // Content on top of the background
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Image.asset('assets/images/LogoMalang.png', height: 50, width: 50,),
                  SizedBox(height: 370),
                  Text(
                    'Halo, sobat ngawonggo',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Beberapa Layanan Kami',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMenuItem('assets/images/aduanmasyarakat.png', 'Aduan Masyarakat'),
                        _buildMenuItem('assets/images/Surat.png', 'Surat/Berkas'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMenuItem('assets/images/registrasipenduduk.png', 'Registrasi Penduduk Baru'),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FingerprintScreen()),
                      );
                    },
                    child: Icon(Icons.fingerprint),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String iconPath, String title) {
    return Column(
      children: [
        Image.asset(iconPath, height: 50),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 40);
    for (double i = 0; i <= size.width; i += 20) {
      path.lineTo(i, size.height - 40 + 20 * (i % 40 == 0 ? 1 : -1));
    }
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<Map<String, String>> fetchCredentials(String sheetId, String range) async {
    final url = 'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$range?key=AIzaSyBDNmKHYwvVVcG-VaPBy6uW63nu7ri5rXc';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['values'] as List;
      Map<String, String> credentials = {};

      for (var row in rows) {
        if (row.length >= 2) {
          credentials[row[0]] = row[1];
        }
      }
      return credentials;
    } else {
      throw Exception('Username atau Password Salah!!!');
    }
  }

  Future<Map<String, String>> fetchAdminCredentials() async {
    return await fetchCredentials('145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI', 'ADMIN!C2:D');
  }

  Future<Map<String, String>> fetchUserCredentials() async {
    return await fetchCredentials('1A2b3C4d5E6f7G8H9Ij0kLmNOpQrStUvWxYzA1B2C3D4', 'USERS!D2:E');
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final adminCredentials = await fetchAdminCredentials();
      final userCredentials = await fetchUserCredentials();

      if (adminCredentials[username] == password || userCredentials[username] == password) {
        // Show success dialog
        _showDialog('Login Berhasil', 'Selamat datang, $username!');
        // Navigate to HomeScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error dialog
        _showDialog('Login Gagal', 'Username atau Password Salah!');
      }
    } catch (e) {
      // Show error dialog for failed request
      _showDialog('Error', 'Terjadi kesalahan: $e');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
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
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

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
              'Please scan your fingerprint',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle fingerprint authentication logic here
              },
              child: Icon(Icons.fingerprint),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
