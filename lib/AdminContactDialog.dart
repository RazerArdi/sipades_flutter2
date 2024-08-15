import 'package:flutter/material.dart';

class AdminContactDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          'Kontak Admin',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.admin_panel_settings,
                size: 60,
                color: Colors.white,
              ),
            ),
            ),
            SizedBox(height: 15),
            Text(
              'Email: ngawonggodesa@gmail.com',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              'Nomor Telepon: \n6281000000000',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Tutup',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
