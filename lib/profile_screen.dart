import 'package:flutter/material.dart'; // Mengimpor paket Flutter Material
import 'package:flutter/services.dart'; // Mengimpor paket Flutter Services
import 'GoogleSheetsServiceLOGIN.dart'; // Mengimpor layanan Google Sheets
import 'First_Page.dart'; // Mengimpor halaman utama
import 'CacheManager.dart'; // Mengimpor Cache Manager untuk mengelola cache
import 'AboutUsDialog.dart'; // Mengimpor dialog tentang kami
import 'AdminContactDialog.dart'; // Mengimpor dialog kontak admin
import 'FAQScreen.dart'; // Mengimpor layar FAQ
import 'PrivacyPolicyScreen.dart'; // Mengimpor layar kebijakan privasi

// Kelas untuk tampilan profil pengguna
class ProfileScreen extends StatefulWidget {
  final String username; // Menyimpan username pengguna

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, String>> userDetailsFuture; // Future untuk mengambil data pengguna

  @override
  void initState() {
    super.initState();
    userDetailsFuture = _fetchUserDetails(widget.username); // Memanggil fungsi untuk mengambil detail pengguna
  }

  // Fungsi untuk mengambil detail pengguna dari Google Sheets
  Future<Map<String, String>> _fetchUserDetails(String username) async {
    final googleSheetsService = GoogleSheetsServiceLOGIN(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
    try {
      final userDetails = await googleSheetsService.fetchUserDetails(username);
      return userDetails;
    } catch (e) {
      return {}; // Mengembalikan map kosong jika terjadi error
    }
  }

  // Fungsi untuk menghapus cache
  Future<void> _clearCache() async {
    try {
      await CacheManager.clearCache(); // Menghapus cache
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache berhasil dihapus')), // Menampilkan snackbar jika berhasil
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus cache')), // Menampilkan snackbar jika gagal
      );
    }
  }

  // Fungsi untuk konfirmasi sebelum keluar dari aplikasi
  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Tidak keluar jika memilih 'Tidak'
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // Keluar dari aplikasi jika memilih 'Ya'
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false; // Mengembalikan true jika memilih 'Ya', false jika tidak
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Mengatur aksi saat tombol kembali ditekan
      child: Scaffold(
        body: FutureBuilder<Map<String, String>>(
          future: userDetailsFuture, // Mengambil future data pengguna
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Menampilkan indikator loading saat menunggu data
            }

            final userDetails = snapshot.data ?? {};
            final nik = userDetails['NIK'] ?? 'Unknown'; // Mendapatkan NIK dari data pengguna
            final nama = userDetails['NAMA'] ?? 'Unknown'; // Mendapatkan nama dari data pengguna

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Padding untuk jarak tepi
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/user.png'), // Menampilkan gambar avatar pengguna
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.username,
                      style: const TextStyle(
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
                    ListTile(
                      leading: Icon(Icons.perm_identity), // Ikon untuk ID NIK
                      title: Text('ID NIK'),
                      trailing: Text(nik), // Menampilkan NIK
                    ),
                    ListTile(
                      leading: Icon(Icons.perm_identity), // Ikon untuk nama lengkap
                      title: Text('NAMA LENGKAP'),
                      trailing: Text(nama), // Menampilkan nama lengkap
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
                    _buildProfileItem(
                      icon: Icons.delete_sweep, // Ikon untuk hapus cache
                      title: 'Hapus Cache',
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: _clearCache, // Menangani klik hapus cache
                    ),
                    _buildProfileItem(
                      icon: Icons.info, // Ikon untuk tentang kami
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
                      icon: Icons.question_answer, // Ikon untuk FAQ
                      title: 'FAQ',
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FAQScreen()), // Menampilkan layar FAQ
                        );
                      },
                    ),
                    _buildProfileItem(
                      icon: Icons.privacy_tip, // Ikon untuk kebijakan privasi
                      title: 'Kebijakan Privasi',
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()), // Menampilkan layar kebijakan privasi
                        );
                      },
                    ),
                    _buildProfileItem(
                      icon: Icons.phone, // Ikon untuk kontak admin
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()), // Navigasi ke halaman utama
                                (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Log Out'), // Tombol logout
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Fungsi untuk membangun item profil dengan ikon, judul, subtitle, dan trailing widget
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
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: trailing,
          onTap: onTap, // Menangani klik pada item profil
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1.0, // Garis pemisah di bawah item
        ),
      ],
    );
  }
}
