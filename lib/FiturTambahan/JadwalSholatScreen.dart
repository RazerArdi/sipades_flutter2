import 'package:flutter/material.dart';

class JadwalSholatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waktu Sholat"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white70, // Background color for the whole body
        ),
        child: Stack(
          children: <Widget>[
            // Background image at the top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height, // Set height to 40% of the screen height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/masjid_background.png"),
                    fit: BoxFit.cover, // Use BoxFit.cover to maintain aspect ratio
                  ),
                ),
              ),
            ),
            // Content below the image
            Column(
              children: <Widget>[
                SizedBox(height: 25), // Space for the image
                // Bagian atas dengan waktu shalat berikutnya
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.nightlight_round,
                        color: Colors.blue,
                        size: 80.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Isya 07:06",
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "2 Jam 25 Menit Lagi",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bagian bawah dengan daftar waktu shalat
                Container(
                  color: Colors.white70,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Hari ini",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Jumat, 30 Juni 2017 / 6 Syawal 1438"),
                      SizedBox(height: 16.0),
                      _buildWaktuShalatItem("Subuh", "04:43 AM", true),
                      _buildWaktuShalatItem("Fajar", "06:04 AM", false),
                      _buildWaktuShalatItem("Dzhur", "11:59 AM", true),
                      _buildWaktuShalatItem("Ashar", "03:20 PM", true),
                      _buildWaktuShalatItem("Maghrib", "05:52 PM", true),
                      _buildWaktuShalatItem("Isya", "07:06 PM", true),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaktuShalatItem(String waktu, String jam, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            waktu,
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                jam,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(
                isActive ? Icons.notifications_active : Icons.notifications_off,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
