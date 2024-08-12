import 'package:flutter/material.dart';
import 'wave_painter.dart';
import 'login_screen.dart';
import 'fingerprint_screen.dart';

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
