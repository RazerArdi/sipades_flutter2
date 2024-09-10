import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Untuk meluncurkan URL
import 'package:flutter/services.dart'; // Untuk mengakses sistem, seperti keluar dari aplikasi

// Kelas untuk tampilan halaman bantuan
class BantuanScreen extends StatelessWidget {
  const BantuanScreen({Key? key}) : super(key: key);

  // Fungsi untuk konfirmasi sebelum keluar dari halaman ini
  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari halaman ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Jika 'Tidak', kembali ke halaman tanpa keluar
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Jika 'Iya', keluar dari halaman
              SystemNavigator.pop(); // Keluar dari aplikasi
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context), // Menangani tombol kembali
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Padding di sekitar konten
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pusat Bantuan',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold, // Menampilkan teks dengan ukuran besar dan tebal
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Kamu dapat menghubungi kami melalui:',
                style: TextStyle(
                  fontSize: 16.0, // Ukuran teks
                ),
              ),
              const SizedBox(height: 16.0),
              _ContactItem(
                icon: Icons.phone,
                label: 'WhatsApp Kami',
                phoneNumber: '6281000000000',
                contactInfo: '6281000000000', // Nomor telepon WhatsApp
              ),
              const SizedBox(height: 16.0),
              _ContactItem(
                icon: Icons.email,
                label: 'Email Kami',
                email: 'ngawonggodesa@gmail.com',
                contactInfo: 'ngawonggodesa@gmail.com', // Email
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk menampilkan item kontak
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? phoneNumber; // Nomor telepon opsional
  final String? email; // Email opsional
  final String contactInfo; // Informasi kontak yang ditampilkan

  const _ContactItem({
    Key? key,
    required this.icon,
    required this.label,
    this.phoneNumber,
    this.email,
    required this.contactInfo,
  }) : super(key: key);

  // Fungsi untuk meluncurkan URL
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url)); // Meluncurkan URL
    } else {
      throw 'Could not launch $url'; // Menangani kesalahan jika URL tidak bisa diluncurkan
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Menangani aksi tap pada item kontak
        if (phoneNumber != null) {
          _launchURL('https://wa.me/$phoneNumber'); // Meluncurkan WhatsApp jika nomor telepon ada
        } else if (email != null) {
          _launchURL('mailto:$email'); // Meluncurkan email jika alamat email ada
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0), // Padding di dalam kontainer
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Radius sudut kontainer
          color: Colors.white, // Warna latar belakang kontainer
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Warna bayangan
              spreadRadius: 2, // Jarak sebar bayangan
              blurRadius: 5, // Jarak buram bayangan
              offset: const Offset(0, 3), // Offset bayangan
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32.0, color: Colors.purple), // Menampilkan ikon
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 16.0), // Menampilkan label kontak
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              contactInfo,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black, // Warna teks hitam
              ),
            ),
          ],
        ),
      ),
    );
  }
}
