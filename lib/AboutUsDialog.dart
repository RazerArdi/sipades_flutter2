import 'package:flutter/material.dart';

class AboutUsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tentang Kami'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/KITA.png'),
          SizedBox(height: 16),
          Text(
            'We are an Advisory Firm who specializes in Business and Security Intelligence, providing a full spectrum of services and solutions with a focus on Political Risk, Security, Defence, and Aerospace sectors.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Tutup'),
        ),
      ],
    );
  }
}
