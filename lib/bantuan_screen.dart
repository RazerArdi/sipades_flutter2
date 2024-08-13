import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pusat Bantuan',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Kamu dapat menghubungi kami melalui:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            _ContactItem(
              icon: Icons.phone,
              label: 'WhatsApp Kami',
              phoneNumber: '6281000000000',
            ),
            const SizedBox(height: 16.0),
            _ContactItem(
              icon: Icons.email,
              label: 'Email Kami',
              email: 'ngawonggodesa@gmail.com',
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? phoneNumber;
  final String? email;

  const _ContactItem({
    Key? key,
    required this.icon,
    required this.label,
    this.phoneNumber,
    this.email,
  }) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (phoneNumber != null) {
          _launchURL('https://wa.me/$phoneNumber'); // Mengarahkan ke WhatsApp
        } else if (email != null) {
          _launchURL('mailto:$email'); // Mengarahkan ke aplikasi email
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32.0, color: Colors.purple),
            const SizedBox(width: 16.0),
            Text(
              label,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
