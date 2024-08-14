import 'package:flutter/material.dart';

class EventDesaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Desa"),
      ),
      body: Center(
        child: Text('Tampilkan Event Desa di sini'),
      ),
    );
  }
}