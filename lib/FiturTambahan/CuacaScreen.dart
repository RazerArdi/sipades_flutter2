import 'package:flutter/material.dart';

class CuacaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C1021),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan tanggal dan ikon cuaca utama
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monday, 14 June",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "20°C",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.thunderstorm,
                  size: 80,
                  color: Colors.white,
                ),
              ],
            ),

            // Lokasi cuaca
            SizedBox(height: 10),
            Center(
              child: Text(
                "Malang, East Java",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Informasi detail cuaca
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherInfo("Wind", "30km/h", Icons.air),
                _buildWeatherInfo("Humidity", "19%", Icons.water_drop),
                _buildWeatherInfo("Visibility", "6km", Icons.remove_red_eye),
              ],
            ),

            // Grafik cuaca
            SizedBox(height: 30),
            _buildWeatherGraph(),

            // Daftar cuaca nearby
            SizedBox(height: 30),
            Text(
              "Nearby",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildNearbyWeather("Tegal", "21°C", "Rainy Shower"),
                  _buildNearbyWeather("Purwokerto", "19°C", "Rainy Shower"),
                  _buildNearbyWeather("Cirebon", "20°C", "Cloudy"),
                  _buildNearbyWeather("Banjarnegara", "18°C", "Rainy Shower"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi cuaca (kecepatan angin, kelembaban, visibilitas)
  Widget _buildWeatherInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  // Widget untuk menampilkan nearby weather
  Widget _buildNearbyWeather(String location, String temperature, String condition) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 120,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF282B4B),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            location,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            temperature,
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            condition,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 10),
          Icon(
            condition.contains("Rainy") ? Icons.cloud : Icons.wb_sunny,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan grafik cuaca
  Widget _buildWeatherGraph() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF282B4B),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildWeatherGraphPoint("11am", "23°"),
          _buildWeatherGraphPoint("Now", "20°"),
          _buildWeatherGraphPoint("01pm", "24°"),
          _buildWeatherGraphPoint("02pm", "21°"),
          _buildWeatherGraphPoint("03pm", "29°"),
        ],
      ),
    );
  }

  // Grafik cuaca per titik waktu
  Widget _buildWeatherGraphPoint(String time, String temp) {
    return Column(
      children: [
        Text(
          temp,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 5),
        Container(
          width: 4,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow,
          ),
        ),
        SizedBox(height: 5),
        Text(
          time,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }
}
