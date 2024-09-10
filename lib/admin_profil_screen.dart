import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'First_Page.dart';
import 'CacheManager.dart';
import 'AboutUsDialog.dart';
import 'AdminContactDialog.dart';
import 'FAQScreen.dart';
import 'PrivacyPolicyScreen.dart';

// Halaman Profil Admin
class AdminProfilScreen extends StatefulWidget {
  const AdminProfilScreen({Key? key}) : super(key: key);

  @override
  _AdminProfilScreenState createState() => _AdminProfilScreenState();
}

class _AdminProfilScreenState extends State<AdminProfilScreen> {

  // Method untuk menghapus cache aplikasi
  Future<void> _clearCache() async {
    try {
      await CacheManager.clearCache(); // Menghapus cache
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache berhasil dihapus')), // Menampilkan notifikasi jika berhasil
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus cache')), // Menampilkan notifikasi jika gagal
      );
    }
  }

  // Method untuk menampilkan dialog konfirmasi saat keluar dari halaman
  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari halaman ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Tidak keluar dari halaman
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // Keluar dari aplikasi
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false; // Mengembalikan keputusan pengguna
  }

  // Method untuk menampilkan dialog konfirmasi saat logout
  Future<void> _showLogoutConfirmation() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Tidak logout
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()), // Mengarahkan ke halaman utama
                    (Route<dynamic> route) => false, // Menghapus semua halaman sebelumnya
              );
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    if (shouldLogout ?? false) {
      // Lakukan aksi logout di sini jika diperlukan
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Mengatur aksi saat tombol kembali ditekan
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Admin'), // Judul halaman
          automaticallyImplyLeading: false, // Menghilangkan tombol kembali default di AppBar
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Memberikan jarak di sekitar konten
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Menyusun elemen dari kiri ke kanan
              children: [
                const SizedBox(height: 40), // Jarak atas
                Center(
                  child: CircleAvatar(
                    radius: 50, // Radius avatar
                    backgroundImage: AssetImage('assets/images/user.png'), // Gambar profil
                  ),
                ),
                const SizedBox(height: 20), // Jarak antara avatar dan teks
                const Text(
                  'ADMIN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Informasi Akun',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Menampilkan informasi akun dengan ListTile
                ListTile(
                  leading: Icon(Icons.perm_identity),
                  title: Text('ID NIK'),
                  trailing: const Text('ADMIN'),
                ),
                ListTile(
                  leading: Icon(Icons.perm_identity),
                  title: Text('NAMA LENGKAP'),
                  trailing: const Text('ADMIN'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Akun Saya',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Menampilkan opsi-opsi dengan ListTile yang dapat diklik
                _buildProfileItem(
                  icon: Icons.delete_sweep,
                  title: 'Hapus Cache',
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: _clearCache, // Menjalankan fungsi hapus cache
                ),
                _buildProfileItem(
                  icon: Icons.info,
                  title: 'Tentang Kami',
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AboutUsDialog(), // Menampilkan dialog tentang kami
                    );
                  },
                ),
                _buildProfileItem(
                  icon: Icons.question_answer,
                  title: 'FAQ',
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQScreen()), // Mengarahkan ke halaman FAQ
                    );
                  },
                ),
                _buildProfileItem(
                  icon: Icons.privacy_tip,
                  title: 'Kebijakan Privasi',
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()), // Mengarahkan ke halaman kebijakan privasi
                    );
                  },
                ),
                _buildProfileItem(
                  icon: Icons.phone,
                  title: 'Hubungi Kami',
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AdminContactDialog(), // Menampilkan dialog kontak admin
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Tombol untuk logout
                Center(
                  child: ElevatedButton(
                    onPressed: _showLogoutConfirmation, // Menampilkan konfirmasi logout
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Warna tombol
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Padding tombol
                      textStyle: const TextStyle(fontSize: 16), // Ukuran teks tombol
                    ),
                    child: const Text('Log Out'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method untuk membangun item profil dengan ikon, judul, dan aksi klik
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required Widget trailing,
    void Function()? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon), // Ikon di samping kiri
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold, // Menebalkan teks judul
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null, // Menampilkan subtitle jika ada
          trailing: trailing, // Widget di samping kanan
          onTap: onTap, // Aksi klik
        ),
        const Divider(
          color: Colors.grey, // Warna pembatas
          thickness: 1.0, // Ketebalan pembatas
        ),
      ],
    );
  }
}
