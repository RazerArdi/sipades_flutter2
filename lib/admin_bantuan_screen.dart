import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

// Halaman bantuan untuk admin
class AdminBantuanScreen extends StatelessWidget {
  const AdminBantuanScreen({Key? key}) : super(key: key);

  // Method untuk menampilkan dialog konfirmasi saat mencoba keluar dari halaman
  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari halaman ini?'),
        actions: [
          // Tombol untuk tidak keluar
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          // Tombol untuk keluar dari aplikasi
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Tutup dialog
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
      onWillPop: () => _onWillPop(context), // Mengatur aksi saat tombol back ditekan
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bantuan Admin'),
          automaticallyImplyLeading: false, // Menghilangkan tombol kembali default
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul bagian bantuan
              const Text(
                'Pusat Bantuan',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0), // Jarak antara judul dan teks berikutnya
              // Instruksi untuk menghubungi tim bantuan
              const Text(
                'Kamu dapat menghubungi kami melalui:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0), // Jarak antara instruksi dan item kontak
              // Widget untuk menampilkan item kontak WhatsApp
              _ContactItem(
                icon: Icons.phone,
                label: 'WhatsApp Developer',
                phoneNumber: '6281330483643',
                contactInfo: '6281330483643',
              ),
              const SizedBox(height: 16.0), // Jarak antara item kontak
              // Widget untuk menampilkan item kontak Email
              _ContactItem(
                icon: Icons.email,
                label: 'Email Developer',
                email: 'bayuardi30@outlook.com',
                contactInfo: 'bayuardi30@outlook.com',
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
  final String? phoneNumber;
  final String? email;
  final String contactInfo;

  const _ContactItem({
    Key? key,
    required this.icon,
    required this.label,
    this.phoneNumber,
    this.email,
    required this.contactInfo,
  }) : super(key: key);

  // Method untuk membuka URL sesuai dengan tipe kontak
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (phoneNumber != null) {
          final whatsappUrl = 'https://wa.me/$phoneNumber'; // URL WhatsApp
          _launchURL(whatsappUrl);
        } else if (email != null) {
          final emailUrl = 'mailto:$email'; // URL Email
          _launchURL(emailUrl);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris yang menampilkan ikon dan label
            Row(
              children: [
                Icon(icon, size: 32.0, color: Colors.purple),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0), // Jarak antara ikon dan info kontak
            // Menampilkan informasi kontak
            Text(
              contactInfo,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
