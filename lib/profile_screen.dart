import 'package:flutter/material.dart';
import 'GoogleSheetsServiceLOGIN.dart';
import 'home_page.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, String>> userDetailsFuture;

  @override
  void initState() {
    super.initState();
    userDetailsFuture = _fetchUserDetails(widget.username);
  }

  Future<Map<String, String>> _fetchUserDetails(String username) async {
    final googleSheetsService = GoogleSheetsServiceLOGIN(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
    try {
      final userDetails = await googleSheetsService.fetchUserDetails(username);
      return userDetails;
    } catch (e) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, String>>(
        future: userDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final userDetails = snapshot.data ?? {};
          final nik = userDetails['NIK'] ?? 'Unknown';
          final nama = userDetails['NAMA'] ?? 'Unknown';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/user.png'),
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
                    leading: Icon(Icons.perm_identity),
                    title: Text('ID NIK'),
                    trailing: Text(nik),
                  ),
                  ListTile(
                    leading: Icon(Icons.perm_identity),
                    title: Text('NAMA LENGKAP'),
                    trailing: Text(nama),
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
                    icon: Icons.delete_sweep,
                    title: 'Hapus Cache',
                    subtitle: '39.15MB',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  _buildProfileItem(
                    icon: Icons.lock,
                    title: 'Ubah Kata Sandi',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  _buildProfileItem(
                    icon: Icons.info,
                    title: 'Tentang Kami',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  _buildProfileItem(
                    icon: Icons.question_answer,
                    title: 'FAQ',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  _buildProfileItem(
                    icon: Icons.privacy_tip,
                    title: 'Kebijakan Privasi',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  _buildProfileItem(
                    icon: Icons.phone,
                    title: 'Hubungi Kami',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  _buildProfileItem(
                    icon: Icons.share,
                    title: 'Bagikan',
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Keluar'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
    );
  }
}
