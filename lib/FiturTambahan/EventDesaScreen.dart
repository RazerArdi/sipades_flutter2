import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Event {
  final String judul;
  final String pukul;
  final String deskripsi;
  final String gambar;
  final LatLng lokasi;

  Event({
    required this.judul,
    required this.pukul,
    required this.deskripsi,
    required this.gambar,
    required this.lokasi,
  });
}

class EventDesaScreen extends StatefulWidget {
  @override
  _EventDesaScreenState createState() => _EventDesaScreenState();
}

class _EventDesaScreenState extends State<EventDesaScreen> {
  final MapController _mapController = MapController();
  final LatLng _center = LatLng(-8.07821720767281, 112.70450735756494);
  List<Marker> _markers = [];
  List<Event> _events = [];
  List<Event> _filteredEvents = [];
  TextEditingController _searchController = TextEditingController();

  // Konfigurasi API Google Sheets
  final String _spreadsheetId = "145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI";
  final String _apiKey = "AIzaSyDVMk7THB2jItPxfADasNiJDRDn8COkAtg";

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengonversi link Google Drive ke direct link
  String convertToDirectLink(String driveLink) {
    final regex = RegExp(r'file/d/([^/]+)/');
    final match = regex.firstMatch(driveLink);
    if (match != null) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    } else {
      return driveLink;
    }
  }

  // Mengambil data dari Google Sheets
  Future<void> _fetchEvents() async {
    final url = 'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/EVENT!A:E?key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rows = data['values'] as List<dynamic>;

      final List<Event> events = rows.skip(1).map((row) {
        final coords = row[4].split(','); // Memisahkan lat dan lon
        final directImageLink = convertToDirectLink(row[3]); // Konversi link gambar

        return Event(
          judul: row[0],
          pukul: row[1],
          deskripsi: row[2],
          gambar: directImageLink,
          lokasi: LatLng(double.parse(coords[0]), double.parse(coords[1])),
        );
      }).toList();

      setState(() {
        _events = events;
        _filteredEvents = events;
        _updateMarkers();
      });
    } else {
      print("Failed to load data from Google Sheets");
    }
  }

  // Memperbarui penanda berdasarkan filter pencarian
  void _updateMarkers() {
    _markers = _filteredEvents.map((event) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: event.lokasi,
        child: GestureDetector(
          onTap: () => _showEventDetail(event),
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40.0,
          ),
        ),
      );
    }).toList();
  }

  // Menampilkan popup dengan detail acara
  void _showEventDetail(Event event) async {
    final file = await DefaultCacheManager().getSingleFile(event.gambar);

    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.judul,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text("Pukul: ${event.pukul}"),
              SizedBox(height: 8.0),
              Text(event.deskripsi),
              SizedBox(height: 8.0),
              file != null
                  ? Image.file(file, height: 150) // Menampilkan gambar dari cache
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  // Mencari event berdasarkan judul dan deskripsi
  void _searchEvents(String query) {
    final filteredEvents = _events.where((event) {
      return event.judul.toLowerCase().contains(query.toLowerCase()) ||
          event.deskripsi.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredEvents = filteredEvents;
      _updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Desa"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Cari Event",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchEvents(_searchController.text);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
