import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // For LatLng coordinates

class EventDesaScreen extends StatefulWidget {
  @override
  _EventDesaScreenState createState() => _EventDesaScreenState();
}

class _EventDesaScreenState extends State<EventDesaScreen> {
  final MapController _mapController = MapController();
  final LatLng _center = LatLng(-6.24064226674634, 106.84254620231945); // Jakarta
  final List<Marker> _markers = [];

  // Function to add markers to the list of markers
  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: position,
          child: Builder(
          builder: (ctx) => Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40.0,
          ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Desa with Flutter Map"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              maxZoom: 13.0,
              onTap: (tapPosition, point) {
                _addMarker(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.eventdesa',
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search for event...',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                _addMarker(_center);
              },
              tooltip: 'Add Marker',
              child: Icon(Icons.add_location),
            ),
          ),
        ],
      ),
    );
  }
}
